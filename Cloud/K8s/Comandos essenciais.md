#Kubernetes
### Gerenciamento de Pods e Deployments

- **Listar todos os pods:**
    
    ```sh
    kubectl get pods
    ```
    
- **Criar um deployment:**
    
    ```sh
    kubectl create deployment nome-do-deployment --image=imagem
    ```
    
- **Escalar um deployment:**
    
    ```sh
    kubectl scale deployment nome-do-deployment --replicas=3
    ```
    
- **Atualizar um deployment:**
    
    ```sh
    kubectl set image deployment/nome-do-deployment container=imagem:versao
    ```
    

### Inspeção e Debug

- **Descrever um pod:**
    
    ```sh
    kubectl describe pod nome-do-pod
    ```
    
- **Ver logs de um pod:**
    
    ```sh
    kubectl logs nome-do-pod
    ```
    
- **Acessar um shell dentro de um pod:**
    
    ```sh
    kubectl exec -it nome-do-pod -- /bin/bash
    ```
    

### Gerenciamento de Configurações

- **Listar contextos disponíveis:**
    
    ```sh
    kubectl config get-contexts
    ```
    
- **Mudar de contexto:**
    
    ```sh
    kubectl config use-context nome-do-contexto
    ```
    
- **Ver o contexto atual:**
    
    ```sh
    kubectl config current-context
    ```
    

### Gerenciamento de Namespaces

- **Listar namespaces:**
    
    ```sh
    kubectl get namespaces
    ```
    
- **Criar um namespace:**
    
    ```sh
    kubectl create namespace nome-do-namespace
    ```
    
- **Mudar o namespace atual:**
    
    ```sh
    kubectl config set-context --current --namespace=nome-do-namespace
    ```
    

### Gerenciamento de Serviços e Ingress

- **Listar serviços:**
    
    ```sh
    kubectl get services
    ```
    
- **Criar um serviço:**
    
    ```sh
    kubectl expose deployment nome-do-deployment --type=LoadBalancer --port=80
    ```
    
- **Listar ingress:**
    
    ```sh
    kubectl get ingress
    ```
    

[Esses comandos cobrem muitas das operações diárias que você pode precisar realizar em um cluster Kubernetes](https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/)[1](https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/)[2](https://www.digitalocean.com/community/cheatsheets/getting-started-with-kubernetes-a-kubectl-cheat-sheet-pt). Se precisar de mais detalhes ou ajuda com algum comando específico, estou à disposição!