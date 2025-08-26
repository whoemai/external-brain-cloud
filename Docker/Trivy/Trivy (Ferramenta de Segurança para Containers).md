# Resumo da Aula – Trivy

## O que é o Trivy?

- Ferramenta _open source_ usada para **analisar vulnerabilidades** em imagens Docker, pacotes e configurações.
    
- Gera relatórios com identificadores CVE, nível de severidade e status das vulnerabilidades.
    

---

## 1. Usando o Trivy via Docker

 Vantagem: **não precisa instalar no sistema**, basta executar em container.

bash

`docker run --rm aquasec/trivy image nginx:latest`

- `--rm`: remove o container após o uso.
    
- `aquasec/trivy image nginx:latest`: escaneia a imagem do Nginx.
    

---

## 2. Interpretando Relatórios

O relatório mostra:

- **CVE** → Identificador único da falha (ex: CVE-2025-12345).
    
- **Severidade** → Criticidade (LOW, MEDIUM, HIGH, CRITICAL).
    
- **Status** → Corrigido, não corrigido ou em análise.
    

 Isso ajuda a definir **prioridades de correção**.

---

## 3. Importância da Validação Cruzada

- Nenhuma ferramenta pega 100% das vulnerabilidades.
    
- **Boa prática**: usar Trivy + outras ferramentas (ex.: Grype, Clair) para confirmação.
    

---

## 4. Configuração de Escaneamentos

É possível decidir **o que escanear**:

- Apenas vulnerabilidades em pacotes:
    

bash

`trivy image --vuln-type os nginx:latest`

- Apenas dependências de aplicações:
    

bash

`trivy image --vuln-type library nginx:latest`

---

## 5. Diferenças nas Pontuações (CVSS)

- Uma mesma CVE pode ter pontuações **diferentes** em sistemas distintos (por exemplo, CVSS v2, v3.1).
    
-  Importante: **entender a criticidade real** para seu ambiente e priorizar conforme impacto.
    

---

## 6. Salvando Relatórios (Redirecionamento de Saída)

- Para guardar resultado em arquivo:
    

bash

`trivy image nginx:latest > relatorio.txt`

- Para formatos estruturados (ex.: JSON):
    

bash

`trivy image --format json -o relatorio.json nginx:latest`

---

## 7. Busca por Vulnerabilidades e Segredos

- Por padrão, o Trivy escaneia:  
     Vulnerabilidades  
     Segredos (ex.: senhas, chaves em arquivos)
    
- É possível configurar **para focar apenas em um tipo de análise**:
    

bash

`trivy fs --scanners vuln ./projeto trivy fs --scanners secret ./projeto`