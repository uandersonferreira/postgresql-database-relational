### Resumo sobre o PostgreSQL CAST

No PostgreSQL, o **CAST()** e o operador de cast `::` são utilizados para converter valores de um tipo de dado para outro. Esse processo é comum quando se deseja transformar um valor de um tipo (por exemplo, string) para outro (como número, data ou booleano).

> Fonte: https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cast/ 


#### Função `CAST()`

A função `CAST()` possui a seguinte sintaxe:

```sql
CAST(valor AS tipo_destino)
```

- **valor**: pode ser um literal, coluna ou expressão que será convertido.
- **tipo_destino**: o tipo de dado para o qual o valor será convertido.

#### Operador `::` (Específico do PostgreSQL)

Além da função `CAST()`, o PostgreSQL oferece o operador de cast `::`, que possui uma sintaxe mais simples:

```sql
valor::tipo_destino
```

### Exemplos de Conversão

1. **String para Inteiro**:

```sql
SELECT CAST('100' AS INTEGER);
```

Resultado:

```
 100
```

2. **String para Data**:

```sql
SELECT CAST('2015-01-01' AS DATE);
```

Resultado:

```
 2015-01-01
```

3. **String para Double Precision**:

```sql
SELECT CAST('10.2' AS DOUBLE PRECISION);
```

Resultado:

```
 10.2
```

4. **String para Boolean**:

```sql
SELECT CAST('true' AS BOOLEAN);
```

Resultado:

```
 true
```

5. **String para Timestamp** (usando `::`):

```sql
SELECT '2019-06-15 14:30:20'::timestamp;
```

Resultado:

```
 2019-06-15 14:30:20
```

6. **String para Intervalo**:

```sql
SELECT '15 minute'::interval;
```

Resultado:

```
 00:15:00
```

7. **Timestamp para Data**:

```sql
SELECT CAST('2024-02-01 12:34:56' AS DATE);
```

Resultado:

```
 2024-02-01
```

8. **Intervalo para Texto**:

```sql
SELECT CAST('30 days' AS TEXT);
```

Resultado:

```
 30 days
```

9. **JSON para JSONB**:

```sql
SELECT CAST('{"name": "John"}' AS JSONB);
```

Resultado:

```
 {"name": "John"}
```

10. **Double Precision para Inteiro**:

```sql
SELECT CAST(9.99 AS INTEGER);
```

Resultado:

```
 10
```

11. **Array para Texto**:

```sql
SELECT CAST(ARRAY[1, 2, 3] AS TEXT);
```

Resultado:

```
 {1,2,3}
```

12. **Texto para Array**:

```sql
SELECT '{1,2,3}'::INTEGER[];
```

Resultado:

```
 {1,2,3}
```

### Aplicação com Dados de Tabela

Caso seja necessário converter valores de uma coluna que contenha letras e números em um único tipo de dado, como inteiros, você pode utilizar uma expressão `CASE` para garantir que a conversão seja feita corretamente:

```sql
SELECT 
  id, 
  CASE WHEN rating~E'^\\d+$' THEN CAST(rating AS INTEGER) ELSE 0 END AS rating 
FROM ratings;
```

Isso converte todos os valores numéricos da coluna `rating` em inteiros e exibe zero para os valores que não forem numéricos.

### Conclusão

O uso de `CAST()` e `::` permite flexibilidade ao trabalhar com diferentes tipos de dados no PostgreSQL, garantindo conversões seguras e corretas.
