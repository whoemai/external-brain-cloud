Executar contêineres com um usuário não-root é uma das práticas de segurança mais importantes e fundamentais no ecossistema Docker. Ela se baseia no **Princípio do Menor Privilégio (Principle of Least Privilege - PoLP)**, que dita que qualquer aplicação ou usuário deve ter apenas as permissões estritamente necessárias para realizar suas tarefas, e nada mais.

Por padrão, os processos dentro de um contêiner Docker rodam com o usuário `root` (UID 0). Isso representa um risco de segurança significativo por vários motivos.

## Os Riscos de Rodar como `root`

1. **Cenário de Execução Remota de Código (RCE):**
    
    - Imagine que sua aplicação (no exemplo, `api-go-gin`) tenha uma vulnerabilidade que permita a um atacante executar comandos no servidor (um RCE).
        
    - Se a aplicação está rodando como `root` dentro do contêiner, o atacante obtém um shell com privilégios de `root` _dentro do contêiner_.
        
    - Com acesso `root` no contêiner, o atacante pode:
        
        - Ler, modificar ou apagar **qualquer arquivo** da aplicação.
            
        - Instalar malwares, como keyloggers ou mineradores de criptomoeda.
            
        - Tentar farejar o tráfego de rede de outros contêineres na mesma rede Docker.
            
2. **Risco de "Fuga do Contêiner" (Container Escape):**
    
    - Este é o pior cenário. Uma "fuga de contêiner" ocorre quando uma vulnerabilidade no próprio runtime do contêiner (Docker, containerd, etc.) permite que um processo de dentro do contêiner ganhe acesso ao sistema operacional do host (a máquina que está rodando o Docker).
        
    - Por padrão, o usuário `root` dentro do contêiner (UID 0) é mapeado para o usuário `root` do host (UID 0).
        
    - Se um atacante que já tem acesso `root` no contêiner conseguir explorar uma falha para "escapar", ele se tornará `root` **na máquina host**. A partir daí, ele tem controle total sobre o servidor, podendo acessar dados de todos os outros contêineres e do próprio host.
        

Ao criar e usar um usuário sem privilégios (`appuser`), você mitiga drasticamente esses dois riscos. Se um atacante conseguir um RCE, ele terá apenas as permissões do `appuser`, que são muito limitadas. Ele só poderá acessar os arquivos que pertencem a esse usuário e não poderá instalar pacotes ou modificar arquivos de sistema, tornando um ataque muito mais difícil e menos danoso.

---

## Análise Detalhada do Dockerfile e Melhorias

Vamos analisar cada passo do seu `Dockerfile` e adicionar mais detalhes.

```text
# Usa uma imagem base. Ubuntu é grande; para produção, considere imagens
# 'slim', 'alpine' ou 'distroless' para reduzir a superfície de ataque.
FROM ubuntu:24.10

# Criação de usuário e grupo
# O comando é executado como root, pois é o usuário padrão da imagem base.
RUN groupadd --system --gid 1001 appuser && \
    useradd --system --uid 1001 --gid appuser --home-dir /app --shell /sbin/nologin appuser

```

**Análise do `RUN groupadd && useradd`:**

- `groupadd --system appuser`: Cria um grupo de sistema chamado `appuser`. A flag `--system` (ou `-r`) é uma convenção para indicar que este não é um usuário humano, e geralmente aloca um GID (Group ID) de um intervalo reservado (abaixo de 1000).
    
- `useradd --system --gid appuser ... appuser`: Cria um usuário de sistema `appuser` e o associa ao grupo `appuser`.
    
    - `--home-dir /app` (ou `-d /app`): Define o diretório home do usuário. É uma boa prática alinhar isso com o `WORKDIR`.
        
    - `--shell /sbin/nologin` (ou `-s /sbin/nologin`): **Esta é uma camada de segurança extra muito importante.** Ela define que este usuário não pode ter um shell de login interativo. Se um atacante conseguir uma forma de "logar" como `appuser`, a sessão será imediatamente terminada.
        

**Melhoria Sugerida:**

- **UID/GID Estáticos:** É uma boa prática definir um UID (User ID) e GID (Group ID) estáticos (ex: `1001`). Isso evita problemas de permissão ao montar volumes do host, especialmente em orquestradores como Kubernetes, que podem ter políticas de segurança baseadas em UIDs.
    

---

```text
# ... (comandos anteriores)

# Cria o diretório de trabalho. As instruções seguintes (RUN, CMD, COPY)
# serão executadas a partir deste diretório.
WORKDIR /app

# Copia os arquivos e dá permissões
# ESTE É UM PONTO CRÍTICO: Estes comandos ainda rodam como ROOT.
COPY ./api-go-gin api-go-gin
RUN chmod +x api-go-gin

COPY ./templates/ templates/

# Agora, transfere a posse dos arquivos para o nosso usuário não-root.
RUN chown -R appuser:appuser /app

# Muda para o usuário não-root
# A PARTIR DAQUI, todas as instruções seguintes rodam como 'appuser'
USER appuser

# ... (outras instruções)

```

**Análise e Otimização:**

1. **Ordem e Agrupamento:** No Docker, cada instrução `RUN`, `COPY`, `ADD` cria uma nova camada na imagem. É uma boa prática agrupar comandos para reduzir o número de camadas e o tamanho final da imagem.
    
2. **Propriedade dos Arquivos (`chown`):** Quando você usa `COPY`, os arquivos são copiados com a propriedade do usuário que está executando o comando (neste caso, `root`). Por isso, o `chown` é essencial para transferir a posse para `appuser`. Você pode fazer o `chown` de todo o diretório de trabalho (`/app`) de uma só vez após copiar todos os arquivos.
    
3. **`USER appuser`:** Esta é a instrução final e crucial. Ela define que o comando principal do contêiner (`CMD` ou `ENTRYPOINT`) e quaisquer comandos `RUN` subsequentes serão executados como `appuser`.
    

---

## Versão Otimizada e Comentada do Dockerfile

Aqui está uma versão do seu Dockerfile que incorpora essas otimizações e melhores práticas:

```text
# 1. Imagem Base
# Usar uma imagem menor como 'alpine' ou 'distroless' é recomendado para produção.
FROM ubuntu:24.10

# 2. Criação de usuário e grupo com UID/GID estáticos
# Agrupado em um único RUN para criar menos camadas.
RUN groupadd --system --gid 1001 appuser && \
    useradd --system --uid 1001 --gid appuser --home-dir /app --shell /sbin/nologin appuser

# 3. Define variáveis de ambiente (se necessário)
ENV HOST=localhost DBPORT=5432
ENV USER=root PASSWORD=root DBNAME=root

# 4. Cria o diretório de trabalho
# O WORKDIR também cria o diretório se ele não existir.
WORKDIR /app

# 5. Copia os arquivos da aplicação
# Copiamos os arquivos ANTES de mudar o dono, pois o COPY é feito como root.
COPY ./api-go-gin ./api-go-gin
COPY ./templates ./templates/

# 6. Define as permissões corretas
# Damos permissão de execução ao binário e mudamos o dono de TUDO em /app.
# O '-R' garante que a mudança seja recursiva para o diretório 'templates'.
RUN chmod +x ./api-go-gin && \
    chown -R appuser:appuser /app

# 7. Muda para o usuário não-root
# Todas as instruções a seguir serão executadas como 'appuser'.
USER appuser

# 8. Expõe a porta da aplicação
# Portas acima de 1024 não exigem privilégios de root para serem usadas.
EXPOSE 8000

# 9. Comando de execução
# Este comando será executado pelo 'appuser', conforme definido acima.
CMD ["./api-go-gin"]

```
## Conclusão

Adotar a prática de usar um usuário não-root é uma mudança simples no `Dockerfile` que aumenta enormemente a segurança da sua aplicação em contêineres. Você cria uma "caixa" muito mais restrita para sua aplicação, limitando o dano potencial de uma vulnerabilidade e dificultando enormemente que um atacante consiga escalar privilégios e comprometer o sistema host. É uma camada de defesa essencial no modelo de segurança de "defesa em profundidade".