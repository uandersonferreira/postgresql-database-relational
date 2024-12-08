CREATE TABLE clientes (
 cod_cliente  INT PRIMARY key,
 nome_cliente  VARCHAR(26) not NULL,
 sobrenome  VARCHAR NOT NULL
)


CREATE TABLE produtos (
 cod_produto INT PRIMARY KEY,
  nome_produto VARCHAR(30) not NULL,
  descricao TEXT NULL,
  preco NUMERIC CHECK(preco > 0) not NULL,
  qtde_estoque SMALLINT DEFAULT 0
)


CREATE TABLE pedidos (
 cod_pedido SERIAL PRIMARY KEY,
 cod_cliente INT not NULL REFERENCES clientes(cod_cliente),
 cod_produto INT NOT NULL,
 qtde SMALLINT NOT NULL,
  FOREIGN KEY (cod_produto) REFERENCES produtos(cod_produto)
)

-- Inserindo registros na tabela clientes
INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome) VALUES
(1, 'João', 'Silva'), -- Registro completo
(2, 'Maria', 'Oliveira'), -- Registro completo
(3, 'Carlos', 'Santos'), -- Registro completo
(4, 'Ana', 'Costa'), -- Registro completo
(5, 'Pedro', 'Almeida'), -- Registro completo
(6, 'Lucas', 'Pereira'), -- Registro completo
(7, 'Mariana', 'Ferreira'), -- Registro completo
(8, 'Fernanda', 'Gomes'), -- Registro completo
(9, 'Ricardo', 'Martins'), -- Registro completo
(10, 'Juliana', 'Barbosa'), -- Registro completo
(11, 'Paulo', 'Rocha'), -- Registro completo
(12, 'Sofia', 'Mendes'), -- Registro completo
(13, 'Gabriel', 'Lima'), -- Registro completo
(14, 'Beatriz', 'Ribeiro'), -- Registro completo
(15, 'Rafael', 'Carvalho'); -- Registro completo



-- Inserindo registros na tabela produtos
INSERT INTO produtos (cod_produto, nome_produto, descricao, preco, qtde_estoque) VALUES
(1, 'Notebook', 'Notebook com 16GB RAM e 512GB SSD', 3500.00, 10), -- Registro completo
(2, 'Mouse', NULL, 50.00, 100), -- Descrição nula
(3, 'Teclado', 'Teclado mecânico', 200.00, 50), -- Registro completo
(4, 'Monitor', NULL, 1200.00, 20), -- Descrição nula
(5, 'Impressora', 'Impressora multifuncional', 800.00, 15), -- Registro completo
(6, 'Cadeira', NULL, 300.00, 25), -- Descrição nula
(7, 'Mesa', 'Mesa de escritório', 500.00, 10), -- Registro completo
(8, 'Fone de Ouvido', NULL, 150.00, 40), -- Descrição nula
(9, 'Webcam', 'Webcam HD', 250.00, 30), -- Registro completo
(10, 'HD Externo', NULL, 400.00, 20), -- Descrição nula
(11, 'Pen Drive', 'Pen Drive 64GB', 60.00, 100), -- Registro completo
(12, 'Roteador', NULL, 200.00, 15), -- Descrição nula
(13, 'Smartphone', 'Smartphone 128GB', 2500.00, 5), -- Registro completo
(14, 'Tablet', NULL, 1500.00, 8), -- Descrição nula
(15, 'Carregador', 'Carregador USB-C', 80.00, 50), -- Registro completo
(16, 'Refrigerante', 'Refrigerante lata 150ml', 3.00, 10), -- Registro completo
(17, 'Refrigerante', 'Refrigerante lata 250ml', 4.25, 15), -- Registro completo
(18, 'Refrigerante', 'Refrigerante lata 350ml', 6.49, 25); -- Registro completo


-- Inserindo registros na tabela pedidos
INSERT INTO pedidos (cod_cliente, cod_produto, qtde) VALUES
(1, 1, 1), -- Pedido do cliente 1 para o produto 1
(2, 2, 2), -- Pedido do cliente 2 para o produto 2
(3, 3, 1), -- Pedido do cliente 3 para o produto 3
(4, 4, 3), -- Pedido do cliente 4 para o produto 4
(5, 5, 1), -- Pedido do cliente 5 para o produto 5
(6, 6, 2), -- Pedido do cliente 6 para o produto 6
(7, 7, 1), -- Pedido do cliente 7 para o produto 7
(8, 8, 3), -- Pedido do cliente 8 para o produto 8
(9, 9, 1), -- Pedido do cliente 9 para o produto 9
(10, 10, 2), -- Pedido do cliente 10 para o produto 10
(11, 11, 1), -- Pedido do cliente 11 para o produto 11
(12, 12, 3), -- Pedido do cliente 12 para o produto 12
(13, 13, 1), -- Pedido do cliente 13 para o produto 13
(14, 14, 2), -- Pedido do cliente 14 para o produto 14
(15, 15, 1); -- Pedido do cliente 15 para o produto 15
