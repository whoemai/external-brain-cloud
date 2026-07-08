# KEDA vs. HPA nativo: escalando por causa, não por sintoma

*Nomes de serviço, namespace e valores exatos foram trocados por fictícios; a
estrutura da configuração e o comportamento observado são reais, de um serviço Java
em produção rodando há alguns dias sob essa configuração.*

## O contexto

`storefront-web` é uma aplicação Java (Spring Boot) que roda em EKS, atrás de um
Ingress, com tráfego direto de usuário. Até pouco tempo atrás ela rodava com
**12 réplicas fixas, 24 horas por dia** — sem HPA, sem KEDA, sem nada. Dimensionamento
manual, pensado pro pico, pago o dia inteiro independente do tráfego real.

A pergunta óbvia era "por que não HPA nativo?". A resposta rápida é: colocamos, mas
ele resolve só metade do problema.

## Por que o HPA nativo não é suficiente aqui

O HPA nativo, na configuração mais comum, escala por uma de duas métricas:

- **CPU** do container (via `metrics-server`)
- **Memória** do container (via `metrics-server`)

Para uma aplicação Java isso é um ponto cego perigoso. O motivo: memória do
*container* (working set) e memória do *heap gerenciado pela JVM* são coisas
diferentes. O heap pode estar folgado (G1 Old Gen em 20% de uso, por exemplo) enquanto
a memória real do processo — heap + off-heap + metaspace + stacks de thread + buffers
diretos (comuns em clientes HTTP, serialização, agentes de APM) — já está em 65-70%
do limite do container. Sem visibilidade nesse segundo número, o HPA não escala, o
container segue subindo, e o resultado é um `OOMKilled` que aparenta ter vindo do
nada.

Foi exatamente esse cenário que motivou revisar a estratégia de scaling depois de um
incidente: pods de `storefront-web` levando `OOMKilled` em cascata, travando o rollout
(pods novos não passavam no `readinessProbe` a tempo, o `Deployment` nunca estabilizava),
enquanto o heap da JVM nunca chegou perto do limite configurado.

## A saída: KEDA com múltiplos triggers

[KEDA](https://keda.sh) estende o HPA por meio de um CRD, o `ScaledObject`. Na prática
ele:

1. Registra uma métrica externa por *trigger* configurado (Prometheus, SQS, Kafka,
   cron, e dezenas de outras fontes) automaticamente — sem você precisar rodar e
   manter um `prometheus-adapter` com regras de tradução pra cada métrica.
2. Gera e gerencia um `HorizontalPodAutoscaler` nos bastidores, então todo o
   comportamento de scale-up/scale-down (`behavior`, `stabilizationWindow`,
   políticas) continua sendo HPA puro — você não perde nada do que já conhece.
3. Permite múltiplos triggers no mesmo `ScaledObject`: se qualquer um deles estourar o
   threshold, o HPA escala.

O `ScaledObject` de `storefront-web` hoje combina 4 sinais independentes:

```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: storefront-web
  namespace: storefront
spec:
  scaleTargetRef:
    name: storefront-web
  minReplicaCount: 6
  maxReplicaCount: 16
  pollingInterval: 30
  cooldownPeriod: 300
  advanced:
    horizontalPodAutoscalerConfig:
      behavior:
        scaleDown:
          stabilizationWindowSeconds: 300
          policies:
            - type: Pods
              value: 1
              periodSeconds: 120
        scaleUp:
          stabilizationWindowSeconds: 60
          policies:
            - type: Pods
              value: 1
              periodSeconds: 60
  triggers:
    # 1. Sinal primário: req/s médio por pod.
    - type: prometheus
      metricType: Value
      metadata:
        serverAddress: http://prometheus.monitoring.svc.cluster.local:9090
        metricName: http_requests_per_pod
        threshold: "40"
        query: >-
          sum(rate(http_server_requests_seconds_count{namespace="storefront",pod=~"storefront-web-.+"}[2m]))
          /
          count(kube_pod_info{namespace="storefront",pod=~"storefront-web-.+"})

    # 2. JVM Heap %: só G1 Old Gen (Eden/Survivor exportam max=-1 e corrompem a média).
    - type: prometheus
      metricType: Value
      metadata:
        serverAddress: http://prometheus.monitoring.svc.cluster.local:9090
        metricName: jvm_heap_usage_percent
        threshold: "75"
        query: >-
          max(
            jvm_memory_used_bytes{namespace="storefront",pod=~"storefront-web-.+",id="G1 Old Gen"}
            /
            jvm_memory_max_bytes{namespace="storefront",pod=~"storefront-web-.+",id="G1 Old Gen"}
          ) * 100

    # 3. CPU: proxy via process_cpu_usage (sem limit de CPU configurado no container).
    - type: prometheus
      metricType: Value
      metadata:
        serverAddress: http://prometheus.monitoring.svc.cluster.local:9090
        metricName: process_cpu_usage_percent
        threshold: "70"
        query: >-
          max(process_cpu_usage{namespace="storefront",pod=~"storefront-web-.+"}) * 100

    # 4. Memória REAL do container (working set via cAdvisor), como % do limite.
    #    Esse é o trigger que o HPA nativo não teria: pega off-heap/metaspace/threads
    #    que o trigger de heap (#2) não enxerga.
    - type: prometheus
      metricType: Value
      metadata:
        serverAddress: http://prometheus.monitoring.svc.cluster.local:9090
        metricName: container_memory_usage_percent
        threshold: "75"
        query: >-
          max(
            container_memory_working_set_bytes{namespace="storefront",pod=~"storefront-web-.+",container="storefront-web"}
            /
            on(namespace, pod, container) kube_pod_container_resource_limits{namespace="storefront",pod=~"storefront-web-.+",container="storefront-web",resource="memory"}
          ) * 100
```

Alguns detalhes que valem explicação:

- **`metricType: Value`** (em vez de `AverageValue`) em todos os triggers: como cada
  query já normaliza pra "por pod" (trigger 1) ou já é uma porcentagem/proxy que não
  escala linearmente com o número de réplicas (triggers 2-4), usar `AverageValue`
  dividiria o valor pela contagem de réplicas de novo — dado errado. `Value` usa o
  número calculado direto contra o threshold.
- **`stabilizationWindow` assimétrico** (60s pra subir, 300s pra descer) e políticas
  de 1 pod por período: prioriza reagir rápido a pico de carga e descer devagar,
  evitando ficar tirando e colocando réplica (flapping) em uma métrica que oscila.
- **Sem `limits.cpu`** no container: por isso o trigger de CPU usa
  `process_cpu_usage` (métrica exposta pelo Micrometer/Actuator, 0-1 já normalizado)
  em vez de comparar contra um limit que não existe.

## O que isso mudou na prática (dados reais, 3 dias de observação)

| Período | Réplicas | Comportamento |
|---|---|---|
| Antes (HPA/scaling manual, fixo) | 12 constante | Nenhuma elasticidade — mesma capacidade de madrugada e em pico |
| Depois — madrugada / baixo tráfego | 6-7 | `minReplicaCount` respeitado, sem desperdício |
| Depois — horário comercial | 8-9 | Sobe e desce acompanhando req/s real |
| Depois — durante o incidente de memória | 14-17 | Todos os triggers reagindo (inclusive o de memória de container) |

No momento em que este artigo foi escrito, o painel do HPA mostrava algo como:

```
Metrics: ( current / target )
  requests/s por pod:        39.1 / 40    <- pilotando o scaling agora
  heap JVM (G1 Old Gen):     18.9 / 75    <- folgado
  CPU (process_cpu_usage):   65.3 / 70    <- próximo
  memória real do container: 68.8 / 75    <- próximo
```

Repare a diferença entre a linha 2 (heap) e a linha 4 (memória real do container):
**heap em ~19% e memória do container em ~69%, ao mesmo tempo.** Esse é o cenário
exato que motivou o trigger #4. Um setup que escalasse só por heap JVM — que é,
honestamente, a métrica "óbvia" pra quem vem do mundo Java — estaria completamente
cego pra essa pressão de memória.

## Nem tudo saiu perfeito de primeira

Vale ser honesto: o threshold de req/s por pod (40) ficou bem em cima do valor de
regime da aplicação em horário comercial. Isso gerou algumas trocas de réplica
(`9 → 8 → 7 → 8 → 9`) em poucas horas — não é errado, mas é sinal de que o threshold
está no "joelho" da curva e merece um ajuste (subir um pouco o valor, ou aumentar a
tolerância do HPA) pra reduzir o vaivém. Autoscaling não é "configura uma vez e
esquece" — é um sistema que se observa e se ajusta com o tempo, como qualquer outro.

## HPA nativo vs. KEDA — resumo

| | HPA nativo | KEDA |
|---|---|---|
| Múltiplas métricas custom no mesmo HPA | Sim, mas cada uma precisa de um adapter de custom/external metrics configurado e mantido à parte (ex.: `prometheus-adapter` com regras YAML por métrica) | Sim, nativamente — cada `trigger` no `ScaledObject` já expõe a métrica externa sozinho |
| Fontes suportadas | O que o seu metrics adapter souber expor | ~70 *scalers* prontos (Prometheus, SQS, Kafka, cron, RabbitMQ, Postgres, etc.) |
| Scale-to-zero | Não | Sim (não usamos aqui, `minReplicaCount: 6`, mas é uma opção real para workloads orientadas a evento) |
| Comportamento de scale up/down (`behavior`) | HPA v2 padrão | Idêntico — KEDA gera um HPA por baixo, você não perde essa configuração |
| Operação | Você mantém o adapter + as regras de métrica | Você mantém só o `ScaledObject` (CRD declarativo) |

A conclusão não é "HPA nativo é ruim" — é que, pra combinar sinais de fontes
heterogêneas (uma métrica de negócio, uma de JVM, uma de infraestrutura) sem manter um
metrics-adapter customizado por métrica, KEDA tira esse trabalho operacional do
caminho e deixa a configuração declarativa, versionada e fácil de revisar em PR — que,
no fim, é o que faz autoscaling ser algo em que dá pra confiar em produção.
