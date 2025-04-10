#kubernetes #kyverno #policy
# Criando a nossa primeira Policy no Kyverno

O **Kyverno** permite que você **defina, gerencie e aplique políticas de forma declarativa**, garantindo que os clusters e suas cargas de trabalho estejam em conformidade com as regras e normas definidas.

## Tipos de Políticas no Kyverno

As **políticas** do Kyverno, conhecidas como _policies_ em inglês, podem ser aplicadas de duas maneiras principais:

### **ClusterPolicy**  
Quando uma política é definida como **ClusterPolicy**, ela é aplicada a **todos os namespaces no cluster**. Ou seja, as regras especificadas serão automaticamente aplicadas a todos os recursos correspondentes em todos os namespaces, a menos que sejam explicitamente excluídos.

### **Policy**  
Se o objetivo for aplicar políticas a **um namespace específico**, utiliza-se o tipo **Policy**. Essas políticas são **restritas ao namespace** onde foram criadas e não afetam outros namespaces.

📌 **Nota:**  
Caso um namespace não seja especificado ou seja usada a **ClusterPolicy**, o Kyverno assumirá que a política deve ser aplicada **globalmente**, abrangendo **todos os namespaces**.

---

## Exemplo de Políticas do Kyverno

Vamos criar uma **política de limites de recursos**, garantindo que **todos os containers em um Pod tenham limites de CPU e memória definidos**. Isso é essencial para evitar o uso excessivo de recursos em um ambiente de **cluster compartilhado**.

### **Arquivo `require-resources-limits.yaml`**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-cpu-memory-limits
spec:
  validationFailureAction: enforce
  rules:
  - name: validate-limits
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "CPU and memory limits are required"
      pattern:
        spec:
          containers:
          - name: "*"
            resources:
              limits:
                memory: "?*"
                cpu: "?*"
```

Após criar o arquivo, basta realizar o **deploy** no cluster **Kubernetes**:

```sh
kubectl apply -f require-resources-limits.yaml
```

---

### **Testando a política**
Agora, tente realizar o deploy de um **Nginx** sem definir limites para os recursos.

#### **Arquivo `pod.yaml`**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: exemplo-pod
spec:
  containers:
  - name: exemplo-container
    image: nginx
```

Aplicando no cluster:

```sh
kubectl apply -f pod.yaml
```

Se a política estiver configurada corretamente, o Kyverno impedirá esse deployment, garantindo que **todos os containers** tenham limites de recursos definidos.