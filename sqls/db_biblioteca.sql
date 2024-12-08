CREATE TABLE tbl_autores (
 ID_Autor integer CONSTRAINT pk_id_autor PRIMARY KEY,
 Nome_Autor varchar(30) NOT NULL, 
 Sobrenome_Autor varchar(40) NOT NULL,
 Data_Nasc date
);


CREATE TABLE tbl_editoras (
 ID_Editora integer CONSTRAINT pk_id_editora PRIMARY KEY,
 Nome_Editora varchar(35) UNIQUE NOT NULL
);

CREATE TABLE tbl_generos (
 ID_Genero integer CONSTRAINT pk_id_genero PRIMARY KEY,
 Nome_Genero varchar(40) NOT NULL,
 UNIQUE(Nome_Genero)
);


CREATE TABLE tbl_livros (
 ID_Livro SERIAL CONSTRAINT pk_id_livro PRIMARY KEY,
 Nome_Livro varchar(50) NOT NULL,
 Autor integer NOT NULL,
 Editora integer NOT NULL,
 Data_Pub date,
 Genero integer NOT NULL,
 Preco_Livro money,
 FOREIGN KEY (Autor) REFERENCES tbl_autores (ID_Autor) ON DELETE CASCADE,
 FOREIGN KEY (Editora) REFERENCES tbl_editoras (ID_Editora) ON DELETE CASCADE,
 FOREIGN KEY (Genero) REFERENCES tbl_generos (ID_Genero) ON DELETE CASCADE
);


INSERT INTO tbl_editoras (ID_Editora, Nome_Editora) VALUES (1,'Prentice Hall');
INSERT INTO tbl_editoras (ID_Editora, Nome_Editora) VALUES (2,'O´Reilly');
INSERT INTO tbl_editoras (ID_Editora, Nome_Editora) VALUES (3,'Microsoft Press');
INSERT INTO tbl_editoras (ID_Editora, Nome_Editora) VALUES (4,'Wiley');
INSERT INTO tbl_editoras (ID_Editora, Nome_Editora) VALUES (5,'McGraw-Hill Education');


INSERT INTO tbl_autores
VALUES
(1, 'Daniel', 'Barret'),
(2, 'Gerald', 'Carter'),
(3, 'Mark', 'Sobell'),
(4, 'William', 'Stanek'),
(5, 'Richard', 'Blum'),
(6, 'Jostein', 'Gaarder'),
(7, 'Umberto', 'Eco'),
(8, 'Neil', 'De Grasse Tyson'),
(9, 'Stephen', 'Hawking'),
(10, 'Stephen', 'Jay Gould'),
(11, 'Charles', 'Darwin'),
(12, 'Alan', 'Turing'),
(13, 'Simon', 'Monk'),
(14, 'Paul', 'Scherz');

INSERT INTO tbl_generos
VALUES
(1, 'Tecnologia'),
(2, 'História'),
(3, 'Literatura'),
(4, 'Astronomia'),
(5, 'Botânica'),
(6, 'Geografia'),
(7, 'Matemática'),
(8, 'Química'),
(9, 'Engenharia'),
(10, 'Ficção Científica');


INSERT INTO tbl_livros (Nome_Livro, Data_Pub, Preco_Livro, Genero, Autor, Editora)
VALUES
('Linux Command Line and Shell Scripting', '20150109', 68.35, 1, 5, 4),
('SSH, the Secure Shell', '20050517', 58.30, 1, 1, 2),
('Using Samba', '20031221', 61.45, 1, 2, 2),
('Fedora and Red Hat Linux', '20140110', 62.24, 1, 3, 1),
('Windows Server 2012 Inside Out', '20130125', 66.80, 1, 4, 3),
('Microsoft Exchange Server 2010', '20101201', 45.30, 1, 4, 3),
('Practical Electronics for Inventors', '20160324', 67.80, 1, 13, 5);