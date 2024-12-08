# Como usar tipo JSON em colunas no PostgreSQL

## JSON

Acrônimo de *JavaScript Object Notation*

Formato aberto e popular para representações e troca de dados,
assim como XML, YAML (porém mais leve e simples).

É fácil para humanos ler e editar esse formato, e assim para os computadores processarem e gerarem dados JSON.

É independente de linguagem de programação.

Criado por Douglas Crockford, o JSON foi formalizado na RFC 4627, em 2006.

Baseado em um subconjunto do JavaScript, a gramática do JSON está documentada em seu site oficial:

> <www.json.org>

## Documentos JSON

Um documento (objeto) JSON é um conjunto não-ordenado de dados armazenados em um par `"nome":valor` (campo), que inicia e termina com chaves `{}`.

Todos os nomes-chave são englobados em aspas duplas, e são separados de seus valores por dois-pontos:.

os pares (campos) são separados um do outro por *vírgulas*.

`"chave" : valor`

Exemplo:

```json
[
  {
    "name": "Molecule Man",
    "age": 29,
    "secretIdentity": "Dan Jukes",
    "powers": ["Radiation resistance", "Turning tiny", "Radiation blast"]
  },
  {
    "name": "Madame Uppercut",
    "age": 39,
    "secretIdentity": "Jane Wilson",
    "powers": [
      "Million tonne punch",
      "Damage resistance",
      "Superhuman reflexes"
    ]
  }
]

```

Exemplo SQL:

```sql
CREATE TABLE peds(
 id serial not NULL PRIMARY KEY,
    pedido json not NULL
 
);
INSERT into peds(pedido)
VALUES
('{"comprador": "Fábio", "produtos": { "bebida": "Suco de Caju", "comida": "Pizza de Atum" }}'),
('{"comprador": "Laura Mendes", "produtos": { "bebida": "Refrigerante", "comida": "Hambúrguer" }}'),
('{"comprador": "Pedro Santos", "produtos": { "bebida": "Água", "comida": "Salada" }}'),
('{"comprador": "Carla Souza", "produtos": { "bebida": "Chá Gelado", "comida": "Sanduíche" }}'),
('{"comprador": "Rafael Lima", "produtos": { "bebida": "Café", "comida": "Bolo de Chocolate" }}'),
('{"comprador": "Fernanda Alves", "produtos": { "bebida": "Suco de Laranja", "comida": "Torta de Frango" }}');



-- Consultas
SELECT * from peds;

-- Operadores JSON

-- Retornar nomes dos compradores em formato JSON com " "
SELECT pedido -> 'comprador' as Comprador
from peds;

-- Retornar nomes dos compradores em formato TEXT sem " "
SELECT pedido ->> 'comprador' as Comprador
from peds;


-- Retorna as bebidas vendidas do pedido completo.
SELECT pedido -> 'produtos' ->> 'bebida' as "Bebidas Vendidas"
from peds;

-- Caso estivessem dentro de um array:
-- Retorna as bebidas vendidas do pedido completo
SELECT pedido -> 'produtos' [ -> posicao_array ] ->> 'bebida' as "Bebidas Vendidas"
from peds;

-- JSON na Cláusula where: filtros 
-- Quem comprou Café ?
SELECT pedido ->> 'comprador' as Comprador
from peds
WHERE pedido -> 'produtos' ->> 'bebida' = 'Café';


-- FUNÇÕES JSON 
SELECT json_each(pedido) -- retorna 'cada' um das chaves:valores separadas
from peds;

SELECT json_each_text(pedido) -- retorna em formato de TEXT
from peds;

SELECT json_object_keys(pedido -> 'produtos') -- retorna as chaves dos valores
from peds;

```
