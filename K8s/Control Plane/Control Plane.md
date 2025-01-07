#kubernetes 
### Control Plane no Kubernetes (K8s)

**O que é:**
**Funções do Control Plane:**
1. **API Server**: Serve como ponto de comunicação central para comandos do Kubernetes, recebendo e validando solicitações.
2. **etcd**: Armazena todas as informações de configuração e estado do cluster em um banco de dados chave-valor distribuído.
3. **Scheduler**: Responsável por atribuir pods a nodes específicos, decidindo onde cada aplicação deve rodar com base em fatores como recursos disponíveis.
4. **Controller Manager**: Monitora o estado do cluster e realiza ações corretivas para garantir que o estado atual do sistema corresponda ao estado desejado.

**Atuação no AKS:**
- **Gerenciamento Automático**: No AKS, a Microsoft Azure gerencia o control plane automaticamente, o que significa que você não precisa se preocupar com a configuração, manutenção ou atualização desses componentes críticos.
- **Escalabilidade e Atualizações**: A Azure também cuida da escalabilidade do control plane, ajustando conforme necessário para manter a performance do cluster. Além disso, ela aplica atualizações e patches de segurança automaticamente.
- **Foco no Aplicativo**: Com a Azure gerenciando o control plane, você pode focar no desenvolvimento e operação de suas aplicações, sem se preocupar com a infraestrutura subjacente.

Resumindo, o control plane é essencial para o funcionamento do Kubernetes, e no AKS a Azure garante que ele esteja sempre otimizado e seguro, permitindo que você se concentre no que importa mais: suas aplicações.