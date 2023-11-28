#Docker #Cloud 

Um Dockerfile é um script que contém instruções para construir uma imagem Docker. Ele descreve os passos necessários para criar um ambiente isolado para a execução de uma aplicação.

**Estrutura básica de um Dockerfile:**

```dockerfile
# Seleciona a imagem base
FROM ubuntu:latest

# Define o diretório de trabalho
WORKDIR /app

# Copia arquivos locais para o contêiner
COPY . .

# Instala dependências
RUN apt-get update && apt-get install -y python3

# Expõe a porta necessária
EXPOSE 8080

# Comando de inicialização da aplicação
CMD ["python3", "app.py"]
```

**Explicação:**
- `FROM`: Especifica a imagem base.
- `WORKDIR`: Define o diretório de trabalho dentro do contêiner.
- `COPY`: Copia arquivos locais para o contêiner.
- `RUN`: Executa comandos durante a construção da imagem.
- `EXPOSE`: Indica a porta que a aplicação estará ouvindo.
- `CMD`: Define o comando padrão a ser executado quando o contêiner for iniciado.

**Exemplo prático:**

Vamos considerar uma aplicação web em Python usando o framework Flask. Se o seu código estiver em um arquivo chamado `app.py`:

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, Docker World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

**Como construir e executar a imagem:**

1. Crie o Dockerfile no mesmo diretório que seu código.
2. No terminal, navegue até o diretório e execute:

```bash
docker build -t minha-aplicacao:latest .
```

3. Execute o contêiner:

```bash
docker run -p 8080:8080 minha-aplicacao
```

Acesse `http://localhost:8080` no navegador para ver a aplicação.

Este é um exemplo básico, mas o Dockerfile pode ser personalizado para atender às necessidades específicas da sua aplicação.