### PL/pgSQL Erros e Mensagens

#### Reportando Mensagens

No PL/pgSQL, utiliza-se a instrução `RAISE` para emitir mensagens. A sintaxe é a seguinte:

> Fonte: https://www.postgresqltutorial.com/postgresql-plpgsql/plpgsql-errors-messages/

```sql
RAISE nível formato;
```

- **Nível**: define a severidade do erro com os seguintes valores:
  - `DEBUG`
  - `LOG`
  - `NOTICE`
  - `INFO`
  - `WARNING`
  - `EXCEPTION`

  > Se você não especificar o nível, o nível `EXCEPTION` será usado por padrão, interrompendo a transação atual.

- **Formato**: uma string que especifica a mensagem, onde os placeholders `%` serão substituídos pelos argumentos correspondentes.

  > O número de placeholders deve ser igual ao número de argumentos. Caso contrário, o PostgreSQL retornará um erro:
  ```sql
  ERROR:  too many parameters specified for raise
  ```

##### Exemplo:
```sql
DO $$ 
BEGIN 
  RAISE INFO 'mensagem informativa %', NOW();
  RAISE LOG 'mensagem de log %', NOW();
  RAISE DEBUG 'mensagem de depuração %', NOW();
  RAISE WARNING 'mensagem de aviso %', NOW();
  RAISE NOTICE 'mensagem de aviso %', NOW();
END $$;
```

**Saída:**
```sql
INFO:  mensagem informativa 2024-09-20 10:20:30.123
WARNING:  mensagem de aviso 2024-09-20 10:20:30.123
NOTICE:  mensagem de aviso 2024-09-20 10:20:30.123
```

> Nem todas as mensagens são reportadas ao cliente. Apenas os níveis `INFO`, `WARNING` e `NOTICE` são enviados ao cliente, controlados pelos parâmetros de configuração `client_min_messages` e `log_min_messages`.

---

#### Gerando Erros

Para gerar um erro, usa-se o nível `EXCEPTION` na instrução `RAISE`. Além de gerar o erro, pode-se adicionar informações adicionais com a cláusula `USING`:

```sql
RAISE EXCEPTION 'mensagem de erro: %', valor 
  USING opção = expressão;
```

- **Opções disponíveis:**
  - `HINT`: fornece uma dica para facilitar a descoberta da causa do erro.
  - `DETAIL`: fornece informações detalhadas sobre o erro.
  - `ERRCODE`: identifica o código do erro (nome da condição ou código SQLSTATE).

##### Exemplo:
```sql
DO $$ 
DECLARE
  email VARCHAR(255) := 'info@postgresqltutorial.com';
BEGIN 
  -- verifica duplicidade de email
  RAISE EXCEPTION 'email duplicado: %', email 
    USING HINT = 'verifique o email novamente';
END $$;
```

**Saída:**
```sql
ERROR:  email duplicado: info@postgresqltutorial.com
HINT:   verifique o email novamente
```

##### Exemplo de `SQLSTATE`:
```sql
DO $$ 
BEGIN 
  RAISE SQLSTATE '77777';
END $$;
```

---

#### Resumo

- Use a instrução `RAISE` para emitir mensagens no PL/pgSQL.
- Utilize a cláusula `USING` para fornecer dicas ou informações adicionais em caso de erro.

---