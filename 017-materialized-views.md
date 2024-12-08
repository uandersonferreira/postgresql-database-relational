# **Visualizações Materializadas no PostgreSQL**

### **Conceito:**

- Uma *Visualização Materializada* é um objeto de banco de dados que armazena fisicamente o resultado de uma consulta, diferentemente das *views* tradicionais, que são virtuais.
- Elas são usadas para melhorar a performance ao acessar consultas complexas, especialmente em *data warehouses* e aplicações de *business intelligence*.
- São ideais quando o conjunto de dados precisa ser acessado frequentemente, mas não requer atualização constante em tempo real.

### **Criação:**

- **Sintaxe básica**:
  
  ```sql
  CREATE MATERIALIZED VIEW [IF NOT EXISTS] view_name
  AS query
  WITH [NO] DATA;
  ```

  - `view_name`: Nome da visualização materializada.
  - `query`: Consulta que define os dados a serem armazenados.
  - `WITH DATA`: Carrega os dados no momento da criação.
  - `WITH NO DATA`: Cria a visualização, mas não a popula, tornando-a ilegível até ser carregada com dados.

**Exemplo de Criação:**

```sql
CREATE MATERIALIZED VIEW vendas_por_categoria
AS
SELECT c.categoria_nome, SUM(v.valor_total) AS total_vendas
FROM vendas v
JOIN categorias c ON v.categoria_id = c.categoria_id
GROUP BY c.categoria_nome
WITH NO DATA;
```

- Aqui, a visualização `vendas_por_categoria` é criada, mas não carregada imediatamente devido ao `WITH NO DATA`.

### **Atualização dos Dados:**

- Para carregar ou atualizar os dados de uma visualização materializada:

  ```sql
  REFRESH MATERIALIZED VIEW view_name;
  ```

  - Isso bloqueia as tabelas subjacentes durante a atualização. Nenhuma consulta pode ser feita até o fim do carregamento.

- Para evitar bloqueios, pode-se usar a opção `CONCURRENTLY`:

  ```sql
  REFRESH MATERIALIZED VIEW CONCURRENTLY view_name;
  ```

  - **Requisito**: A visualização deve ter um índice único para suportar a atualização concorrente.
  
**Exemplo com `CONCURRENTLY`**:
  
```sql
CREATE UNIQUE INDEX idx_categoria ON vendas_por_categoria (categoria_nome);

REFRESH MATERIALIZED VIEW CONCURRENTLY vendas_por_categoria;
```

- O índice é necessário para usar a opção `CONCURRENTLY` e atualizar a view sem bloquear as tabelas subjacentes.

### **Remoção:**

- Para remover uma visualização materializada:

  ```sql
  DROP MATERIALIZED VIEW view_name;
  ```

---

### **Exemplo Prático Completo:**

1. **Criando a visualização:**

   ```sql
   CREATE MATERIALIZED VIEW view_compras
   AS
   SELECT cl.nome_cliente, pr.nome_produto, pe.qtde
   FROM pedidos pe
   INNER JOIN clientes cl ON pe.cod_cliente = cl.cod_cliente
   INNER JOIN produtos pr ON pe.cod_produto = pr.cod_produto
   ORDER BY cl.nome_cliente
   WITH NO DATA;
   ```

   - Aqui, a visualização é criada com `WITH NO DATA`, o que significa que ainda não contém dados.

2. **Carregando dados:**

   ```sql
   REFRESH MATERIALIZED VIEW view_compras;
   ```

   - Carrega os dados na visualização para torná-la legível.

3. **Consultando a visualização:**

   ```sql
   SELECT * FROM view_compras;
   ```

4. **Alterando uma visualização materializada:**

   ```sql
   ALTER MATERIALIZED VIEW view_compras
   RENAME COLUMN nome_produto TO "Produto";
   ```

   - O comando renomeia a coluna `nome_produto` para `"Produto"`. Aspas duplas garantem que o nome é tratado literalmente, sensível a maiúsculas e minúsculas.

5. **Criando um índice único para usar `CONCURRENTLY`:**

   ```sql
   CREATE UNIQUE INDEX idx_compras ON view_compras (nome_cliente);
   ```

   - Cria um índice único para permitir atualizações concorrentes.

6. **Atualizando com `CONCURRENTLY`:**

   ```sql
   REFRESH MATERIALIZED VIEW CONCURRENTLY view_compras;
   ```

7. **Removendo a visualização materializada:**

   ```sql
   DROP MATERIALIZED VIEW view_compras;
   ```

---

### **Exemplo Adicional: Atualizando Dados Selecionados**

- Se você quiser atualizar apenas uma visualização materializada com dados filtrados, pode fazer algo como:

```sql
CREATE MATERIALIZED VIEW vendas_mensal
AS
SELECT c.categoria_nome, SUM(v.valor_total) AS total_vendas
FROM vendas v
JOIN categorias c ON v.categoria_id = c.categoria_id
WHERE v.data_venda >= '2024-01-01' AND v.data_venda < '2024-02-01'
GROUP BY c.categoria_nome
WITH DATA;
```

- Neste exemplo, a visualização contém apenas dados de janeiro de 2024, útil para análises específicas.

---

### **Resumo Final:**

- Use *CREATE MATERIALIZED VIEW* para criar uma visualização materializada. Defina se deseja carregar os dados de imediato com `WITH DATA` ou não com `WITH NO DATA`.
- Atualize os dados com *REFRESH MATERIALIZED VIEW*. Para evitar bloqueios, use *CONCURRENTLY* se a visualização tiver um índice único.
- Para alterar a estrutura, use *ALTER MATERIALIZED VIEW*. Para excluir, use *DROP MATERIALIZED VIEW*.

---
