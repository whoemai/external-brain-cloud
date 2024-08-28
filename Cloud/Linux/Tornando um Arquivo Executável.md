#Linux 

Para tornar qualquer arquivo executável, você precisa ajustar suas permissões usando o comando `chmod`:

- **Adicionar permissão de execução**:
    
    ```bash
    chmod +x nome_do_arquivo
    ```
    
- **Executar o arquivo**:
    
    ```bash
    ./nome_do_arquivo
    ```
    

### Exemplo Prático:

Se você tem um script chamado `meu_script.sh`, você pode torná-lo executável e executá-lo assim:

```bash
chmod +x meu_script.sh
./meu_script.sh
```