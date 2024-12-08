-- SUPER class/tabela 
CREATE TABLE publicacao (
  id serial CONSTRAINT pk_id_pub PRIMARY KEY,
  nome VARCHAR(50),
  data_pub date,
  idioma VARCHAR(25)
  );
  
  CREATE table livros(
  	isbn13 CHAR(13) UNIQUE,
    tipo_capa VARCHAR(20),
    edicao SMALLINT
  ) INHERITS (publicacao); -- herda a estrutura da tabela publicação 
  
  CREATE TABLE revista(
  	issn CHAR(8),
    numero SMALLINT,
    UNIQUE(issn, numero)
  ) INHERITS (publicacao); -- herda a estrutura da tabela publicação 
  


INSERT INTO publicacao (nome, data_pub, idioma) VALUES
('Publicação A', '2023-01-15', 'Português'),
('Publicação B', '2023-02-20', 'Inglês'),
('Publicação C', '2023-03-10', 'Espanhol'),
('Publicação D', '2023-04-05', 'Francês'),
('Publicação E', '2023-05-25', 'Alemão');


INSERT INTO livros (isbn13, tipo_capa, edicao, nome, data_pub, idioma) VALUES
('9781234567890', 'Dura', 1, 'Livro A', '2023-01-15', 'Português'),
('9781234567891', 'Mole', 2, 'Livro B', '2023-02-20', 'Inglês'),
('9781234567892', 'Dura', 3, 'Livro C', '2023-03-10', 'Espanhol'),
('9781234567893', 'Mole', 1, 'Livro D', '2023-04-05', 'Francês'),
('9781234567894', 'Dura', 2, 'Livro E', '2023-05-25', 'Alemão');


INSERT INTO revista (issn, numero, nome, data_pub, idioma) VALUES
('12345678', 1, 'Revista A', '2023-01-15', 'Português'),
('12345679', 2, 'Revista B', '2023-02-20', 'Inglês'),
('12345680', 3, 'Revista C', '2023-03-10', 'Espanhol'),
('12345681', 4, 'Revista D', '2023-04-05', 'Francês'),
('12345682', 5, 'Revista E', '2023-05-25', 'Alemão');


  
  
  