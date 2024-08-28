#Cloud #Docker 

Vamos listar primeiramente o que podemos fazer. Nosso objetivo é configurar um Docker com dependências básicas para uma aplicação Java. 

Podemos criar um Docker file com algumas instruções para nossa aplicação Java.
```Dockerfile
# Usar uma imagem base do OpenJDK
FROM openjdk:17-jdk-alpine

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar o arquivo JAR da aplicação para o diretório de trabalho
COPY target/myapp.jar /app/myapp.jar

# Expor a porta que a aplicação irá usar
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "myapp.jar"]
```

Com o nosso Docker file agora temos que construir nossa imagem. Para isso podemos ir até o local onde nosso Docker file está e executar o comando:
```sh
docker build -t myapp:latest .
```

Depois de construir a imagem temos que agora executar ela:
```sh
docker run -d -p 8080:8080 myapp:latest
```

- `-d` : Esta flag indica que o contêiner deve ser executado em segundo plano (modo “detached”). Isso significa que o terminal não ficará ocupado com a saída do contêiner, permitindo que você continue usando o terminal para outros comandos.
- `-p 8080:8080` : Esta opção mapeia a porta 8080 do host (seu computador) para a porta 8080 do contêiner. Isso é necessário para que você possa acessar a aplicação rodando dentro do contêiner através do seu navegador ou outras ferramentas externas.
- A sintaxe é `-p <porta_host>:<porta_container>`. No exemplo, a porta 8080 do host está sendo mapeada para a porta 8080 do contêiner.
- 1. `myapp:latest` : Este é o nome da imagem Docker que será usada para criar o contêiner. `myapp` é o nome da imagem e `latest` é a tag da imagem, indicando que a versão mais recente da imagem deve ser usada. Se você não especificar uma tag, o Docker usará `latest` por padrão.