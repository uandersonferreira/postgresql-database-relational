# Introdução aos Procedimentos Armazenados no PostgreSQL

### PROCEDIMENTOS ARMAZENADOS: (FUNCIONALIDADE): PostgreSQL `CREATE PROCEDURE`

**Introdução:**

- Procedimentos armazenados foram introduzidos no PostgreSQL 11 para suportar transações dentro de funções.
- Diferente de funções definidas pelo usuário, os procedimentos permitem o uso de transações com comandos de `COMMIT` e `ROLLBACK`.

**Sintaxe básica:**

```sql
CREATE [OR REPLACE] PROCEDURE nome_procedimento(arg1 tipo1, arg2 tipo2, ...) -- parametros que iremos receber
RETURNS tipo_dado -- a ser retornado 
LANGUAGE linguagem_usada -- plpgsql
AS delimitador -- $$
DECLARE 
 variáveis, se houver 
BEGIN
 código do procedimento 
END;
delimitador; -- $$

```

**Componentes:**

1. **Nome do Procedimento**: Definido após o comando `CREATE PROCEDURE`.
2. **Parâmetros**: Procedimentos podem aceitar zero ou mais parâmetros.
3. **Linguagem**: A linguagem usada geralmente é `plpgsql`, mas outras como SQL ou C também podem ser utilizadas.
4. **Corpo do Procedimento**: Definido usando uma string entre `$$` delimitadores.

- Parâmetros podem ser `IN` ou `INOUT`, mas não `OUT`.
- Procedimentos **não retornam valores** com o comando `RETURN`. Apenas parâmetros `INOUT` podem ser usados para retornar valores.

**Chamada de Procedimento:**
Para chamar um procedimento, utilize o comando `CALL`:

```sql
CALL transfer(1, 2, 1000);
```

### Inserir um produto na tabela de produtos

```sql
CREATE OR REPLACE PROCEDURE inserir_produto(
 p_cod_produto INT,
   p_nome_produto VARCHAR(30),
   p_descricao TEXT,
   p_preco NUMERIC,
   p_qtde_estoque SMALLINT
)
LANGUAGE plpgsql 
as $$ 
begin 
 INSERT into produtos(cod_produto, nome_produto, descricao, preco, qtde_estoque)
    VALUES (p_cod_produto, p_nome_produto, p_descricao, p_preco, p_qtde_estoque);
    raise notice 'Produto % cadastrado com sucesso!', p_nome_produto;-- emitindo um aviso ao user quando for inserido um produto 

END;
$$;
```

> Leia o readme para saber mais sobre o  [Raise](022-raise-msg-de-erros.md)

### Executar/Chamando o procedimento

```sql
CALL inserir_produto(1, 'Detergente'::VARCHAR, 'Detergente neutro 500ml'::TEXT, 2.35, 2::SMALLINT);

```

> Leia o readme para saber mais sobre o  [Conversão de dados](023-cast-de-dados-postgresql.md)

### Consulta a produtos com estoque baixo

```sql
-- Consulta a produtos com estoque baixo 
CREATE OR REPLACE PROCEDURE consultar_estoque_baixo(
 p_limite_estoque SMALLINT -- pois o que baixo para um produto, pode não ser o mesmo para outro produto
)
LANGUAGE plpgsql 
as $$
DECLARE resultado RECORD; -- Pois vamos retornar mais de um registro/tupla inteira(com mais de 1 registro/coluna) 
        -- e não somente um dado de uma coluna da tabela. Como se fosse um Array. 
BEGIN
    for resultado in -- para cada resultado dentro desse select 
        SELECT cod_produto, nome_produto, qtde_estoque
        from produtos
        WHERE qtde_estoque < p_limite_estoque
    LOOP -- faça um loop/pecorra todas as linhas/tuplas encontradas e guarde em resultado
     RAISE NOTICE 'Produto: % Estoque: %', resultado.nome_produto, resultado.qtde_estoque;
 end LOOP; -- encerra o laço for 
END;
$$;

call consultar_estoque_baixo(10::SMALLINT);

```

**Resumo Final:**

- Use o comando `CREATE PROCEDURE` para definir novos procedimentos armazenados.
- Use `CALL` para invocar o procedimento.
