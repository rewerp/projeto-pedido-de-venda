# 🛍️ Projeto Pedido de Venda
### Desenvolvido por: *Rewer Pinheiro*

----

### Descrição do Projeto

Projeto de Teste para um sistema de Pedido de Vendas desenvolvido em Delphi 12

### Tecnologias e ferramentas utilizadas
- Delphi 12 Community Edition
- Firebird 5.0
- DBeaver Community Edition
- Git / GitHub

#### Instalando Firebird 5.0
1. Faça o download do **Firebird 5.0** pelo link: https://www.firebirdsql.org/en/firebird-5-0 ;
2. Após a instalação, adicione o Path referente a instalação do Firebird 5.0 nas variável de usuário em Váriaveis de Ambiente (Environment Variables). Exemplo: "C:\Program Files\Firebird\Firebird_5_0\";
3. Execute o `Prompt de Comando` como **Administrador**;
4. Em seguida execute o comando `isql`, onde será apresentado a linha: `SQL>`;
5. Execute o comando para criar o banco de dados:

```
  CREATE DATABASE 'C:\SeuCaminho\SeuBancoDeDados.fdb'
  USER 'SYSDBA' PASSWORD 'masterkey';
```
6. Após a criação do banco de dados, faça a conexão usando algum aplicativo de gerenciamento como DBeaver ou IBExpert;
7. Execute os Scripts SQL disponíveis no repositórios para criar as tabelas e dados.

#### Configurando o arquivo .INI para banco de dados

O sistema utiliza um arquivo .INI de configuração para conectar o banco de dados.

1. Na pasta onde o executável (`PedidoDeVenda.exe`) será gerado, crie um arquivo chamado `config.ini`.
2. Utilize a estrutura do arquivo `config.ini.example`:

```ini
  [Configuracao]
  Database=C:\Caminho\Para\Seu\VENDAS.FDB
  Username=SYSDBA
  Password=masterkey
  Server=localhost
  Port=3050
  ClientLibrary=C:\Caminho\Para\fbclient.dll
```

#### Executando o projeto
1. Abra o arquivo de projeto `.dproj` no Delphi 12.
2. Certifique-se de que todas as units (`Model`, `Repository`, `Service`, `DataConnection`) estão devidamente adicionadas.
3. Compile o projeto em modo `Debug` ou `Release`.
4. Certifique-se de que o arquivo `config.ini` e a `fbclient.dll` estejam na mesma pasta do executável gerado.
5. Execute o `PedidoDeVenda.exe`.

#### Roteiro de testes manuais
Para validar as funcionalidades exigidas no teste, siga este roteiro:

1. Identificação do Cliente:
    - No campo "Código Cliente", digite 1 e pressione TAB, saia do campo ou tecle ENTER. O sistema deve carregar automaticamente o Nome, Cidade e UF.

2. Inserção de Itens:
    - No campo "Código Produto", digite 1 e pressione TAB, saia do campo ou tecle ENTER. A descrição e o preço unitário devem ser carregados.
    - Informe a "Quantidade" (ex: 2) e altere o "Preço Unitário" se desejar.
    - Clique no botão Inserir/Atualizar Item. O item deve aparecer no Grid e o Total do Pedido deve ser atualizado no rodapé.

3. Edição e Exclusão no Grid:
    - Selecione um item no Grid e pressione ENTER. Os dados devem voltar para os campos de edição acima. Altere a quantidade e clique em Inserir/Atualizar novamente.
    - Selecione um item no Grid e pressione DEL. Confirme a exclusão. O total do pedido deve diminuir instantaneamente.

4. Finalização:
    - Adicione uma observação no campo "Observação".
    - Clique em Gravar Pedido. O sistema deve processar a transação, exibir o número do pedido gerado pelo banco e limpar a tela para uma nova venda.
    - Caso o "Código Cliente" esteja vazio, a Grid estaja vazia ou o "Preço Total do Pedido" seja ZERO, é apresentado uma mensagem e o pedido não é finalizado.

#### Organização do Projeto
- `/src/Model`: Classes de entidade.
- `/src/Repository`: Lógicas de consulta e persistência do banco de dados.
- `/src/Service`: Regras de negócio e controle de transações.
- `/src/DataConnection`: DataModule para conexão com o banco de dados.