#kubernetes 

Um **ConfigMap** no Kubernetes é um objeto da API usado para armazenar dados de configuração em pares chave-valor. [Ele permite que você separe as configurações específicas do ambiente do código do aplicativo, facilitando a portabilidade dos contêineres](https://kubernetes.io/docs/concepts/configuration/configmap/)[1](https://kubernetes.io/docs/concepts/configuration/configmap/).

![[Pasted image 20241028143519.png]]
### Principais Características do ConfigMap:

- [**Armazenamento de Dados**: Pode armazenar dados como variáveis de ambiente, argumentos de linha de comando ou arquivos de configuração em um volume](https://kubernetes.io/docs/concepts/configuration/configmap/)[1](https://kubernetes.io/docs/concepts/configuration/configmap/).
- [**Separação de Configuração**: Ajuda a desacoplar a configuração do ambiente do conteúdo da imagem do contêiner](https://kubernetes.io/pt-br/docs/tasks/configure-pod-container/configure-pod-configmap/)[2](https://kubernetes.io/pt-br/docs/tasks/configure-pod-container/configure-pod-configmap/).
- [**Limitações**: Não é adequado para dados confidenciais (use Secrets para isso) e tem um limite de 1 MiB para o tamanho dos dados](https://kubernetes.io/docs/concepts/configuration/configmap/)[1](https://kubernetes.io/docs/concepts/configuration/configmap/).

### Exemplo de Uso:

[Você pode criar um ConfigMap usando o comando `kubectl create configmap` e referenciá-lo em um Pod para configurar os contêineres com os dados armazenados](https://kubernetes.io/pt-br/docs/tasks/configure-pod-container/configure-pod-configmap/)[2](https://kubernetes.io/pt-br/docs/tasks/configure-pod-container/configure-pod-configmap/).