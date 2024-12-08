
### **Curso de PostgreSQL - Como Criar e Executar Views**

**O que é uma View (Visão)?**

- Uma **View** é uma tabela virtual (lógica) baseada no resultado de uma consulta SQL (pré-definida). Embora pareça uma tabela regular, ela não armazena dados fisicamente. Em vez disso, os dados exibidos na View são recuperados dinamicamente a partir de uma ou mais tabelas, ou até outras views, sempre que a View é consultada.
  
- **Atualização de dados:** A View sempre apresenta dados atualizados porque o sistema de banco de dados executa a consulta definida pela View toda vez que um usuário a acessa. Ou seja, a View não mantém uma cópia dos dados, mas reflete o estado atual das tabelas base.

---

### **Motivação e Aplicações das Views**

- **Simplificação de Consultas:** Views permitem que consultas complexas envolvendo múltiplas tabelas sejam encapsuladas em uma consulta mais simples. O usuário final pode acessar dados de maneira facilitada, sem precisar conhecer a complexidade do esquema de tabelas subjacente.
  
- **Segurança:** Uma View pode ser usada para restringir o acesso a determinadas colunas ou linhas de uma tabela, implementando uma camada adicional de segurança. Por exemplo, você pode limitar os dados retornados por meio de uma cláusula `WHERE`, permitindo que diferentes usuários vejam diferentes subconjuntos de dados.
  
- **Abstração e Isolamento:** As Views fornecem um nível de abstração entre as aplicações e as tabelas subjacentes. Mudanças na estrutura das tabelas base (como adicionar colunas) podem ser feitas sem afetar as aplicações que dependem das Views.

---

### **Comandos SQL Relacionados às Views**

- **`CREATE VIEW`**: Cria uma nova View.
- **`CREATE OR REPLACE VIEW`**: Cria uma nova View ou substitui uma existente sem perder permissões já concedidas.
- **`ALTER VIEW`**: Modifica a definição da View (nomes de colunas ou da própria View), mas não altera a consulta subjacente.
- **`DROP VIEW`**: Remove uma View do banco de dados.

---

### **Sintaxe Genérica para Criar uma View**

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

- **`view_name`**: O nome que você deseja dar à View.
- **`SELECT`**: A consulta SQL cujos resultados serão exibidos na View.
- **`WHERE`**: Opcional; usado para restringir as linhas que serão exibidas na View.

---

### **Exemplo Prático**

```sql
CREATE OR REPLACE VIEW vendas AS
  SELECT cl.nome_cliente AS Cliente,
         pr.nome_produto AS Produto,
         pe.qtde AS Quantidade,
         pe.cod_pedido AS Pedido,
         pr.preco * pe.qtde AS Fatura
  FROM pedidos pe
  INNER JOIN clientes cl ON pe.cod_cliente = cl.cod_cliente
  INNER JOIN produtos pr ON pe.cod_produto = pr.cod_produto;

-- Consultando a view
SELECT * FROM vendas;

-- Consulta agregada sobre a view
SELECT Cliente, SUM(Fatura) AS TotalFatura
FROM vendas
GROUP BY Cliente;
```

---

### **Comandos Adicionais para Manipular Views**

- **`ALTER VIEW`**: Alterar propriedades da View, como o nome das colunas ou da própria View.
  
  ```sql
  ALTER VIEW vendas RENAME TO faturas;
  ```

- **`DROP VIEW`**: Remover a View.
  
  ```sql
  DROP VIEW IF EXISTS faturas CASCADE;
  ```

---

### **Como as Views Funcionam Internamente**

Por debaixo dos panos, quando você consulta uma View, o banco de dados executa a consulta original definida na criação da View, como se fosse uma subconsulta embutida. Ou seja, o PostgreSQL substitui a referência à View pela consulta SQL que foi usada para criá-la. Isso garante que os dados sejam sempre atualizados, mas também pode impactar o desempenho quando a consulta definida pela View for complexa ou envolver muitas junções.

---

### **Observações sobre Atualização de Dados através de Views**

- Embora as Views permitam consultar dados, elas não são necessariamente editáveis. Para que seja possível realizar operações de `INSERT`, `UPDATE` ou `DELETE` diretamente em uma View, algumas condições devem ser atendidas (por exemplo, a View deve estar diretamente ligada a uma única tabela, sem agregações ou funções complexas).

---
