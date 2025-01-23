#kubernetes #ingress

O **Cert-Manager** é uma ferramenta open-source projetada para automatizar a gestão e emissão de certificados TLS (Transport Layer Security) em ambientes Kubernetes. Ele simplifica o processo de obtenção, renovação e uso de certificados, garantindo comunicação segura entre sistemas distribuídos.

### Aplicabilidade do Cert-Manager

1. **Automatização de Certificados**: O Cert-Manager elimina a necessidade de gerenciar manualmente a emissão e renovação de certificados. Ele pode obter certificados de várias autoridades, como Let's Encrypt, AWS, Google Cloud, entre outras.

2. **Integração com Kubernetes**: Como uma ferramenta nativa do Kubernetes, ele se integra perfeitamente com os recursos do Kubernetes, utilizando Custom Resource Definitions (CRDs) para gerenciar certificados.

3. **Segurança de Aplicações**: Pode ser integrado com o Ingress do Kubernetes para fornecer automaticamente certificados SSL/TLS para suas aplicações, garantindo que o tráfego entre o cliente e o servidor seja criptografado.

4. **Flexibilidade**: Suporta vários tipos de certificados, incluindo certificados autoassinados, certificados de autoridades de certificados (CA) e certificados de uso específico (SCT).

5. **Facilidade de Configuração**: Pode ser instalado facilmente usando Helm, um gerenciador de pacotes para Kubernetes, e configurado para gerenciar certificados de forma eficiente.

### Exemplo de Uso

Para usar o Cert-Manager, você pode seguir estes passos básicos:

1. **Instalar o Cert-Manager**: Adicione o repositório do Jetstack Helm e instale o Cert-Manager no seu cluster Kubernetes.
   ```powershell
   helm repo add jetstack https://charts.jetstack.io
   helm repo update
   helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
   ```

2. **Configurar Issuer/ClusterIssuer**: Defina um Issuer ou ClusterIssuer para especificar a autoridade de certificação que será usada.
   ```yaml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
     name: letsencrypt-prod
   spec:
     acme:
       server: https://acme-v02.api.letsencrypt.org/directory
       email: your-email@example.com
       privateKeySecretRef:
         name: letsencrypt-prod
       solvers:
       - http01:
           ingress:
             class: nginx
   ```

3. **Criar Certificado**: Defina um recurso de Certificado que utilize o Issuer/ClusterIssuer configurado.
   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: my-cert
   spec:
     commonName: "example.com"
     dnsNames:
     - "example.com"
     issuerRef:
       name: letsencrypt-prod
       kind: ClusterIssuer
     secretName: my-cert-secret
   ```

4. **Aplicar o Certificado**: Use o comando `kubectl apply` para aplicar o arquivo YAML e criar o certificado.
   ```powershell
   kubectl apply -f my-cert.yaml
   ```

### Benefícios

- **Redução de Erros Humanos**: Automatiza processos repetitivos e propensos a erros, como a renovação de certificados.
- **Segurança Melhorada**: Garante que os certificados estejam sempre atualizados e válidos, evitando avisos de segurança nos navegadores.
- **Eficiência**: Economiza tempo e recursos ao automatizar a gestão de certificados, permitindo que os administradores de TI foquem em outras tarefas críticas.