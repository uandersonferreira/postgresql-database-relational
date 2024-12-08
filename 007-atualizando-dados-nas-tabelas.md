## Curso de PostgreSQL - Cláusula `UPDATE` - Atualizar dados inseridos nas tabelas

Atualizando registros em tabelas 

Sintaxe:

```sql
UPDATE TABELA
SET COLUNA = NOVO_VALOR
WHERE COLUNA = VALOR_INDICE;
```

```sql
-- Boas práticas: informar a PK do registro para atualizar
UPDATE produtos
SET descricao = 'Mouse lenovo'
WHERE cod_produto = 2;

-- funciona assim também, caso não encontre o nome_produto não irá fazer nada

UPDATE produtos
SET preco = 99.99
WHERE nome_produto = 'Fone de Ouvido';

-- com calculo e condição 
UPDATE produtos
SET qtde_estoque = qtde_estoque - 4
WHERE preco > 15.00;

-- Aplicar uma atualizar que afeta todos os registros de uma tabela. Basta usar o comando sem o `WHERE`, pois assim irá AFETAR TODOS OS REGISTROS

UPDATE produtos
SET preco = preco * 1.10;


```
