# **Tipos de Dados no PostgreSQL**

#### **1. Tipos Numéricos**

- **`smallint`**: Inteiros pequenos (-32,768 a 32,767). 2 bytes.
- **`integer`** (`int`): Inteiros de tamanho médio (-2,147,483,648 a 2,147,483,647). 4 bytes.
- **`bigint`**: Inteiros grandes (-9,223,372,036,854,775,808 a 9,223,372,036,854,775,807). 8 bytes.
- **`decimal`** ou **`numeric`**: Números com precisão exata. Tamanho variável.
  - **Opções:** `decimal(p, s)` ou `numeric(p, s)`, onde p é a precisão e s é a escala.
- **`real`**: Ponto flutuante de precisão simples (~6 dígitos). 4 bytes.
- **`double precision`**: Ponto flutuante de precisão dupla (~15 dígitos). 8 bytes.
- **`serial`**, **`bigserial`**: Inteiros auto-incrementais. 4 bytes (serial), 8 bytes (bigserial).

#### **2. Tipos Monetários**

- **`money`**: Valores monetários com precisão fixa. 8 bytes. (**Descontinuado**: Use `numeric` ou `decimal`).

#### **3. Tipos de Texto**

- **`char(n)`**: Cadeia de caracteres de comprimento fixo.
- **`varchar(n)`**: Cadeia de caracteres de comprimento variável.
- **`text`**: Cadeia de caracteres de comprimento ilimitado.

#### **4. Tipos Data/Hora**

- **`date`**: Data (ano, mês, dia).
- **`timestamp [ (p) ] [ without time zone ]`**: Data e hora sem fuso horário.
- **`timestamp [ (p) ] with time zone`**: Data e hora com fuso horário.
- **`time [ (p) ] [ without time zone ]`**: Hora sem fuso horário.
- **`time [ (p) ] with time zone`**: Hora com fuso horário.
- **`interval [ (p) ]`**: Intervalo de tempo (diferença entre datas/horas).

#### **5. Tipos Booleanos**

- **`boolean`**: Verdadeiro (`TRUE`), Falso (`FALSE`), ou Nulo (`NULL`).

#### **6. Tipos Geométricos**

- **`point`**: Ponto no plano (x, y).
- **`line`**: Linha infinita.
- **`lseg`**: Segmento de linha.
- **`box`**: Retângulo.
- **`path`**: Caminho (fechado ou aberto).
- **`polygon`**: Polígono.
- **`circle`**: Círculo.

#### **7. Tipos de Redes**

- **`cidr`**: Rede IP (IPv4/IPv6).
- **`inet`**: Endereços IP (IPv4/IPv6).
- **`macaddr`**: Endereços MAC.
- **`macaddr8`**: Endereço MAC (formato EUI-64).

#### **8. Tipos JSON**

- **`json`**: Armazena JSON sem validação.
- **`jsonb`**: Armazena JSON binário, com indexação.

#### **9. Tipos de Arrays**

- **`tipo[]`**: Armazena arrays de qualquer tipo (e.g., `integer[]`).

#### **10. Tipos Enumerados**

- **`enum`**: Conjunto de valores predefinidos (e.g., `('active', 'inactive', 'pending')`).

#### **11. Outros Tipos**

- **`bytea`**: Dados binários ("array de bytes").
- **`uuid`**: Identificador universal único.
- **`xml`**: Dados no formato XML.
- **`tsquery`**: Consulta de busca de texto.
- **`tsvector`**: Documento para busca de texto.
- **`pg_lsn`**: Número de sequência do log do PostgreSQL.
