# Como usar Arrays em colunas de tabelas no PostgreSQL

No PostgreSQL, arrays são usados para armazenar vários valores em uma única coluna. Eles permitem associar múltiplos dados de um mesmo tipo a uma única entrada em uma tabela. É possível acessar, modificar e realizar consultas nesses arrays de forma eficiente.

### Sintaxe PostgreSQL:
```sql
nome_coluna tipo[]
```
- Os arrays podem ser de qualquer tipo de dados suportado pelo PostgreSQL.
- Por padrão, os índices de arrays no PostgreSQL começam em 1, diferentemente da maioria das linguagens de programação, onde o índice começa em 0.

### Sintaxe ANSI SQL:
```sql
nome_coluna tipo ARRAY[tamanho]
nome_coluna tipo ARRAY[]
```
- Em ANSI SQL, você pode definir o tamanho do array, embora seja opcional.

### Exemplo prático:

```sql
CREATE TABLE escalaTrabalho (
  codFunc SMALLINT,
  escala CHAR(3)[]
);

INSERT INTO escalaTrabalho (codFunc, escala)
VALUES
(1, '{"SEG", "TER", "QUA"}'),
(2, '{"QUI", "SEX", "SAB"}'),
(3, '{"SEG", "QUA", "SEX"}');

SELECT * FROM escalaTrabalho;
```

### Acessando Elementos:
- Para acessar um elemento específico de um array, você pode usar a notação com colchetes `[]`.
  
```sql
-- Obter o primeiro dia de trabalho do funcionário 1
SELECT escala[1] FROM escalaTrabalho WHERE codFunc = 1;
```

### Funções e Operadores Úteis:
- `ANY`: Verifica se qualquer elemento no array atende à condição.
- `ALL`: Verifica se todos os elementos no array atendem à condição.
- `ARRAY_APPEND()`: Adiciona um elemento ao final do array.
- `ARRAY_REMOVE()`: Remove um elemento específico do array.

### Exemplo de Consultas:
```sql
-- Quais funcionários trabalham na quarta-feira?
SELECT codFunc FROM escalaTrabalho WHERE 'QUA' = ANY(escala);

-- Alterar a escala de trabalho do funcionário 3
UPDATE escalaTrabalho
SET escala = ARRAY['TER', 'QUI', 'SAB']
WHERE codFunc = 3;

-- Adicionar um dia à escala de trabalho do funcionário 1
UPDATE escalaTrabalho
SET escala = ARRAY_APPEND(escala, 'SEX')
WHERE codFunc = 1;
```

### Observações:
1. Arrays no PostgreSQL não possuem restrição de tamanho fixo, a menos que você defina explicitamente.
2. É possível realizar operações de comparação entre arrays, como verificar se um array contém outro.
3. Use funções específicas para manipulação de arrays, como `ARRAY_AGG()` (agregação de arrays) e operadores como `@>`, que verifica se um array contém todos os elementos de outro array.

