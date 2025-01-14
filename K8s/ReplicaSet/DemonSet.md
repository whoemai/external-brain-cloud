#kubernetes #ReplicaSet 

O `DaemonSet` é muito útil para executar `Pods` que precisam ser executados em todos os nós do cluster, como por exemplo, um `Pod` que faz o monitoramento de logs, ou um `Pod` que faz o monitoramento de métricas.

Alguns casos de uso de `DaemonSets` são:

- Execução de agentes de monitoramento, como o `Prometheus Node Exporter` ou o `Fluentd`.
- Execução de um proxy de rede em todos os nós do cluster, como `kube-proxy`, `Weave Net`, `Calico` ou `Flannel`.
- Execução de agentes de segurança em cada nó do cluster, como `Falco` ou `Sysdig`.

Portanto, se nosso cluster possuir 3 nós, o `DaemonSet` vai garantir que todos os nós executem uma réplica do `Pod` que ele está gerenciando, ou seja, 3 réplicas do `Pod`.

Caso adicionemos mais um `node` ao cluster, o `DaemonSet` vai garantir que todos os nós executem uma réplica do `Pod` que ele está gerenciando, ou seja, 4 réplicas do `Pod`.