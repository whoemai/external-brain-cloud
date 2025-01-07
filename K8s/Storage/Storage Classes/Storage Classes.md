#kubernetes 

![[Pasted image 20241107100207.png]]

**Storage Classes** no Kubernetes são uma forma de definir diferentes “classes” de armazenamento que podem ser usadas para provisionar volumes de forma dinâmica. [Elas permitem que os administradores especifiquem as características do armazenamento, como a tecnologia subjacente, a capacidade, a disponibilidade e outras políticas específicas](https://kubernetes.io/docs/concepts/storage/storage-classes/)[1](https://kubernetes.io/docs/concepts/storage/storage-classes/).

### Por que são importantes?

1. **Abstração**: Permitem que os desenvolvedores solicitem armazenamento sem precisar conhecer os detalhes de implementação.
2. **Flexibilidade**: Facilitam a definição de diferentes níveis de serviço (QoS) e políticas de backup.
3. [**Automação**: Suportam o provisionamento dinâmico de volumes, o que simplifica a gestão de armazenamento em ambientes de produção](https://kubernetes.io/docs/concepts/storage/storage-classes/)[1](https://kubernetes.io/docs/concepts/storage/storage-classes/).

### Exemplo de YAML para provisionar um StorageClass na Azure

Aqui está um exemplo de um arquivo YAML para criar um StorageClass usando o provisionador Azure Disk:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: azure-disk-standard
provisioner: kubernetes.io/azure-disk
parameters:
  skuName: Standard_LRS
  location: eastus
  storageAccount: mystorageaccount
reclaimPolicy: Retain
allowVolumeExpansion: true
volumeBindingMode: Immediate
```

[Este exemplo cria um StorageClass chamado `azure-disk-standard` que utiliza discos padrão do Azure (Standard_LRS) e permite a expansão do volume](https://kubernetes.io/docs/concepts/storage/storage-classes/)[1](https://kubernetes.io/docs/concepts/storage/storage-classes/).