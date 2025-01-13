#kubernetes #Deployment 

A estratégia de **Recreate** em Kubernetes é um método de atualização mais simples e direta comparado ao RollingUpdate. 

Aqui estão os pontos principais dessa estratégia:

- **Interrupção Temporária:** Os pods existentes são deletados antes que novos pods sejam criados. Isso resulta em uma breve interrupção do serviço.
- **Sem Sobreposição:** Diferente do RollingUpdate, não há pods antigos e novos coexistindo. Uma versão é totalmente substituída pela nova.
- **Simplicidade:** É mais fácil de configurar e entender, ideal para cenários onde a interrupção temporária é aceitável.

Essa abordagem pode ser útil em casos onde a aplicação não pode ter versões diferentes rodando ao mesmo tempo, ou onde a interrupção do serviço não causa problemas significativos.

Um exemplo de como seria uma definição YAML para um deployment em Kubernetes utilizando a estratégia de **Recreate**:

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
    type: Recreate
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

Explicando os principais elementos:
- `strategy.type: Recreate`: Indica que a estratégia de atualização é `Recreate`.
- **Processo de Atualização**: Todos os pods existentes são deletados antes de criar novos, resultando em uma interrupção temporária do serviço.

Essa configuração é mais direta e pode ser útil quando não é permitido ter diferentes versões da aplicação rodando ao mesmo tempo.