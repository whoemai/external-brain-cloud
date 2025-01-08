#kubernetes #probes
## O que são Liveness Probes no Kubernetes?

**Liveness Probes** são mecanismos no Kubernetes que monitoram a saúde dos containers em execução dentro de um pod. O objetivo principal é detectar quando um container não está funcionando como esperado e, se necessário, reiniciá-lo. [Isso ajuda a garantir que os containers estejam sempre operacionais e possam responder a solicitações](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[1](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[2](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/).

## Quando configurar Liveness Probes?

Você deve configurar Liveness Probes em situações onde é crucial garantir que o container esteja sempre em um estado funcional. Aqui estão alguns casos recomendados:

1. [**Aplicações com Deadlocks**: Se sua aplicação pode entrar em um estado de deadlock (onde está rodando, mas não consegue progredir), uma Liveness Probe pode detectar isso e reiniciar o container](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[1](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).
2. [**Aplicações de Longa Duração**: Aplicações que rodam por longos períodos podem eventualmente entrar em estados quebrados dos quais não conseguem se recuperar sem um restart](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[2](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/).
3. **Serviços Críticos**: Para serviços que precisam estar sempre disponíveis, configurar uma Liveness Probe pode ajudar a manter a alta disponibilidade.

## Configurar Liveness Probes em todos os pods?

Não é necessário configurar Liveness Probes em todos os pods. A decisão deve ser baseada na criticidade do serviço e na probabilidade de falhas que não podem ser recuperadas sem um restart. Em geral:

- **Sim**: Para serviços críticos e aplicações suscetíveis a deadlocks ou falhas irreparáveis.
- **Não**: Para aplicações simples ou onde a falha pode ser tratada de outras maneiras (como através de Readiness Probes ou mecanismos de retry).

## Exemplos de Configuração

Aqui está um exemplo básico de configuração de uma Liveness Probe usando uma requisição HTTP:

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 3
  periodSeconds: 3
```

Neste exemplo, o Kubernetes faz uma requisição HTTP para o endpoint `/healthz` no container. [Se a resposta não for satisfatória, o container será reiniciado](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[3](https://dev.to/yusadolat/observability-in-kubernetes-understanding-liveness-probes-with-examples-2el4).