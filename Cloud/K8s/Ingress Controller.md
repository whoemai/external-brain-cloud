#kubernetes 

## **Por que eu vou querer ter um Ingress Controller?**

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

## **Ingress VS Loadbalancer**

Ótima pergunta! A decisão entre usar um Ingress Controller ou um LoadBalancer depende de vários fatores. Vamos analisar os principais pontos a serem considerados:

### 1. **Complexidade do Roteamento:**
- **Ingress Controller:** Ideal se você precisa de roteamento complexo, como direcionar solicitações para diferentes serviços com base no caminho da URL ou host.
- **LoadBalancer:** É mais simples e direto, recomendado para expor um único serviço de forma externa sem regras de roteamento complexas.

### 2. **Custo:**
- **Ingress Controller:** Em ambientes na nuvem, utilizar um Ingress Controller pode ser mais econômico, pois você pode gerenciar múltiplos serviços através de um único IP público, economizando recursos.
- **LoadBalancer:** Cada serviço exposto pode precisar de seu próprio LoadBalancer, o que pode aumentar os custos.

### 3. **Certificados TLS:**
- **Ingress Controller:** Facilita a gestão de certificados TLS para vários serviços. Você pode centralizar a configuração e renovação dos certificados.
- **LoadBalancer:** Pode ser mais trabalhoso gerenciar certificados TLS individualmente para cada LoadBalancer.

### 4. **Gerenciamento e Manutenção:**
- **Ingress Controller:** Oferece um ponto centralizado para gerenciar o tráfego de entrada, o que pode simplificar o gerenciamento em grandes ambientes de produção.
- **LoadBalancer:** Pode ser mais simples de configurar inicialmente, mas pode se tornar complicado conforme o número de serviços cresce.

### 5. **Escalabilidade:**
- **Ingress Controller:** Pode lidar com um grande número de serviços e regras de roteamento sem necessidade de adicionar novos LoadBalancers.
- **LoadBalancer:** Pode exigir a criação de múltiplos LoadBalancers para escalar diferentes serviços, aumentando a complexidade da infraestrutura.

### 6. **Segurança:**
- **Ingress Controller:** Permite adicionar regras de segurança, como autenticação, autorização e limitação de taxas diretamente no controlador.
- **LoadBalancer:** Segurança pode ser configurada, mas geralmente requer configurações adicionais em cada serviço.

### 7. **Características do Provedor de Nuvem:**
- **Ingress Controller:** Alguns provedores de nuvem oferecem controladores de Ingress gerenciados que se integram bem com seus serviços.
- **LoadBalancer:** Todos os principais provedores de nuvem oferecem LoadBalancers nativos que são fáceis de usar e bem integrados com outros serviços da nuvem.

---

Em resumo, se você precisa de um gerenciamento centralizado e flexível para vários serviços com roteamento complexo e melhor gerenciamento de certificados, o Ingress Controller é a melhor escolha. Se você precisa de uma solução simples e direta para expor um ou poucos serviços, o LoadBalancer pode ser suficiente.