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
- Faça o download do **Firebird 5.0** pelo link: https://www.firebirdsql.org/en/firebird-5-0 ;
- Após a instalação, adicione o Path referente a instalação do Firebird 5.0 nas variável de usuário em Váriaveis de Ambiente (Environment Variables). Exemplo: "C:\Program Files\Firebird\Firebird_5_0\";
- Execute o `Prompt de Comando` como **Administrador**;
- Em seguida execute o comando `isql`, onde será apresentado a linha: `SQL>`;
- Execute o comando para criar o banco de dados:

```
CREATE DATABASE 'C:\SeuCaminho\SeuBancoDeDados.fdb'
USER 'SYSDBA' PASSWORD 'masterkey';
```

----
#### Lembrete - README.md com:
- Como criar o banco / rodar o script
- Como configurar o INI
- Como executar o projeto
- Roteiro rápido de testes manuais (passo a passo)
