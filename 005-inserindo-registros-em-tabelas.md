# PostgreSQL - Inserir registros em tabelas com `INSERT INTO`

### Sintaxe Geral:

```sql 
INSERT INTO nome_tabela (coluna1, coluna2, ...) 
VALUES (dado1, dado2, ...);
```

```sql
INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome) 
VALUES (1, 'Uanderson', 'Oliveira');

INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome) 
VALUES (2, 'Ana', 'Sousa');

INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome) 
VALUES (3, 'João', 'Pereira');
```

- Variação: Inserindo em lote em um so insert

```sql
INSERT INTO produtos (cod_produto, nome_produto, descricao, preco, qtde_estoque)
VALUES 
(1, 'Álcool em Gel', 'Garrafa de álcool em gel de 1 litro', 12.90, 20),
(2, 'Luvas de Látex', 'Caixa de luvas de látex com 100 unidades', 32.50, 25),
(3, 'Pasta de Dentes', 'Tubo de pasta de dentes de 90g', 3.60, 12),
(4, 'Sabonete', 'Sabonete antibacteriano', 3.50, 5),
(5, 'Enxaguante Bucal', 'Antisséptico bucal de 500ml', 17.00, 28);
```

- Variação: Inserindo em lote, onde o id é gerado automaticamente (não precisa ser informado)

```sql
INSERT INTO pedidos (cod_cliente, cod_produto, qtde)
VALUES
(1, 2, 3),
(2, 3, 2),
(1, 3, 4);

```
