#kubernetes #kyverno #policy 
# Exemplo de Política: Adição de Label ao Namespace

A política **add-label-namespace** foi criada para automatizar a inclusão de um label específico em todos os Namespaces dentro de um cluster Kubernetes. Essa abordagem é essencial para **organização, monitoramento e controle de acesso** em ambientes complexos.

## 📌 Detalhes da Política

O label aplicado por esta política é:  
**Jeferson: "Lindo_Demais"**  

A inclusão desse label em todos os Namespaces **facilita a identificação e categorização**, permitindo uma gestão mais eficiente e padronizada.

## 📄 Arquivo de Política: `add-label-namespace.yaml`

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-label-namespace
spec:
  rules:
    - name: add-label-ns
      match:
        resources:
          kinds:
            - Namespace
      mutate:
        patchStrategicMerge:
          metadata:
            labels:
              Jeferson: "Lindo_Demais"
```

## 🛠️ Utilização da Política

Essa política **garante que todos os Namespaces do cluster** sejam automaticamente etiquetados com o label **Jeferson: "Lindo_Demais"**.  

Isso é especialmente útil para **manter conformidade e uniformidade** na atribuição de labels, facilitando operações como:
- **Filtragem** de Namespaces por critérios específicos;
- **Busca otimizada** dentro do cluster;
- **Padronização** das práticas de gestão.
