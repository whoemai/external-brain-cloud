#kubernetes 

![[Pasted image 20241105162829.png]]
### Passos para usar Persistent Volumes com Azure Disks no AKS

1. **Criar uma Storage Class**:
    
    - A Storage Class define como o serviço de disco do Azure se conecta ao cluster Kubernetes, incluindo o tipo de armazenamento, política de recuperação e modo de vinculação de volume.
    - Exemplo de YAML para uma Storage Class:
        
        ```yaml
        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: azure-disk
        provisioner: disk.csi.azure.com
        parameters:
          skuName: Standard_LRS
          storageaccounttype: Standard_LRS
        reclaimPolicy: Delete
        volumeBindingMode: Immediate
        ```
        
2. **Criar um Persistent Volume Claim (PVC)**:
    
    - O PVC define o modo de acesso e a quantidade de armazenamento necessária.
    - Exemplo de YAML para um PVC:
        
        ```yaml
        apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
          name: my-azure-disk
        spec:
          accessModes:
            - ReadWriteOnce
          storageClassName: azure-disk
          resources:
            requests:
              storage: 10Gi
        ```
        
3. **Criar um Pod ou Deployment**:
    
    - O Pod ou Deployment deve referenciar o PVC para montar o volume.
    - Exemplo de YAML para um Pod:
        
        ```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: my-pod
        spec:
          containers:
          - name: my-container
            image: nginx
            volumeMounts:
            - mountPath: "/mnt/azure"
              name: my-azure-disk
          volumes:
          - name: my-azure-disk
            persistentVolumeClaim:
              claimName: my-azure-disk
        ```
        
4. **Verificar a criação e anexação do disco**:
    
    - Após aplicar os YAMLs, verifique se o disco do Azure foi criado e anexado ao Pod. Os dados devem persistir mesmo após a exclusão e recriação do Pod.

### Considerações Importantes

- [**Modos de Acesso**: O Azure Disk só pode ser montado com o modo de acesso `ReadWriteOnce`, o que significa que ele estará disponível para um único nó no AKS](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision)[1](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision).
- [**Limites de Volume**: O driver CSI do Azure Disk tem um limite de volume por nó, que varia conforme o tamanho do nó ou pool de nós](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision)[1](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision)