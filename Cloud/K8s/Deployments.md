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

### 1. **Atualizações Declarativas**

[Os Deployments permitem realizar atualizações de forma controlada e segura, como as atualizações rolling, onde os pods são atualizados gradualmente para minimizar o tempo de inatividade](https://www.youtube.com/watch?v=y_vy9NVeCzo)[1](https://www.youtube.com/watch?v=y_vy9NVeCzo).

### 2. **Rollback Fácil**

[Se algo der errado durante uma atualização, você pode facilmente reverter para uma versão anterior do seu aplicativo, garantindo a estabilidade do sistema](https://www.youtube.com/watch?v=9BP48rYQaIY)[2](https://www.youtube.com/watch?v=9BP48rYQaIY).

### 3. **Escalabilidade Automática**

[Deployments facilitam a escalabilidade horizontal dos aplicativos, permitindo aumentar ou diminuir o número de réplicas dos pods conforme necessário para atender à demanda](https://www.youtube.com/watch?v=y_vy9NVeCzo)[1](https://www.youtube.com/watch?v=y_vy9NVeCzo).

### 4. **Autocorreção**

O Deployment monitora continuamente o estado dos pods e realiza ações corretivas para garantir que o estado desejado seja mantido. [Se um pod falhar, ele será automaticamente substituído](https://www.youtube.com/watch?v=9BP48rYQaIY)[2](https://www.youtube.com/watch?v=9BP48rYQaIY).

### 5. **Gerenciamento Simplificado**

[Com Deployments, você pode gerenciar o ciclo de vida completo dos aplicativos, desde a implantação inicial até as atualizações e a manutenção contínua](https://www.youtube.com/watch?v=y_vy9NVeCzo)[1](https://www.youtube.com/watch?v=y_vy9NVeCzo).

Essas funcionalidades tornam os Deployments uma ferramenta poderosa para gerenciar aplicativos contêinerizados de forma eficiente e confiável.


## Comandos 
### 1. **Criar um Deployment**

```sh
kubectl create deployment <nome-do-deployment> --image=<imagem-do-container>
```

Exemplo:

```sh
kubectl create deployment nginx-deployment --image=nginx:latest
```

### 2. **Listar Deployments**

```sh
kubectl get deployments
```

### 3. **Ver Detalhes de um Deployment**

```sh
kubectl describe deployment <nome-do-deployment>
```

### 4. **Atualizar um Deployment**

Para atualizar a imagem de um contêiner em um Deployment:

```sh
kubectl set image deployment/<nome-do-deployment> <nome-do-container>=<nova-imagem>
```

Exemplo:

```sh
kubectl set image deployment/nginx-deployment nginx=nginx:1.19.0
```

### 5. **Escalar um Deployment**

Para ajustar o número de réplicas:

```sh
kubectl scale deployment <nome-do-deployment> --replicas=<número-de-réplicas>
```

Exemplo:

```sh
kubectl scale deployment nginx-deployment --replicas=5
```

### 6. **Deletar um Deployment**

```sh
kubectl delete deployment <nome-do-deployment>
```

### 7. **Verificar o Status dos Pods**

Para verificar os pods gerenciados pelo Deployment:

```sh
kubectl get pods
```

### 8. **Verificar o histórico de um deployment**

Para verificar o histórico de um Deployment:

```sh
kubectl rollout history deployment <nome-do-deployment>
```

