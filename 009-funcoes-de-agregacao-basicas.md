Aqui estão suas anotações revisadas e organizadas com a sintaxe correta e explicações:

# 10 Exemplos de Funções de Agregação no PostgreSQL

Funções de agregação são usadas para computar um valor único a partir de um conjunto de valores de entrada. Elas retornam um único valor com base nos dados fornecidos.

## Sintaxe Básica de Funções de Agregação

A sintaxe de funções de agregação geralmente segue o seguinte formato:

```sql
SELECT AGGREGATE_FUNCTION(column_name) 
FROM table_name;
```

- `AGGREGATE_FUNCTION`: Nome da função de agregação (ex.: `COUNT`, `SUM`, `MAX`, etc.).
- `column_name`: Nome da coluna que contém os dados a serem agregados.

### Correção

```sql
-- Errado: as funções de agregação puras retornam apenas um valor, não aceitam outras colunas sem GROUP BY
SELECT sum(preco), nome_produto from produtos;

-- Correto: Para incluir outras colunas, é necessário usar GROUP BY
SELECT SUM(preco), nome_produto 
FROM produtos
GROUP BY nome_produto;
```

## Funções Básicas

### 1. `COUNT`

Conta o número de registros (linhas) em uma tabela.

```sql
-- Conta todos os registros da tabela
SELECT COUNT(*) FROM clientes;

-- Conta registros desconsiderando valores NULL na coluna especificada
SELECT COUNT(nome_cliente) AS "QTDE CLIENTES"
FROM clientes;

-- Conta registros excluindo duplicatas
SELECT COUNT(DISTINCT nome_produto) 
FROM produtos;

-- Conta registros que atendem a uma condição específica
SELECT COUNT(*) 
FROM produtos
WHERE preco >= 1000.00;
```

### 2. `MAX`

Retorna o valor máximo de uma coluna.

```sql
-- Retorna o preço mais alto
SELECT MAX(preco) FROM produtos;
```

### 3. `MIN`

Retorna o valor mínimo de uma coluna.

```sql
-- Retorna o menor preço
SELECT MIN(preco) FROM produtos;
```

### 4. `SUM`

Soma todos os valores de uma coluna.

```sql
-- Soma o preço de todos os produtos
SELECT SUM(preco) FROM produtos;
```

### 5. `AVG`

Calcula a média dos valores em uma coluna.

```sql
-- Calcula a média dos preços
SELECT AVG(preco) 
FROM produtos;

-- Arredonda a média para duas casas decimais
SELECT ROUND(AVG(preco), 2) 
FROM produtos;

-- Calcula a média com uma condição
SELECT ROUND(AVG(preco), 2) 
FROM produtos
WHERE nome_produto = 'Refrigerante';
```

## Dicas Importantes

- Ao utilizar funções de agregação com outras colunas, é necessário incluir um `GROUP BY` para agrupar os resultados.
- O uso de `DISTINCT` dentro de funções como `COUNT` evita contagens duplicadas.
