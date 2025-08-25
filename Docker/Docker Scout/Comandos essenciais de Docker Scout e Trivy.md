## Docker Scout

- Comando base: docker scout — grupo de subcomandos no CLI para análise de imagens, CVEs, SBOM, recomendações e políticas.[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    

## Análise e relatórios

- docker scout cves IMAGE: lista CVEs identificadas no artefato (imagem/índice), com severidades e detalhes de pacotes afetados.youtube[docker](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout quickview IMAGE: visão rápida da imagem (tamanho, camadas, base, resumo de vulnerabilidades), útil para triagem.[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout recommendations IMAGE: recomenda atualizações de base image e correções de vulnerabilidades com versões “fix”.[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- docker scout sbom IMAGE: gera ou exibe o SBOM da imagem, facilitando inventário de componentes e correlação de CVEs.[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    

## Política, comparação e automação

- docker scout policy IMAGE: avalia a imagem contra políticas de segurança/compliance e mostra o resultado; bom para gates de CI (experimental).[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- docker scout compare IMAGE_A IMAGE_B: compara diferenças de pacotes/camadas e impacto de CVEs entre duas imagens (experimental).[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout watch REGISTRY/REPO: observa repositórios em um registro e envia imagens/resultados para o backend do Scout (experimental).[docker+1](https://docs.docker.com/reference/cli/docker/scout/watch/)
    

## Integração e gestão

- docker scout integration ...: lista, configura e remove integrações (Hub, SCM, etc.).[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- docker scout repo ...: habilita/desabilita o Scout em repositórios do registro/Hub.[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout push IMAGE: envia imagem/índice para o Scout para análise centralizada.[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- docker scout enroll ORG: inscreve uma organização no Scout para relatórios e governança.[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    

## Configuração e utilidades

- docker scout config ...: gerencia configurações do CLI (credenciais, cache, modo offline).[github+1](https://github.com/docker/scout-cli)
    
- docker scout cache ...: controla cache e arquivos temporários (limpeza/inspeção).[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- docker scout attestation ...: gerencia atestações em índices de imagem (supply chain).[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout version: mostra a versão do plugin.[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    

## Trivy

- Comando base: trivy — scanner abrangente para imagens, sistemas de arquivos, repositórios, IaC, com modos cliente/servidor.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    

## Alvos de varredura

- trivy image IMAGE: varre uma imagem de container e reporta CVEs por severidade; ideal para uso em CI e pré-publicação.[fig+1](https://fig.io/manual/trivy)
    
- trivy filesystem PATH ou trivy fs PATH: varre o sistema de arquivos local incluindo dependências de linguagens.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    
- trivy repository REPO_URL ou trivy repo REPO_URL: varre um repositório remoto (ex.: Git) sem precisar clonar localmente.[fig+1](https://fig.io/manual/trivy)
    
- trivy config PATH: audita arquivos de configuração/IaC (Kubernetes/Terraform) com checks de más configurações e políticas.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    
- trivy sbom TARGET: gera SBOM de um artefato (imagem, diretório), em formatos como CycloneDX/SPDX.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    

## Modos de operação

- trivy server: inicia o servidor para caching e alto desempenho; útil quando múltiplos jobs consultam a mesma base.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    
- trivy client --remote [http://SERVER:porta](http://server:porta/): roda o cliente apontando para o servidor, reduzindo latência e duplicidade de cache.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    

## Opções úteis

- --format json/table/sarif/cyclonedx: define o formato de saída para integração com ferramentas e relatórios.[fig+1](https://fig.io/manual/trivy)
    
- --severity CRITICAL,HIGH: filtra severidades relevantes para gates de pipeline.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    
- --ignore-unfixed: ignora vulnerabilidades sem correção disponível, focando no que é remediável.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    
- --exit-code 1: força falha do job quando encontrar vulnerabilidades conforme critérios, implementando “política de quebra”.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    
- --timeout 5m, --quiet, --debug, --cache-dir DIR: controle de tempo, verbosidade e cache.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    

## Trivy no Kubernetes

- Trivy Operator: operador Kubernetes que automatiza varreduras pós-deploy e grava resultados como CRDs (VulnerabilityReport, ConfigAuditReport, etc.).[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.37/tutorials/kubernetes/cluster-scanning/)
    
- Benefícios: escaneia continuamente workloads e componentes, integra com Prometheus/alertas e atualiza relatórios periodicamente (ex.: a cada 6 horas).[github+1](https://github.com/aquasecurity/trivy-operator)
    
- Quick start: instalação no namespace trivy-system via kubectl ou Helm; resultados acessíveis pela API do cluster.[aquasecurity.github+1](https://aquasecurity.github.io/trivy-operator/v0.1.3/operator/quick-start/)
    

## Dicas de uso rápido

- Docker Scout: usar cves e recommendations para triagem rápida; sbom para inventário e auditoria; policy para gates de conformidade.[docker+1](https://docs.docker.com/reference/cli/docker/scout/)
    
- Trivy: usar image com --severity HIGH,CRITICAL e --exit-code 1 no CI; usar config para IaC; sbom para supply chain; considerar server+client para velocidade.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)
    

## Exemplos rápidos

- docker scout cves nginx:latest — lista vulnerabilidades da imagem do NGINX.youtube[docker](https://docs.docker.com/reference/cli/docker/scout/)
    
- docker scout recommendations node:20 — sugere base image e fixes disponíveis.[docker.ubitools+1](https://docker.ubitools.com/reference/cli/docker/scout/)
    
- trivy image --severity HIGH,CRITICAL --exit-code 1 myapp:1.0 — falha o build se houver CVEs altas/críticas.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.33/docs/references/cli/)
    
- trivy config ./k8s — audita manifests Kubernetes no diretório k8s.[fig+1](https://fig.io/manual/trivy)
    

Termos-chave: usar docker scout para insights e recomendações integrados ao ecossistema Docker, e trivy para varredura universal e política de “quebrar o build” com formatos de saída flexíveis.[aquasecurity.github+1](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/cli/)