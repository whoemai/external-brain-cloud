#kubernetes #comandos 
### Comandos de Inicialização e Configuração:

- **`kubectl version`**: Verifica a versão do `kubectl` e do servidor Kubernetes.
- **`kubectl cluster-info`**: Exibe informações sobre o cluster.
- **`kubectl config view`**: Mostra as configurações do kubeconfig.
- **`kubectl config get-contexts`**: Lista todos os contextos disponíveis.
- **`kubectl config current-context`**: Mostra o contexto atual.
- **`kubectl config use-context [contexto]`**: Define o contexto padrão.

### Comandos de Gerenciamento de Pods:

- **`kubectl get pods`**: Lista todos os pods no namespace atual.
- **`kubectl describe pod [nome_do_pod]`**: Mostra detalhes sobre um pod específico.
- **`kubectl logs [nome_do_pod]`**: Exibe os logs de um pod.
- **`kubectl exec -it [nome_do_pod] -- /bin/bash`**: Acessa o shell de um contêiner em um pod.

### Comandos de Gerenciamento de Deployments:

- **`kubectl get deployments`**: Lista todos os deployments no namespace atual.
- **`kubectl describe deployment [nome_do_deployment]`**: Mostra detalhes sobre um deployment específico.
- **`kubectl apply -f [arquivo.yaml]`**: Aplica as configurações de um arquivo YAML.
- **`kubectl delete deployment [nome_do_deployment]`**: Remove um deployment.

### Comandos de Gerenciamento de Serviços:

- **`kubectl get services`**: Lista todos os serviços no namespace atual.
- **`kubectl describe service [nome_do_serviço]`**: Mostra detalhes sobre um serviço específico.
- **`kubectl expose deployment [nome_do_deployment] --type=[tipo] --port=[porta]`**: Cria um serviço para expor um deployment.

### Comandos de Gerenciamento de Namespaces:

- **`kubectl get namespaces`**: Lista todos os namespaces.
- **`kubectl create namespace [nome_do_namespace]`**: Cria um novo namespace.
- **`kubectl delete namespace [nome_do_namespace]`**: Remove um namespace.

### Comandos de Gerenciamento de Recursos:

- **`kubectl get [recurso]`**: Lista todos os recursos de um tipo específico (por exemplo, `pods`, `services`, `deployments`).
- **`kubectl describe [recurso] [nome_do_recurso]`**: Mostra detalhes sobre um recurso específico.
- **`kubectl delete [recurso] [nome_do_recurso]`**: Remove um recurso específico.

### Comandos de navegação
- **`kubectl config use-context [nome_do_contexto]`**: Este comando permite que você alterne entre diferentes clusters ou namespaces conforme necessário.