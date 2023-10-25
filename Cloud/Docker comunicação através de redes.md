#Docker #Cloud 

Quando criamos container é disponibilizado 3 redes que são: bridge, host & none;
A rede bridge é usada pra comunicar containers em um mesmo host;
Redes bridges criadas manualmente permite comunicação via hostname;
A rede host remove o isolamento de rede entre o container e o host;
A rede none remove a interface de rede do container;
Podemos criar rede com o comando `docker network create`
