#kubernetes 

![[Pasted image 20241104163133.png]]
Um **Deployment** no Kubernetes é um recurso de alto nível que gerencia a implantação e a atualização de aplicativos contêinerizados. Ele permite definir o estado desejado de um conjunto de pods e garante que esse estado seja mantido ao longo do tempo.

### Principais Funcionalidades

- [**Gerenciamento de Réplicas**: O Deployment cria e gerencia um ReplicaSet, que por sua vez garante que o número especificado de réplicas de um pod esteja sempre em execução](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais)[1](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais).
- [**Atualizações Declarativas**: Permite realizar atualizações de forma controlada e segura, como as atualizações rolling, onde os pods são atualizados gradualmente para minimizar o tempo de inatividade](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais)[2](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/).
- [**Rollback**: Facilita o rollback para versões anteriores em caso de falhas, garantindo a estabilidade do aplicativo](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais)[2](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/).

### Como Funciona

1. **Definição**: Você define um Deployment usando um arquivo YAML que especifica o número de réplicas, a imagem do contêiner, e outras configurações necessárias.
2. **Aplicação**: Quando o Deployment é aplicado, o Kubernetes cria um ReplicaSet com base nas especificações fornecidas.
3. [**Monitoramento**: O Deployment monitora continuamente o estado dos pods e realiza ações corretivas para garantir que o estado desejado seja mantido](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais)[1](https://gasparbarancelli.com/post/entendendo-o-deployment-no-kubernetes-conceitos-fundamentais).

### Exemplo de YAML para um Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

