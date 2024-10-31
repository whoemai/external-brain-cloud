#network

- Utilizar o comando `ping` para verificar a conectividade entre dispositivos computacionais.
- Usar o comando `traceroute` para verificar a rota na qual um pacote de dados está seguindo na rede.

## Comandos básicos de rede

### Comandos para Linux

1. **ip**: Configura e exibe informações de rede.
    - Exemplo: `ip addr show`
2. **ping**: Verifica a conectividade com outro host.
    - Exemplo: `ping google.com`
3. **traceroute**: Mostra o caminho que os pacotes percorrem até um destino.
    - Exemplo: `traceroute google.com`
4. **netstat**: Exibe conexões de rede, tabelas de roteamento, interfaces de rede e estatísticas.
    - Exemplo: `netstat -tuln`
5. **ifconfig**: Configura interfaces de rede (substituído pelo comando `ip` em distribuições modernas).
    - Exemplo: `ifconfig eth0`
6. **ss**: Exibe informações sobre sockets.
    - Exemplo: `ss -tuln`
7. **dig**: Consulta servidores DNS.
    - Exemplo: `dig google.com`
8. **hostname**: Exibe ou define o nome do host.
    - Exemplo: `hostname`
9. **curl**: Transfere dados de ou para um servidor.
    - Exemplo: `curl http://example.com`
10. **tcpdump**: Captura e analisa pacotes de rede.
    - Exemplo: `tcpdump -i eth0`

### Comandos para Windows

1. **ipconfig**: Exibe a configuração de IP do sistema.
    - Exemplo: `ipconfig /all`
2. **ping**: Verifica a conectividade com outro host.
    - Exemplo: `ping google.com`
3. **tracert**: Mostra o caminho que os pacotes percorrem até um destino.
    - Exemplo: `tracert google.com`
4. **netstat**: Exibe conexões de rede, tabelas de roteamento, interfaces de rede e estatísticas.
    - Exemplo: `netstat -an`
5. **nslookup**: Consulta servidores DNS.
    - Exemplo: `nslookup google.com`
6. **arp**: Exibe e modifica a tabela ARP.
    - Exemplo: `arp -a`
7. **getmac**: Exibe o endereço MAC do sistema.
    - Exemplo: `getmac`
8. **hostname**: Exibe o nome do host.
    - Exemplo: `hostname`
9. **netsh**: Configura e exibe a configuração de rede.
    - Exemplo: `netsh interface show interface`
10. **route**: Exibe e modifica a tabela de roteamento IP.
    - Exemplo: `route print`

## Hub VS Switch 

- **Hub**: Dispositivo que envia os dados recebidos para todas as portas, sem distinguir o destinatário. [Isso pode causar colisões e lentidão na rede, pois todos os dispositivos conectados recebem todas as mensagens](https://www.controle.net/faq/quais-as-principais-diferencas-entre-hubs-e-switches)[1](https://www.controle.net/faq/quais-as-principais-diferencas-entre-hubs-e-switches).
    
- **Switch**: Dispositivo mais inteligente que envia os dados apenas para a porta específica do destinatário, com base no endereço MAC. [Isso melhora a eficiência e a velocidade da rede, evitando colisões](https://www.alura.com.br/artigos/diferencas-entre-hubs-e-switches)[2](https://www.alura.com.br/artigos/diferencas-entre-hubs-e-switches).


