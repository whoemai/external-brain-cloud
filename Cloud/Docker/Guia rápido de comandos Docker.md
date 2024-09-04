#Cloud #Docker 
### Comandos de Inicialização:

- **`docker run`**: Cria e inicia um novo contêiner a partir de uma imagem.
- **`docker start`**: Inicia um contêiner parado.
- **`docker restart`**: Reinicia um contêiner.

### Comandos de Status:

- **`docker ps`**: Lista todos os contêineres em execução.
- **`docker ps -a`**: Lista todos os contêineres, independentemente de estarem em execução ou não.
- **`docker logs`**: Exibe os logs de um contêiner.
- **`docker logs -f`** : Exibe os logs em tempo real conforme são gerados.
- **`docker logs -t`** : Exibe os logs com timestamps
- **`docker logs --tail 100`** :  A opção `--tail` permite que você veja apenas as últimas N linhas dos logs.
- **`docker logs --since "2023-08-27T15:00:00"`** : - A opção `--since` permite que você veja os logs gerados após uma data e hora específicas.
- **`sudo service docker status`**: Usado para verificar o status do serviço Docker no seu sistema.
- **`docker inspect`** : - Fornece detalhes completos sobre o contêiner, incluindo configurações de rede, volumes montados e muito mais.

### Comandos de Gerenciamento de Imagens:

- **`docker pull`**: Baixa uma imagem do Docker Hub para o seu host local.
- **`docker images`**: Lista todas as imagens disponíveis no host local.
- **`docker build`**: Constrói uma imagem a partir de um Dockerfile.
- **`docker rm`** :  Remove um container.
- **`docker rmi`** : Remove uma imagem.

### Comandos de Controle de Contêiner:

- **`docker stop`**: Para um contêiner em execução.
- **`docker exec`**: Executa um comando em um contêiner em execução.
