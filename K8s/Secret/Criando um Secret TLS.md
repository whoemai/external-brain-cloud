#kubernetes #secret 

O [Secret](https://kubernetes.io/docs/concepts/configuration/secret/) `kubernetes.io/tls` é usado para armazenar certificados TLS e chaves privadas. Eles são usados para fornecer segurança na comunicação entre os serviços no [Kubernetes](https://kubernetes.io/). Por exemplo, você pode usar um Secret TLS para configurar o HTTPS no seu serviço web.

Para criar um Secret TLS, você precisa ter um certificado TLS e uma chave privada, e precisa codificar o certificado e a chave privada em base64 para então criar o Secret.

Vamos criar um Secret TLS para o nosso serviço web, mas para isso, você precisa ter um certificado TLS e uma chave privada antes de mais nada.

Para criar um certificado TLS e uma chave privada, você pode usar o comando `openssl`:

```shell
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout chave-privada.key -out certificado.crt
```

No comando acima, estamos criando um certificado TLS e uma chave privada, que serão armazenados nos arquivos `certificado.crt` e `chave-privada.key`, respectivamente. Você pode substituir os nomes dos arquivos por qualquer nome que desejar. Estamos usando o comando `openssl` para criar um certificado TLS auto-assinado. Durante o processo, você precisará responder algumas perguntas, como país, estado, cidade, etc. Este certificado TLS auto-assinado é apenas para fins de teste e não deve ser usado em produção. O parâmetro `-nodes` garante que a chave privada não seja criptografada com uma senha, e o parâmetro `-days` define a validade do certificado TLS (neste caso, 365 dias). O parâmetro `-newkey` define o algoritmo de criptografia da chave privada (neste caso, `rsa:2048`).

Para mais detalhes sobre o comando `openssl`, você pode consultar a [documentação oficial](https://www.openssl.org/docs/).

Agora vamos criar o Secret TLS com o certificado TLS e a chave privada criados, usando o comando `kubectl apply`:

```shell
kubectl create secret tls meu-servico-web-tls-secret --cert=certificado.crt --key=chave-privada.key
```

Exemplo de saída:

```shell
secret/meu-servico-web-tls-secret created
```

Para verificar se o Secret foi criado, use o comando `kubectl get secrets`:

```shell
kubectl get secrets
```

Exemplo de saída:

```shell
NAME                         TYPE                             DATA   AGE
meu-servico-web-tls-secret   kubernetes.io/tls                2      4s
```

Sim, o Secret está lá e é do tipo `kubernetes.io/tls`.

Caso você queira ver o conteúdo do Secret, use o comando `kubectl get secret` com o parâmetro `-o yaml`:

```shell
kubectl get secret meu-servico-web-tls-secret -o yaml
```

Agora você pode usar esse Secret para configurar o Nginx com HTTPS. Para isso, use o campo `spec.tls` no arquivo YAML do Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
        - containerPort: 443
      volumeMounts:
        - name: nginx-config-volume
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
        - name: nginx-tls
          mountPath: /etc/nginx/tls
    volumes:
    - name: nginx-config-volume
      configMap:
        name: nginx-config
    - name: nginx-tls
      secret:
        secretName: meu-servico-web-tls-secret
        items:
          - key: certificado.crt
            path: certificado.crt
          - key: chave-privada.key
            path: chave-privada.key
```

Primeira coisa que temos que falar é sobre o `spec.containers`, principalmente sobre os volumes, que é o campo `spec.containers.volumeMounts`.

O campo `spec.containers.volumeMounts` é usado para montar um volume em um diretório dentro do container. No nosso caso, estamos montando dois volumes, um para o arquivo de configuração do Nginx e outro para o certificado TLS e a chave privada.

Usamos o campo `spec.volumes` para definir os volumes que serão usados pelo Pod. Estamos definindo dois volumes: `nginx-config-volume` e `nginx-tls`.

- O volume `nginx-config-volume` é do tipo `configMap` e é usado para montar o arquivo de configuração do Nginx, que está armazenado no ConfigMap `nginx-config`.
- O volume `nginx-tls` é do tipo `secret` e é usado para montar o Secret `meu-servico-web-tls-secret`, que contém o certificado TLS e a chave privada que serão usados para configurar o HTTPS no Nginx.

Para mais informações sobre ConfigMaps, consulte a [documentação oficial](https://kubernetes.io/docs/concepts/configuration/configmap/).

E como estamos configurando o Nginx para usar o nosso Secret, precisamos falar onde queremos que os arquivos do Secret sejam montados. Para isso, usamos o campo `spec.containers.volumeMounts.path` para definir o diretório onde queremos que os arquivos do Secret sejam montados. Neste caso, o diretório é `/etc/nginx/tls`.