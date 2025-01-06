#kubernetes 

**Por que eu vou querer ter um Ingress Controller?**

Ter um Ingress Controller no meu cluster é essencial para permitir que meus serviços sejam acessados externamente. Vale lembrar que "externamente" não significa necessariamente expor para a internet, mas sim permitir o acesso a partir de fora do cluster.

**Benefícios do Ingress Controller:**
1. **Gerenciamento Centralizado:** Ele centraliza a entrada de tráfego, facilitando o gerenciamento e o monitoramento de acessos.
2. **Flexibilidade de Roteamento:** Permite definir regras detalhadas de roteamento, como hosts virtuais e path-based routing.
3. **Regras de Segurança:** Permite adicionar regras de segurança, como autenticação e autorização.
4. **Certificados TLS:** Facilita a configuração de SSL/TLS para garantir conexões seguras.

**Ingress Controller na Nuvem:**
Ao usar o Kubernetes na nuvem, como em provedores como AWS, GCP ou Azure, temos a opção de configurar um LoadBalancer, que pode fornecer um IP externo e público para os nossos serviços. O Ingress Controller trabalha em conjunto com o LoadBalancer para gerenciar o tráfego de entrada de forma eficiente.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: meu-ingress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - hosts:
    - meu-dominio.com
    secretName: tls-secret
  rules:
  - host: meu-dominio.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: meu-servico
            port:
              number: 80
```

### Explicação:
1. **apiVersion:** Versão da API do Kubernetes que estamos utilizando.
2. **kind:** Tipo do recurso. Aqui, estamos criando um Ingress.
3. **metadata:** Informações sobre o Ingress, como nome e namespace.
4. **annotations:** Anotações úteis. Por exemplo, especificamos o uso do NGINX Ingress Controller e a integração com o cert-manager para gerenciamento de certificados TLS.
5. **spec:** Especificações do Ingress:
   - **tls:** Configuração do TLS para o domínio especificado, utilizando um secret para armazenar os certificados.
   - **rules:** Regras de roteamento HTTP:
     - **host:** Domínio para o qual queremos rotear o tráfego.
     - **http:** Configurações de roteamento de caminho e backend.

Com esta configuração, você está habilitando o suporte a TLS e roteamento de tráfego HTTP para seu serviço em um cluster AKS.

**Ingress VS Load**