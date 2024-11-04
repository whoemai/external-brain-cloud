#kubernetes 

Um **ReplicaSet** no Kubernetes é um controlador que garante que um número especificado de réplicas de um pod esteja sempre em execução. Ele é usado principalmente para garantir a alta disponibilidade e a escalabilidade horizontal dos aplicativos.

### Como Funciona

- **Definição**: Um ReplicaSet é definido por um seletor que identifica quais pods ele gerencia, um número de réplicas que devem ser mantidas, e um template de pod que especifica as configurações dos novos pods a serem criados.
- **Operação**: Ele cria e deleta pods conforme necessário para manter o número desejado de réplicas. [Se um pod falhar ou for encerrado, o ReplicaSet cria automaticamente um novo pod para substituí-lo](https://kubernetes.io/pt-br/docs/concepts/workloads/controllers/replicaset/)[1](https://kubernetes.io/pt-br/docs/concepts/workloads/controllers/replicaset/)[2](https://www.clubedolinux.com.br/como-usar-replicasets-para-escalabilidade-no-kubernetes-conceito-e-beneficios/).

### Quando Usar

[Embora os ReplicaSets sejam úteis, geralmente é recomendado usar **Deployments**, que são um nível superior de abstração e gerenciam ReplicaSets, oferecendo funcionalidades adicionais como atualizações declarativas](https://kubernetes.io/pt-br/docs/concepts/workloads/controllers/replicaset/)[1](https://kubernetes.io/pt-br/docs/concepts/workloads/controllers/replicaset/).