#AWS #Cloud
A criação de um par de chaves na AWS é uma etapa fundamental para proteger seus recursos na nuvem, garantindo autenticação segura e controle de acesso apropriado. Essa prática é parte integrante das melhores práticas de segurança na nuvem.

**No Console AWS:**

1. Acesse o Console AWS em [https://aws.amazon.com](https://aws.amazon.com) e faça login na sua conta.

2. Vá para a seção EC2, que pode ser encontrada no painel de serviços.

3. Dentro da seção EC2, navegue até 'Rede e Segurança' e selecione 'Pares de Chaves'. Aqui é onde você pode criar e gerenciar suas chaves.

**Pelo Terminal (usando ssh-keygen):**

Para criar um par de chaves SSH diretamente do seu terminal, siga estas etapas:

1. Abra o terminal no seu ambiente de desenvolvimento. Isso pode ser feito usando ferramentas como o Terminal no macOS ou o PowerShell no Windows.

2. Navegue até o diretório onde deseja armazenar a chave SSH. Você pode usar o comando `cd` para fazer isso.

3. Use o comando `ssh-keygen` para gerar sua chave SSH. Você pode especificar um nome para a chave e uma frase secreta opcional. Por exemplo:

   ```
   ssh-keygen -t rsa -b 2048 -f nome_da_chave
   ```

   Isso criará uma chave SSH RSA de 2048 bits com o nome que você escolheu.

4. Você será solicitado a escolher uma frase secreta. Isso é opcional, mas adicionar uma frase secreta torna sua chave mais segura. Digite a frase secreta quando solicitado.

5. Agora, sua chave SSH foi gerada e está armazenada no diretório especificado. Você terá dois arquivos: `nome_da_chave` (sua chave privada) e `nome_da_chave.pub` (sua chave pública).

Você pode usar a chave pública (`nome_da_chave.pub`) ao adicionar a chave SSH ao AWS ou a qualquer outro serviço que você deseja usar.

Ao seguir essas etapas, você estará pronto para utilizar a autenticação SSH tanto no AWS quanto em outros serviços em nuvem, proporcionando um nível adicional de segurança às suas operações."

