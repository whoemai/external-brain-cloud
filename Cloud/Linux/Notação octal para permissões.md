#Linux 

A notação octal utiliza três dígitos, cada um variando de 0 a 7, onde cada dígito representa um conjunto de permissões. 

A estrutura é a seguinte:

```less
Permissoes: [Usuario] [Grupo] [Outros]
Exemplo: chmod 755 arquivo.txt
```

Cada número em octal (0-7) é calculado somando os valores das permissões:

| Permissão                 | Símbolo | Valor Octal |
| ------------------------- | ------- | ----------- |
| Nenhuma                   | ---     | 0           |
| Executar                  | --x     | 1           |
| Escrever                  | -w-     | 2           |
| Escrever + Executar       | -wx     | 3           |
| Ler                       | r--     | 4           |
| Ler + Executar            | r-x     | 5           |
| Ler + Escrever            | rw-     | 6           |
| Ler + Escrever + Executar | rwx     | 7           |

Dessa forma, o número final representa as permissões para usuário, grupo e outros na ordem em que são escritos.

# **Exemplos de Uso**

Se rodarmos o comando:

```bash
chmod 644 arquivo.txt
```

Teremos:

- 6 (Usuário): Leitura (4) + Escrita (2) = 6 (rw-).
- 4 (Grupo): Leitura = 4 (r--).
- 4 (Outros): Leitura = 4 (r--).

Neste caso, o proprietário pode ler e modificar o arquivo, enquanto o grupo e outros podem apenas lê-lo.

Se rodarmos o comando:

```bash
chmod 700 arquivo.txt
```

Teremos:

- 7 (Usuário): Leitura (4) + Escrita (2) + Execução (1) = 7 (rwx).
- 0 (Grupo): Sem permissão.
- 0 (Outros): Sem permissão.

Aqui, somente o proprietário tem todas as permissões, enquanto o grupo e outros não têm nenhuma.

Desse modo, a notação octal é mais compacta e rápida para definir um conjunto de permissões, alterando todas as permissões de uma vez.