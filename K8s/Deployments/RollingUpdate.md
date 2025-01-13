#kubernetes #Deployment 
**RollingUpdate** em Kubernetes (k8s) é usada para atualizar de forma gradual as versões dos pods de um deployment, sem causar interrupções no serviço. Aqui estão os principais pontos dessa estratégia:

- **Atualização Gradual:** Substitui os pods antigos por novos de maneira contínua, um por um ou em pequenos lotes.
- **Controle de Disrupção:** Define o número máximo de pods que podem ser indisponíveis durante a atualização e o número de pods que podem ser criados além da quantidade original.
- **Parâmetros Personalizáveis:** É possível ajustar a taxa de atualização com os parâmetros `maxUnavailable` e `maxSurge`, para um controle mais preciso sobre a disponibilidade e a capacidade durante a atualização.
- **Rollbacks Automáticos:** Se algo der errado durante a atualização, Kubernetes pode reverter automaticamente para a versão anterior dos pods.

Essa estratégia é bastante eficaz para minimizar interrupções e garantir que o serviço continue funcionando durante a atualização. 

Um exemplo de como seria uma definição YAML para um deployment em Kubernetes utilizando a estratégia de **RollingUpdate**:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minha-aplicacao
spec:
  replicas: 3
  selector:
    matchLabels:
      app: minha-aplicacao
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: minha-aplicacao
    spec:
      containers:
      - name: minha-aplicacao
        image: minha-imagem:1.0
        ports:
        - containerPort: 8080
```

Vamos destrinchar os principais elementos:
- `rollingUpdate`: Especifica a configuração da atualização gradual.
  - `maxUnavailable`: O número máximo de pods que podem estar indisponíveis durante a atualização (neste exemplo, 1).
  - `maxSurge`: O número máximo de pods que podem ser criados além da quantidade original (neste exemplo, 1).

Isso garantirá que sua aplicação seja atualizada de forma contínua e segura, mantendo a disponibilidade do serviço. Precisa de mais alguma coisa?