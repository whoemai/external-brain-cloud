#kubernetes #probes
## O que são Liveness Probes no Kubernetes?

**Liveness Probes** são mecanismos no Kubernetes que monitoram a saúde dos containers em execução dentro de um pod. O objetivo principal é detectar quando um container não está funcionando como esperado e, se necessário, reiniciá-lo. [Isso ajuda a garantir que os containers estejam sempre operacionais e possam responder a solicitações](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[1](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[2](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/).
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