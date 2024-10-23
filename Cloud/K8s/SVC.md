#kubernetes 

![[Pasted image 20241023122251.png]]

O Service ele serve para nada mais que fazer a comunicação entre diferentes _pods_ dentro de um mesmo _cluster_.
Então, nesse cenário que nós estamos visualizando, todo e qualquer _pod_. Esse de final .2, .4 e .3 eles vão conseguir fazer a comunicação para este _pod_ de final .1 a partir desse serviço, utilizando o IP e o DNS, ou o DNS no caso desse serviço.

E vale ressaltar que o serviço não é uma via de mão dupla, não é porque este _pod_ tem um serviço que ele vai conseguir se comunicar com os outros que não têm também, porque eles não têm o serviço atrelado a eles. Então unilateralmente falando, todos os outros vão se comunicar a este _pod_ de maneira estável, mas ele só porque é um serviço não vai se comunicar aos outros se eles também não tiverem.

Tendo isso em mente, se nós tentarmos acessar esse _pod_ a partir de fora do _cluster_, o que vai acontecer? Utilizando esse serviço, claro, _ClusterIP_, nós não vamos conseguir, porque a comunicação, como eu falei, é apenas interna do _cluster_ utilizando um _ClusterIP_.

![[Pasted image 20241023122637.png]]

