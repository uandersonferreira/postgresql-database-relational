

## Apagar registros de uma tabela no PostgreSQL com `DELETE FROM` e `TRUNCATE TABLE`

### Comando básico para apagar linhas:
- Excluir linhas específicas de uma tabela:
```sql
DELETE FROM nome_tabela
WHERE condições;
```

- Excluir todos os registros da tabela, linha por linha:
```sql
DELETE FROM nome_tabela;
```

### Comando para limpar completamente uma tabela:
- `TRUNCATE TABLE`: Apaga todos os registros de uma vez, de maneira mais rápida que `DELETE`, mas sem acionar triggers.
```sql
TRUNCATE TABLE nome_tabela;
```

### Apagar registros de tabelas com relacionamentos (`FOREIGN KEY`)

#### Excluir registros em cascata automaticamente com `ON DELETE CASCADE`:
Se a tabela relacionada possuir uma chave estrangeira com a opção `ON DELETE CASCADE`, ao excluir o registro da tabela principal, os registros relacionados serão automaticamente excluídos.
```sql
-- Exemplo de criação de tabela com ON DELETE CASCADE
CREATE TABLE pedidos (
    cod_pedido SERIAL PRIMARY KEY,
    cod_cliente INT NOT NULL REFERENCES clientes(cod_cliente) ON DELETE CASCADE,
    cod_produto INT NOT NULL REFERENCES produtos(cod_produto),
    qtde SMALLINT NOT NULL
);

-- Excluir o cliente e todos os pedidos relacionados serão removidos automaticamente
DELETE FROM clientes WHERE cod_cliente = 1;
```

#### Excluir registros manualmente sem `ON DELETE CASCADE`:
Se a tabela não usar `ON DELETE CASCADE`, é necessário excluir manualmente os registros da tabela relacionada antes de excluir da tabela principal.

1. Exclua os registros da tabela relacionada:
```sql
DELETE FROM pedidos WHERE cod_cliente = 1;
```

2. Depois, exclua o registro da tabela principal:
```sql
DELETE FROM clientes WHERE cod_cliente = 1;
```

---
