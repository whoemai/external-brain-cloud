Argo CD é uma ferramenta de GitOps de entrega contínua para Kubernetes que mantém o estado “desejado” no Git alinhado com o estado “ao vivo” no cluster por meio de reconciliação contínua e operações de sincronização. As peças centrais são o recurso Application (CRD), o Application Controller, o API Server e o Repo Server, que juntos monitoram, comparam, sincronizam e reportam saúde e desvio de configuração.[argo-cd.readthedocs+2](https://argo-cd.readthedocs.io/en/latest/core_concepts/)

## Conceito GitOps

- Git é a fonte única da verdade: manifests e templates (Helm, Kustomize, Jsonnet) definem o estado desejado do app e ambientes.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/stable/)
    
- O Argo CD “puxa” mudanças do repositório para o cluster (pull-based), ao contrário de pipelines que “empurram”, aumentando segurança e auditabilidade.[devtron+1](https://devtron.ai/what-is-argocd)
    

## Application (CRD)

- Application representa um conjunto de recursos K8s com fonte (repoURL, path, targetRevision) e destino (cluster/namespace), além de política de sync.[kodekloud+1](https://kodekloud.com/blog/argo-cd/)
    
- É o vínculo declarativo entre Git (desejado) e o cluster (ao vivo); cada Application é monitorado e reconciliado.[diagrid+1](https://www.diagrid.io/blog/dapr-meets-gitops-a-guide-to-dapr-and-argo-cd)
    

## Estados e status

- Target state: estado desejado conforme Git; Live state: estado real no cluster; o Argo compara continuamente ambos.[spacelift+1](https://spacelift.io/blog/argocd)
    
- Sync status indica se os estados batem; Health indica se o app está funcional (ex.: pods prontos, readiness).[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/latest/core_concepts/)
    

## Fluxo de sincronização

- Refresh busca a versão mais recente no Git e calcula diferenças sem aplicar mudanças.[spacelift+1](https://spacelift.io/blog/argocd)
    
- Sync aplica mudanças para alinhar o Live ao Target; o Sync operation status sinaliza sucesso/falha.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/latest/core_concepts/)
    

## Políticas de sync

- Manual: sincronização feita sob demanda via UI/CLI/API.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/stable/)
    
- Automatizada: aplica mudanças automaticamente; opções comuns incluem Prune (remover recursos órfãos) e Self-Heal (reverter drift no cluster).[diagrid+1](https://www.diagrid.io/blog/dapr-meets-gitops-a-guide-to-dapr-and-argo-cd)
    

## Componentes da arquitetura

- Application Controller: compara e reconcilia estado desejado vs. ao vivo, orquestrando sync e saúde.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/stable/operator-manual/architecture/)
    
- API Server: expõe APIs gRPC/REST usadas por UI, CLI e integrações.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/stable/operator-manual/architecture/)
    
- Repo Server: renderiza manifests a partir de Helm/Kustomize/Jsonnet e cacheia repositórios para eficiência.[devtron+1](https://devtron.ai/blog/argo-cd-beginners-guide/)
    

## Tipos de fonte de aplicação

- Diretório de manifests YAML, Helm charts, Kustomize, Jsonnet, ou plugins de renderização; selecionados via “Application source type”.[kodekloud+1](https://kodekloud.com/blog/argo-cd/)
    
- Pode acompanhar branches, tags ou commits fixos (targetRevision).[devtron+1](https://devtron.ai/what-is-argocd)
    

## Operação e interfaces

- UI web: visualiza sync, saúde, diffs e eventos; CLI (argocd) para criar apps, sincronizar, fazer rollback e gerenciar credenciais de cluster.[devtron+1](https://devtron.ai/blog/argo-cd-beginners-guide/)
    
- O Argo CD roda dentro do cluster como controlador Kubernetes, seguindo o padrão controller/operator.[spacelift+1](https://spacelift.io/blog/argocd)
    

## Recursos e opções úteis

- CreateNamespace=true: cria o namespace de destino se não existir durante o sync.[diagrid+1](https://www.diagrid.io/blog/dapr-meets-gitops-a-guide-to-dapr-and-argo-cd)
    
- IgnoreDifferences e customizações por recurso para lidar com campos gerados ou mutações por admission controllers.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/latest/core_concepts/)
    

## Segurança e conformidade

- Modelo pull reduz exposição de credenciais externas e facilita auditoria (Git histórico e RBAC do Argo/K8s).[devtron+1](https://devtron.ai/what-is-argocd)
    
- Argo CD gerencia credenciais e pode aplicar RBAC para limitar quem cria/sincroniza Applications.[argo-cd.readthedocs+1](https://argo-cd.readthedocs.io/en/stable/operator-manual/architecture/)
    

## Boas práticas iniciais

- Separar apps e ambientes (ex.: diretórios por ambiente ou repositórios distintos) e versionar via branches/tags.[kodekloud+1](https://kodekloud.com/blog/argo-cd/)
    
- Habilitar Automated + Prune + Self-Heal em ambientes não-prod e endurecer em prod com aprovação/PRs e políticas.[diagrid+1](https://www.diagrid.io/blog/dapr-meets-gitops-a-guide-to-dapr-and-argo-cd)

