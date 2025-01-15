#kubernetes #probes
## O que são Readiness Probes?

**Readiness Probes** são verificações de saúde que determinam se um container está pronto para começar a receber tráfego. [Diferente das Liveness Probes, que verificam se o container está vivo, as Readiness Probes focam em garantir que o container esteja em um estado funcional e pronto para atender solicitações](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[1](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)[2](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/).
## Exemplos de Configuração

Aqui está um exemplo básico de configuração de uma Readiness Probe usando uma requisição HTTP:

```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

Neste exemplo, o Kubernetes faz uma requisição HTTP para o endpoint `/ready` no container. [Se a resposta for satisfatória, o container é considerado pronto para receber tráfego](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/)[2](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/).