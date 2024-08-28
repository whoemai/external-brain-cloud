#Docker  

**Resumo sobre Docker: Comunicação através de Redes**

O Docker é uma plataforma de contêinerização que permite empacotar, distribuir e executar aplicativos de maneira consistente em diferentes ambientes. Ele utiliza contêineres, que são unidades leves e portáveis, contendo tudo o que é necessário para executar um software, incluindo o código, runtime, bibliotecas e dependências.

**Comunicação através de Redes no Docker:**

No Docker, os contêineres podem se comunicar entre si e com o mundo exterior através de redes. Existem diferentes tipos de redes no Docker, e cada contêiner pode ser conectado a uma ou mais redes. Alguns tipos comuns de redes são a rede bridge, overlay, host e none.

- **Bridge Network:**
  - É a rede padrão utilizada quando você cria um contêiner.
  - Permite que os contêineres se comuniquem entre si no mesmo host usando endereços IP.
  - Exemplo de criação de uma rede bridge:
    ```bash
    docker network create minha-rede
    ```

- **Overlay Network:**
  - Permite a comunicação entre contêineres em hosts diferentes, criando uma rede sobreposta.
  - Útil para aplicativos distribuídos.
  - Exemplo:
    ```bash
    docker network create --driver overlay minha-rede-overlay
    ```

- **Host Network:**
  - Conecta o contêiner diretamente à rede do host.
  - Compartilha o namespace de rede do host, eliminando a necessidade de fazer port mapping.
  - Exemplo:
    ```bash
    docker run --network host meu-container
    ```

**Exemplo de Código:**

Vamos considerar um cenário em que temos dois contêineres, um rodando um aplicativo web em Node.js e outro um banco de dados em MongoDB. Vamos conectá-los em uma rede bridge.

1. Criando uma rede bridge:
   ```bash
   docker network create minha-rede
   ```

2. Executando o contêiner do MongoDB na rede criada:
   ```bash
   docker run --name meu-mongodb --network minha-rede -d mongo
   ```

3. Executando o contêiner do aplicativo Node.js na mesma rede:
   ```bash
   docker run --name meu-app --network minha-rede -d -p 8080:8080 meu-app-nodejs
   ```

Agora, o contêiner Node.js pode se comunicar com o MongoDB usando o nome do contêiner como host.

Essa é uma visão geral básica sobre a comunicação de redes no Docker, utilizando exemplos práticos.