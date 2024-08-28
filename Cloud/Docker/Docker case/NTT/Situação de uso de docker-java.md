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

