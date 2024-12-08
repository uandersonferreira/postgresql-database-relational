# Exemplos de Operadores Aritméticos no PostgreSQL

> <https://pgdocptbr.sourceforge.io/pg74/functions-math.html>

**Tabela 9-2. Operadores matemáticos**

Entendi! Vou corrigir isso utilizando blocos de código para garantir que todos os símbolos sejam exibidos corretamente:

**Tabela 9-2. Operadores matemáticos**

```
| Operador | Descrição                                    | Exemplo  | Resultado |
|----------|----------------------------------------------|----------|-----------|
| +        | adição                                       | 2 + 3    | 5         |
| -        | subtração                                    | 2 - 3    | -1        |
| *        | multiplicação                                | 2 * 3    | 6         |
| /        | divisão (divisão inteira trunca o resultado) | 4 / 2    | 2         |
| %        | módulo (resto)                               | 5 % 4    | 1         |
| ^        | exponenciação                                | 2.0 ^ 3.0| 8         |
| |/       | raiz quadrada                                | |/ 25.0  | 5         |
| ||/      | raiz cúbica                                  | ||/ 27.0 | 3         |
| !        | fatorial                                     | 5 !      | 120       |
| !!       | fatorial (operador de prefixo)               | !! 5     | 120       |
| @        | valor absoluto                               | @ -5.0   | 5         |
| &        | AND bit a bit                                | 91 & 15  | 11        |
| |        | OR bit a bit                                 | 32 | 3   | 35        |
| #        | XOR bit a bit                                | 17 # 5   | 20        |
| ~        | NOT bit a bit                                | ~1       | -2        |
| <<       | deslocamento à esquerda bit a bit            | 1 << 4   | 16        |
| >>       | deslocamento à direita bit a bit             | 8 >> 2   | 2         |
```

---

#### A ordem de precedência dos operadores aritméticos, do mais alto ao mais baixo, é a seguinte⁶:

1. **Parênteses** `()`
2. **Expoentes** `^`
3. **Multiplicação** `*` e **Divisão** `/`
4. **Adição** `+` e **Subtração** `-`

---

### Exemplos de Operadores Aritméticos

```sql
-- Adição
SELECT 10 + 5 AS resultado; -- 15

-- Subtração
SELECT 20 - 7 AS resultado; -- 13

-- Multiplicação
SELECT 8 * 4 AS resultado; -- 32

-- Divisão (divisão inteira trunca o resultado)
SELECT 10 / 3 AS resultado; -- 3

-- Módulo (resto da divisão)
SELECT 10 % 3 AS resultado; -- 1

-- Exponenciação
SELECT 3.0 ^ 4.0 AS resultado; -- 81.0

-- Raiz quadrada
SELECT |/ 49.0 AS resultado; -- 7.0

-- Raiz cúbica
SELECT ||/ 8.0 AS resultado; -- 2.0

-- Fatorial (pós-fixado)
SELECT 5! AS resultado; -- 120

-- Fatorial (prefixado)
SELECT !! 4 AS resultado; -- 24

-- Valor absoluto
SELECT @ -15.0 AS resultado; -- 15.0

-- AND bit a bit
SELECT 91 & 15 AS resultado; -- 11

-- OR bit a bit
SELECT 32 | 3 AS resultado; -- 35

-- XOR bit a bit
SELECT 17 # 5 AS resultado; -- 20

-- NOT bit a bit
SELECT ~1 AS resultado; -- -2

-- Deslocamento à esquerda bit a bit
SELECT 1 << 3 AS resultado; -- 8

-- Deslocamento à direita bit a bit
SELECT 16 >> 2 AS resultado; -- 4
```

### Operadores com Dados de Tabelas

```sql
-- Calculando o preço de 5 unidades de um produto específico
SELECT preco * 5 AS valor_total
FROM produtos
WHERE cod_produto = 18;

-- Calculando o custo de um produto específico com arredondamento
SELECT round(preco / 100, 2) AS custo_unitario
FROM produtos
WHERE nome_produto = 'Luvas de Látex';

-- Somando o valor total de todos os produtos em estoque
SELECT SUM(preco * qtde_estoque) AS valor_total_estoque
FROM produtos;
```

### Ordem de Precedência

```sql
-- Exemplo de ordem de precedência de operadores
SELECT 10 + 6 * 3 AS resultado; -- 28, multiplicação antes da adição
SELECT (10 + 6) * 3 AS resultado; -- 48, parênteses alteram a ordem
SELECT 18 % 4 AS resultado; -- 2, módulo (resto) da divisão
SELECT 10 ^ 2 AS resultado; -- 100, exponenciação
SELECT 6.02 * 10 ^ 23 AS resultado; -- 6.02e+23, notação científica
```
