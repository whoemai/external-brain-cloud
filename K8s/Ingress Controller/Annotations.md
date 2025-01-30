#kubernetes #ingress 

**Annotations** são pares de chave/valor que podem ser anexados a objetos Kubernetes para armazenar metadados não identificadores. Elas são usadas para adicionar informações adicionais que podem ser úteis para ferramentas, bibliotecas ou sistemas de extensão, mas não são usadas para selecionar objetos.

### Características principais:
- **Não identificadores**: Diferente das labels, as annotations não são usadas para selecionar objetos.
- **Flexibilidade**: Podem armazenar dados estruturados ou não estruturados, incluindo caracteres que não são permitidos em labels.
- **Formato**: São mapas de chave/valor onde as chaves e valores devem ser strings.

### Exemplos de uso:
- Informações de build, release ou imagem (timestamps, IDs de lançamento, hashes de imagem, etc.).
- Ponteiros para logs, monitoramento, análise ou auditoria.
- Informações de bibliotecas de clientes ou ferramentas para depuração.
- Proveniência do usuário ou ferramenta (URLs de objetos relacionados, etc.).

### Documentação Oficial:
Para mais detalhes, você pode consultar a [documentação oficial do Kubernetes sobre annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

Espero que isso ajude! Se tiver mais perguntas ou precisar de mais detalhes, estou aqui para ajudar.
