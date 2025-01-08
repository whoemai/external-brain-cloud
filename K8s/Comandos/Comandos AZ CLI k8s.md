#kubernetes #comandos

1. **Criar um cluster AKS:**
   ```bash
   az aks create --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos> --node-count <número-de-nós> --location <localização> --kubernetes-version <versão-do-kubernetes> --generate-ssh-keys
   ```

2. **Mudar o número de nós em um cluster AKS:**
   ```bash
   az aks scale --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos> --node-count <novo-número-de-nós>
   ```

3. **Obter atualizações disponíveis para o cluster:**
   ```bash
   az aks get-upgrades --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos> --output table
   ```

4. **Aplicar atualização ao cluster:**
   ```bash
   az aks upgrade --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos> --kubernetes-version <nova-versão-do-kubernetes>
   ```

5. **Criar um registro de imagens de container (ACR):**
   ```bash
   az acr create --name <nome-do-registro> --resource-group <nome-do-grupo-de-recursos> --sku Basic --location <localização>
   ```

6. **Listar os clusters AKS:**
   ```bash
   az aks list --output table
   ```

7. **Obter informações detalhadas de um cluster AKS:**
   ```bash
   az aks show --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos>
   ```

8. **Deletar um cluster AKS:**
   ```bash
   az aks delete --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos>
   ```

9. **Conectar-se a um cluster AKS:**
   ```bash
   az aks get-credentials --name <nome-do-cluster> --resource-group <nome-do-grupo-de-recursos>
   ```
