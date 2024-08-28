#Cloud #Linux 

### Comandos de Inicialização:

- **`sudo reboot`**: Reinicia o sistema.
- **`sudo shutdown -h now`**: Desliga o sistema imediatamente.
- **`sudo shutdown -r now`**: Reinicia o sistema imediatamente.

### Comandos de Status - Processos:

- **`top`**: Exibe os processos em execução e o uso de recursos em tempo real.
- **`htop`**: Uma versão mais amigável do `top`.
- **`df -h`**: Mostra o uso do espaço em disco de forma legível.
- **`free -h`**: Exibe a quantidade de memória livre e usada no sistema.
- **`uptime`**: Mostra há quanto tempo o sistema está em execução.
- **`systemctl status [serviço]`**: Verifica o status de um serviço específico.
- - **`ps aux`**: Lista todos os processos em execução no sistema, incluindo detalhes como o usuário, uso de CPU e memória, e o comando que iniciou o processo.
- **`pgrep [nome_do_processo]`**: Procura processos pelo nome e retorna seus IDs.
- **`pidof [nome_do_programa]`**: Retorna o PID de um programa específico.
- **`top`**: Exibe uma lista dinâmica dos processos em execução, ordenados pelo uso de CPU.
- **`htop`**: Uma versão mais amigável do `top`, com uma interface interativa.
- **`atop`**: Similar ao `top`, mas com mais detalhes sobre o uso de recursos do sistema.
- **`systemctl status [serviço]`**: Verifica o status de um serviço específico, como `systemctl status mysql` para verificar o status do MySQL.
- **`service [serviço] status`**: Outra forma de verificar o status de um serviço, como `service apache2 status` para o Apache.

### Comandos de Gerenciamento de Pacotes:

- **`sudo apt update`**: Atualiza a lista de pacotes disponíveis.
- **`sudo apt upgrade`**: Atualiza todos os pacotes instalados para a versão mais recente.
- **`sudo apt install [pacote]`**: Instala um novo pacote.
- **`sudo apt remove [pacote]`**: Remove um pacote instalado.
- **`sudo apt autoremove`**: Remove pacotes que não são mais necessários.

### Comandos de Controle de Arquivos:

- **`ls`**: Lista arquivos e diretórios.
- **`cd [diretório]`**: Muda para o diretório especificado.
- **`cp [origem] [destino]`**: Copia arquivos ou diretórios.
- **`mv [origem] [destino]`**: Move ou renomeia arquivos ou diretórios.
- **`rm [arquivo]`**: Remove arquivos.
- **`rm -r [diretório]`**: Remove diretórios e seu conteúdo recursivamente.
- **`chmod [permissões] [arquivo]`**: Altera as permissões de um arquivo.
- **`chown [usuário]:[grupo] [arquivo]`**: Altera o proprietário e o grupo de um arquivo.

### Comandos de Rede:

- **`ping [endereço]`**: Verifica a conectividade com um endereço.
- **`ifconfig`**: Exibe ou configura interfaces de rede.
- **`ip a`**: Exibe informações detalhadas sobre interfaces de rede.
- **`netstat -tuln`**: Mostra todas as portas abertas e serviços em execução.
- **`ssh [usuário]@[host]`**: Conecta-se a um host remoto via SSH.

### Comandos para Verificar Serviços:

- **`systemctl status [serviço]`**: Verifica o status de um serviço específico, como `systemctl status mysql` para verificar o status do MySQL.
- **`service [serviço] status`**: Outra forma de verificar o status de um serviço, como `service apache2 status` para o Apache.

### Comandos para Verificar Conexões de Rede:

- [**`netstat -tuln`**: Mostra todas as portas abertas e serviços em execução](https://www.hostinger.com.br/tutoriais/como-gerenciar-processos-no-linux-usando-linha-de-comando)[3](https://www.hostinger.com.br/tutoriais/como-gerenciar-processos-no-linux-usando-linha-de-comando).
- **`ss -tuln`**: Similar ao `netstat`, mas mais moderno e eficiente.