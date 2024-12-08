### Conceito: Herança de Tabelas no PostgreSQL (Orientação a Objetos em Bancos de Dados)

No PostgreSQL, a herança de tabelas é uma forma de aplicar os princípios da programação orientada a objetos (OO) ao design de bancos de dados. Isso permite que uma tabela "filha" herde colunas e restrições de uma tabela "pai", similar ao conceito de herança de classes em linguagens de programação orientada a objetos. 

Ao usar herança no PostgreSQL:

1. **Superclasse**: Uma tabela que serve como base (ou superclasse), contendo colunas comuns que podem ser compartilhadas entre outras tabelas.
2. **Subclasse**: Tabelas que herdam todas as colunas e constraints da tabela superclasse, mas podem adicionar suas próprias colunas e restrições.

### Benefícios da Herança em Bancos de Dados:
- **Reutilização de Estruturas**: Assim como em OO, as tabelas filhas podem reutilizar a estrutura da tabela pai, evitando redundância.
- **Manutenção Simplificada**: Alterações feitas na tabela pai (superclasse) se propagam automaticamente para as tabelas filhas (subclasses), facilitando a manutenção.
- **Agrupamento de Dados Comuns**: Permite consultas que agregam dados de tabelas relacionadas sem a necessidade de junções complicadas.

### Sintaxe 

```sql
-- Superclasse: Tabela de publicações
CREATE TABLE publicacao (
  id SERIAL CONSTRAINT pk_id_pub PRIMARY KEY,
  nome VARCHAR(50),
  data_pub DATE,
  idioma VARCHAR(25)
);

-- Subclasse: Tabela de livros, herdando de publicacao
CREATE TABLE livros(
  isbn13 CHAR(13) UNIQUE,   -- Código ISBN único
  tipo_capa VARCHAR(20),    -- Tipo de capa (ex: dura, mole)
  edicao SMALLINT           -- Edição do livro
) INHERITS (publicacao);

-- Subclasse: Tabela de revistas, herdando de publicacao
CREATE TABLE revista(
  issn CHAR(8),             -- Código ISSN da revista
  numero SMALLINT,          -- Número da edição
  UNIQUE (issn, numero)     -- Restrição única para ISSN e número
) INHERITS (publicacao);

-- Alterações na tabela principal afetam todas as subclasses
-- Adicionando uma coluna à tabela publicacao
ALTER TABLE publicacao
ADD COLUMN nPaginas SMALLINT;

-- Definindo um valor padrão para a nova coluna
ALTER TABLE publicacao
ALTER COLUMN nPaginas SET DEFAULT 0;

-- Removendo uma coluna da tabela publicacao (também afetará as subclasses)
ALTER TABLE publicacao
DROP COLUMN nPaginas;

-- Atualizando um registro em publicacao (alterará os dados na tabela correspondente)
UPDATE publicacao
SET data_pub = '2020-04-15'
WHERE id = 15;  -- Afeta o registro da tabela revista com id 15
```

### Explicação

1. **Tabela `publicacao` (Superclasse)**:
   - Define atributos comuns para todos os tipos de publicações, como `id`, `nome`, `data_pub`, e `idioma`.
   
2. **Tabela `livros` (Subclasse)**:
   - Herda os atributos da tabela `publicacao` e define novos atributos específicos, como `isbn13`, `tipo_capa`, e `edicao`.

3. **Tabela `revista` (Subclasse)**:
   - Herda os atributos da tabela `publicacao` e adiciona atributos específicos, como `issn` e `numero`.

### Considerações Importantes:
- **Propagação de Alterações**: Qualquer alteração na superclasse (`publicacao`), como adicionar ou remover colunas, se propagará automaticamente para as subclasses (`livros` e `revista`).
- **Consultas Unificadas**: É possível realizar consultas em todas as tabelas herdadas simultaneamente ao consultar a tabela pai.