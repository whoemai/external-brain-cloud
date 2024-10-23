#kubernetes 

![[Pasted image 20241023122251.png]]

O **Service** é utilizado para permitir a comunicação entre diferentes _pods_ dentro de um mesmo _cluster_. Nesse cenário, qualquer _pod_ com os finais .2, .4 e .3 conseguirá se comunicar com o _pod_ de final .1 através desse serviço, utilizando o IP e o DNS, ou apenas o DNS, dependendo do caso.

É importante ressaltar que o serviço não é uma via de mão dupla. Não é porque um _pod_ possui um serviço que ele conseguirá se comunicar com outros _pods_ que não têm o serviço atrelado a eles. Portanto, de forma unilateral, todos os outros _pods_ conseguirão se comunicar com o _pod_ de final .1 de maneira estável, mas este _pod_ não conseguirá se comunicar com os outros se eles também não tiverem um serviço.

Tendo isso em mente, se tentarmos acessar esse _pod_ a partir de fora do _cluster_, o que acontecerá? Utilizando o serviço _ClusterIP_, não conseguiremos, pois a comunicação, como mencionado, é apenas interna ao _cluster_ utilizando um _ClusterIP_.

![[Pasted image 20241023122637.png]]

