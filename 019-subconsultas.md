# **Subconsultas (Subqueries) no PostgreSQL**

## **O que é uma Subconsulta SQL (Subquery)?**

Uma **subconsulta** é uma consulta embutida dentro de outra consulta, de forma aninhada. Ela passa os resultados da consulta mais interna para a consulta mais externa por meio de uma cláusula `WHERE` ou `HAVING`.

Esse recurso permite restringir os dados retornados por uma consulta, criando filtros mais refinados. A subconsulta **retorna dados** que serão usados pela consulta principal como condições de filtragem.

### **Aplicações:**

- As subconsultas podem ser usadas em operações `SELECT`, `INSERT`, `UPDATE` e `DELETE`.
- Quando usamos uma subconsulta, **primeiro** ela é resolvida, e então a consulta externa (principal) é executada com base no resultado da subconsulta.

---

## **Regras Gerais para Aplicação de Subconsultas**

1. **Colunas:** A subconsulta deve retornar apenas uma coluna na cláusula `SELECT`, exceto quando a consulta principal envolve múltiplas colunas para comparação.
2. **Múltiplos Resultados:** Se a subconsulta retornar mais de uma linha, use operadores de valores múltiplos, como o operador lógico `IN`.
3. **Parênteses:** As subconsultas são sempre escritas dentro de parênteses.
4. **ORDER BY:** Não é permitido usar a cláusula `ORDER BY` em uma subconsulta, mas a consulta principal pode usá-la.
5. **GROUP BY:** É permitido usar `GROUP BY` em uma subconsulta.
6. **BETWEEN:** Não podemos usar o operador `BETWEEN` diretamente com uma subconsulta na consulta principal, mas ele pode ser usado **dentro** da subconsulta.

---

## **Sintaxe Básica de uma Subconsulta SQL**

A sintaxe básica de uma subconsulta em SQL segue este formato:

```sql
SELECT coluna(s)
FROM tabela(s)
WHERE coluna operador (
    SELECT coluna
    FROM tabela
    WHERE condições
);
```

- **Operador:** Pode ser qualquer operador lógico ou relacional, como `>`, `<`, `>=`, `<=`, `=`, `<>`, `IN`, `NOT`, `AND`, `OR`, etc.

---

## **Exemplos de Subconsultas**

### **1. Subconsulta com operação SELECT**

```sql
SELECT nome, salario
FROM empregados
WHERE salario > (
    SELECT AVG(salario)
    FROM empregados
    WHERE departamento = 'TI'
);
```

**Descrição:** Este exemplo retorna o nome e o salário dos empregados cujo salário é maior que a média de salários do departamento de TI.

### **2. Subconsulta com operação INSERT INTO**

Sintaxe básica:

```sql

INSERT INTO tabela (colunas)
                   (SELECT coluna(s)
                   FROM tabela(s)
                   WHERE coluna operador valor);
```

```sql
INSERT INTO historico_empregados (id, nome, cargo)
SELECT id, nome, cargo
FROM empregados
WHERE departamento = 'RH';
```

**Descrição:** Insere dados de empregados do departamento de RH na tabela de histórico de empregados.

### **3. Subconsulta com operação UPDATE**

Sintaxe básica:

```sql

UPDATE tabela
SET coluna(s) = valor
WHERE coluna operador (SELECT coluna(s)
                       FROM tabela
                       WHERE coluna operador valor);
```

```sql
UPDATE empregados
SET salario = salario * 1.10
WHERE departamento = (
    SELECT id
    FROM departamentos
    WHERE nome = 'Vendas'
);
```

**Descrição:** Atualiza o salário dos empregados do departamento de vendas com um aumento de 10%.

### **4. Subconsulta com operação DELETE + IN **

Uma subconsulta pode retornar zero ou mais linhas.
Se a consulta retornar mais de uma linha, você pode usá-la com o operador `IN` .

Sintaxe básica:

```sql

DELETE FROM tabela
WHERE coluna operador (SELECT coluna
                       FROM tabela
                       WHERE coluna operador valor);
```

```sql
DELETE FROM empregados
WHERE id IN ( --  In pois poder retornar 0 ou N registros
    SELECT id
    FROM historico_empregados
    WHERE demitido = TRUE
);
```

**Descrição:** Exclui da tabela de empregados aqueles que foram marcados como demitidos no histórico.

Outro exemplo:

```sql
SELECT film_id, title 
FROM film 
WHERE film_id IN (
    SELECT film_id 
    FROM film_category 
      INNER JOIN category USING(category_id) 
    WHERE name = 'Action'
  ) 
ORDER BY film_id;
```

---

### **5. Subconsultas Encadeadas**

Subconsultas podem ser aninhadas dentro de outras subconsultas, criando múltiplos níveis de consultas.

Sintaxe básica:

```sql

SELECT coluna(s)
FROM tabela(s)
WHERE coluna operador (SELECT coluna
                       FROM tabela
                       WHERE coluna operador (SELECT coluna
                                              FROM tabela
                                              WHERE coluna operador valor);
```

```sql
SELECT nome
FROM empregados
WHERE salario > (
    SELECT AVG(salario)
    FROM empregados
    WHERE departamento = (
        SELECT id
        FROM departamentos
        WHERE nome = 'Financeiro'
    )
);
```

**Descrição:** Este exemplo retorna os nomes dos empregados cujo salário é maior que a média salarial do departamento de Financeiro.

---

## SQL aula:

```SQL
-- Nome e preço do produto mais caro 
SELECT nome_produto, preco
from produtos
WHERE preco = MAX(preco); -- aggregate functions não são permitidas no WHERE 

-- Nome e preço do produto mais caro Com SUBQUERY

-- Consulta principal (externa)
SELECT nome_produto, preco
from produtos
WHERE preco = (
    -- Consulta interna (secundária)
  SELECT MAX(preco)
  FROM produtos
);

-- cod_cliente, nome e sobrenome de acordo com o cod_pedido conhecido
-- Poderia fazer com o inner join, mas devemos conhecer outras formas
SELECT cod_cliente, nome_cliente, sobrenome
from clientes
WHERE cod_cliente = (
 SELECT cod_cliente
  from pedidos
  WHERE cod_pedido = 20
);


-- cod_cliente, nome e sobrenome de acordo com uma lista de cod_pedidos conhecidos
-- IN quando retornamos mais de um registro
SELECT cod_cliente, nome_cliente, sobrenome
from clientes
WHERE cod_cliente IN (
  SELECT cod_cliente
  from pedidos
  WHERE cod_pedido = 20 OR cod_pedido = 22
);




```