# Curso de PostgreSQL - Aliases com cláusula AS

Podemos dar um nome diferente a uma coluna ou tabela ao realizar uma consulta usando um ALIAS/APELIDO.

Sintaxe:

```sql

SELECT coluna1 AS alias_coluna1,

       coluna2 AS alias_coluna2,

       colunaN AS alias_colunaN,

FROM tabela AS alias_tabela;


-- Para garantir que o alias seja igual ao desejado coloque entre (aspas) " nome ", caso contrário pode vim a primeira letra minuscula ou maiscula a depender do S.O ou caso tenha espaço pode não funcionar como desejado.

SELECT nome_produto AS "Produto"
from produtos
WHERE qtde_estoque > 10;


SELECT cod_pedido AS "Código do pedido", qtde as "Quantidade"
from pedidos as p 
ORDER by "Quantidade" DESC;

```

> OBSERVATION: A CLÁUSULA `AS` é OPCIONAL, MAS RECOMENDA-SE UTILIZAR PARA FICAR MAIS LEGÍVEL E FÁCIL DE INDENTIFICAR UM ALIAS.

```SQL
SELECT nome_cliente "Nome", sobrenome "Sobrenome"
from clientes  cl;

```
