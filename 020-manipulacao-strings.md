# Funções de Manipulação de Strings no PostgreSQL

## 1. Concatenar Strings: Operador `||`

O operador `||` concatena duas ou mais strings. Pelo menos uma das entradas deve ser uma string.

### Sintaxe

```sql
string_1 || string_2
```

### Exemplos

```sql
SELECT nome_autor || ' ' || sobrenome_autor AS "nome_completo"
FROM tbl_autores
ORDER BY sobrenome_autor;

SELECT 'O livro ' || nome_livro || ' custa ' || preco_livro || ' reais' AS "Descrição do Livro"
FROM tbl_livros
WHERE id_livro = 3;
```

## 2. Função `CONCAT`

Outra forma de concatenar strings é usando a função `CONCAT`.

### Sintaxe

```sql
CONCAT(string_1, string_2, ...)
```

### Exemplos

```sql
SELECT CONCAT(nome_autor, ' ', sobrenome_autor) AS "nome_completo"
FROM tbl_autores
ORDER BY sobrenome_autor;
```

### Observação

A função `CONCAT` aceita múltiplos argumentos e não exige que todos sejam strings. Ele converte outros tipos de dados automaticamente.

---

## 3. Contagem de Bits: `BIT_LENGTH`

Retorna o número de bits em uma string.

### Sintaxe

```sql
BIT_LENGTH(string)
```

### Exemplos

```sql
SELECT BIT_LENGTH('Uanderson');

SELECT nome_livro, BIT_LENGTH(nome_livro) 
FROM tbl_livros;
```

---

## 4. Contagem de Caracteres: `CHAR_LENGTH` ou `LENGTH`

Ambas as funções retornam o número de caracteres em uma string. São equivalentes.

### Sintaxe

```sql
CHAR_LENGTH(string) -- ou LENGTH(string)
```

### Exemplos

```sql
SELECT CHAR_LENGTH('Uanderson');

SELECT nome_livro, CHAR_LENGTH(nome_livro)
FROM tbl_livros;
```

---

## 5. Converter String para Minúsculas: `LOWER`

Converte todos os caracteres de uma string para minúsculas.

### Sintaxe

```sql
LOWER(string)
```

### Exemplos

```sql
SELECT LOWER('UANDERSON');
SELECT LOWER(nome_editora) 
FROM tbl_editoras;
```

---

## 6. Converter String para Maiúsculas: `UPPER`

Converte todos os caracteres de uma string para maiúsculas.

### Sintaxe

```sql
UPPER(string)
```

### Exemplos

```sql
SELECT UPPER('uanderson');
SELECT UPPER(nome_editora)
FROM tbl_editoras;
```

---

## 7. Substituir Substring: `OVERLAY`

Substitui uma parte específica de uma string por outra.

### Sintaxe

```sql
OVERLAY(string PLACING nova_string FROM posição [FOR comprimento])
```

- **posição**: A posição inicial onde a nova string será inserida.
- **comprimento**: (Opcional) O número de caracteres que serão substituídos.

### Exemplos

```sql
SELECT OVERLAY('Wanderson' PLACING 'U' FROM 1); -- Substitui o primeiro caractere
SELECT OVERLAY('Bózoum' PLACING 'son' FROM 3 FOR 4); -- Substitui 4 caracteres a partir da 3ª posição
```

---

## 8. Encontrar Substring: `POSITION`

Retorna a posição de uma substring dentro de uma string.

### Sintaxe

```sql
POSITION(substring IN string)
```

### Exemplos

```sql
SELECT POSITION('Treina' IN 'Bóson Treinamentos');
SELECT POSITION('Press' IN nome_editora) 
FROM tbl_editoras;
```

### Observação

A busca é sensível a maiúsculas e minúsculas.

---

## 9. Extrair Substring: `SUBSTRING`

Extrai uma parte da string com base na posição e quantidade de caracteres.

### Sintaxe

```sql
SUBSTRING(string [FROM posição] [FOR comprimento])
```

- **posição**: A posição inicial (opcional).
- **comprimento**: O número de caracteres a serem extraídos (opcional).

### Exemplos

```sql
SELECT SUBSTRING('Uanderson Ferreira de Oliveira' FROM 11); -- Extrai a partir do caractere 11
SELECT SUBSTRING('Uanderson Ferreira de Oliveira' FROM 7 FOR 3); -- Extrai 3 caracteres a partir do caractere 7
```

---

## 10. Remover Caracteres: `TRIM`

Remove caracteres de uma string, por padrão, remove espaços em branco.

### Sintaxe

```sql
TRIM([LEADING | TRAILING | BOTH] [caracteres] FROM string)
```

- **LEADING**: Remove os caracteres do início da string.
- **TRAILING**: Remove os caracteres do final da string.
- **BOTH**: Remove os caracteres de ambos os lados da string.

### Exemplos

```sql
-- Remove espaços do início
SELECT TRIM(LEADING FROM '    texto    '); -- Resultado: 'texto    '

-- Remove espaços do final
SELECT TRIM(TRAILING FROM '    texto    '); -- Resultado: '    texto'

-- Remove espaços de ambos os lados (padrão)
SELECT TRIM(BOTH FROM '    texto    '); -- Resultado: 'texto'
```
