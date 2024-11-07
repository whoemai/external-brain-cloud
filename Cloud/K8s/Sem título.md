#kubernetes 

![[Pasted image 20241107151700.png]]
## O que é um StatefulSet no Kubernetes?

Um **StatefulSet** é um objeto de API do Kubernetes usado para gerenciar aplicativos com estado. Ele é ideal para aplicações que precisam de armazenamento persistente ou uma identidade de rede estável e única. [Diferente de um [[Deployments], que gerencia pods intercambiáveis, um StatefulSet mantém uma identidade fixa para cada pod, o que é crucial para aplicativos que dependem de dados persistentes](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)[1](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).

## Quando usar um StatefulSet em vez de um Deployment?

Você deve usar um **StatefulSet** nos seguintes casos:

- **Identidade de Rede Estável**: Cada pod tem um nome DNS único que é persistente.
- **Armazenamento Persistente**: Os volumes de armazenamento são mantidos mesmo que os pods sejam recriados.
- **Desdobramento e Escalonamento Ordenados**: Os pods são criados, escalados e atualizados em uma ordem específica.
- **Aplicações com Estado**: Ideal para bancos de dados como MySQL, MongoDB, Cassandra, etc.

Por outro lado, um **Deployment** é mais adequado para aplicativos sem estado, onde os pods são intercambiáveis e não precisam de armazenamento persistente.

## Exemplo de YAML para criação de um StatefulSet na Azure

Aqui está um exemplo de YAML para criar um StatefulSet no Kubernetes, que pode ser usado na Azure:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx
  serviceName: "nginx"
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: registry.k8s.io/nginx-slim:0.24
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: "my-storage-class"
      resources:
        requests:
          storage: 1Gi
```

[Este exemplo cria um StatefulSet com três réplicas de um contêiner Nginx, cada uma com seu próprio volume persistente](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)[1](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).