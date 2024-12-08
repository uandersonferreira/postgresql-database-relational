# PostgreSQL - Como realizar consultas simples em tabelas com o comando `SELECT`

Declaração `SELECT`: Consultas simples em tabelas de um banco de dados.

sintaxe:

```sql
-- Carrega todos os registros (tuplas/linhas) com todas as colunas da tabela ( * ).
SELECT * FROM tabela;
```

```sql
-- Espeficica as coluna(s) e as condições (filtros)
SELECT coluna(s), coluna(s)

FROM tabela 

CONDIÇÕES; -- WHERE, etc.

```

### Cláusula `WHERE`

```sql
SELECT * 
from clientes
WHERE cod_cliente = 1;

```

### Operadores de comparação

- ` < , > , >= , <= `

```sql

SELECT * 
from produtos
WHERE preco >= 15.00 AND qtde_estoque > 25;

```

---

## PostgreSQL - Ordenar resultados de consultas com `ORDER BY`

Sintaxe:

``` sql

SELECT colunas
from tabela
[WHERE CONDIÇÕES] -- Opcional
ORDER BY coluna, coluna2 ASC | DESC

-- ASC default
```

``` sql

SELECT nome_produto, preco from produtos
ORDER BY nome_produto, preco;

SELECT nome_produto, descricao from produtos
ORDER BY descricao NULLS FIRST; -- NULLS FIRST | LAST

SELECT nome_produto, preco from produtos
WHERE preco > 100.00
ORDER BY preco;

```

---

## Curso de PostgreSQL - `LIMIT e OFFSET` - Limitar resultados de consultas

### Conceito

- **`LIMIT`**: Restringe o número de linhas retornadas pela consulta.
- **`OFFSET`**: Pula um número específico de linhas antes de começar a retornar os resultados.

### Sintaxe

```sql
SELECT coluna(s)
FROM tabela
[WHERE CONDIÇÃO]
[ORDER BY coluna]
[LIMIT { valor_contagem | ALL }]
[OFFSET deslocamento]

-- valor_contagem = quantidade de linhas a exibir
-- ALL = mostrar todas as linhas (default)
-- deslocamento = quantas linhas devem ser ignoradas antes de iniciar a contagem do LIMIT
```

### Exemplos

```sql
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 3;  -- Retorna as 3 linhas com maior preço.
```

```sql
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 3
OFFSET 2;  -- Ignora os 2 primeiros resultados, retorna os próximos 3.
```

### Casos específicos

- **Somente `LIMIT`**: Útil quando se quer apenas limitar o número de resultados exibidos, como as primeiras ou últimas `n` linhas.
- **Somente `OFFSET`**: Raramente usado isoladamente, pois não faz sentido pular linhas sem definir um limite. A consulta retornaria todas as linhas a partir do deslocamento.
- **`LIMIT` com `OFFSET`**: Essencial para paginação de resultados, permitindo que a consulta pule um número de linhas e retorne apenas o próximo conjunto limitado.

---

## Curso de PostgreSQL - Operadores de Comparação em Consultas SQL

São usados para comparar dois valores e retornar um valor booleano, dependendo do resultado da comparação.

- `<` menor quer
- `>` maior que
- `<=` menor ou igual a
- `>=` maior ou igual a
- `=` igual a
- `<>` ou `!=` diferente de (não igual a)

```sql
SELECT nome_produto, qtde_estoque
FROM produtos
WHERE nome_produto != 'Refrigerante'
AND qtde_estoque <= 20 
AND qtde_estoque > 10;
```

## Curso de PostgreSQL - Operador `BETWEEN` e intervalos em consultas SQL

- Comparação de intervalos de dados

Sintaxe:

```SQL
SELECT ...
FROM ...
WHERE COLUNA [NOT] BETWEEN VALOR1 AND VALOR2

-- [NOT] NEGAÇÃO OU SEJA VALORE QUE NÃO ESTÃO ENTRE OS INTERVALOR DE DADOS.
```

```sql

SELECT nome_produto, preco
from produtos
WHERE preco BETWEEN 10.00 and 100.00;

-- Com dois intervalor de dados ou mais
SELECT nome_produto, preco
from produtos
WHERE 
	preco BETWEEN 10.00 and 50.00 OR
    preco BETWEEN 10.00 and 100.00;

-- com condição
SELECT nome_produto, preco, qtde_estoque
from produtos
WHERE 
	preco BETWEEN 2.00 and 100.00 AND
    qtde_estoque <= 10;

-- FILTAR DADOS QUE NÃO ESTÃO ENTRE O INTERVALO DE DADOS
SELECT nome_produto, preco, qtde_estoque
from produtos
WHERE 
	preco NOT BETWEEN 2.00 and 10.00;


```
