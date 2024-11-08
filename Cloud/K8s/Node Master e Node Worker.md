#kubernetes 
## Diferença entre Node Master e Node Worker

**Node Master**:

- **Função Principal**: Gerencia o cluster Kubernetes.
- **Componentes**:
    - **API Server**: Ponto de comunicação para comandos do Kubernetes.
    - **Scheduler**: Decide em quais nodes os pods serão executados.
    - **Controller Manager**: Monitora e mantém o estado desejado do cluster.
    - **etcd**: Armazena dados de configuração e estado do cluster.

**Node Worker**:

- **Função Principal**: Executa as aplicações em contêineres.
- **Componentes**:
    - **Kubelet**: Gerencia os contêineres no node.
    - **Kube-proxy**: Mantém as regras de rede para comunicação entre pods.
    - **Container Runtime**: Executa os contêineres (ex.: Docker, containerd).

## Por que focar nos Nodes Worker no AKS?

Quando você cria um cluster AKS (Azure Kubernetes Service), a Azure gerencia automaticamente os nodes master para você. Isso significa que você não precisa se preocupar com a configuração, manutenção ou escalabilidade dos nodes master. Seu foco deve ser nos nodes worker porque:

1. **Execução de Aplicações**: Os nodes worker são onde suas aplicações realmente rodam. Garantir que eles tenham recursos suficientes (CPU, memória) é crucial para o desempenho das suas aplicações.
2. **Escalabilidade**: Você pode adicionar ou remover nodes worker conforme a demanda das suas aplicações, permitindo flexibilidade e otimização de custos.
3. **Manutenção**: Monitorar a saúde e o desempenho dos nodes worker ajuda a garantir que suas aplicações estejam sempre disponíveis e funcionando corretamente.

[Em resumo, enquanto a Azure cuida dos nodes master, você pode se concentrar em gerenciar e otimizar os nodes worker para garantir que suas aplicações rodem de forma eficiente e confiável](https://www.startkubernetes.com/blog/k8s_master_and_worker_nodes)[1](https://www.startkubernetes.com/blog/k8s_master_and_worker_nodes)[2](https://docs.openshift.com/container-platform/4.9/nodes/index.html).