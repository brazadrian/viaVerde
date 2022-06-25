CREATE SCHEMA IF NOT EXISTS `notas`;

USE notas;

-- -----------------------------------------------------
-- CRIANDO TABELA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notas.pessoas
(
	id INT,
    nome VARCHAR(50),
    sexo CHAR(1),
    nascimento DATE
);

-- -----------------------------------------------------
-- USANDO SERIAL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notas.produto_serial
(
	id SERIAL PRIMARY KEY, -- TIPO NÚMERO DE SÉRIE
    nome VARCHAR(50),
    preco NUMERIC
);
-- POPULANDO
INSERT INTO produto_serial (nome, preco) VALUES ("Caneta", 2);

-- CONSULTA
SELECT * FROM notas.produto_serial;

-- -----------------------------------------------------
-- USANDO DEFAULT
-- -----------------------------------------------------

CREATE TABLE notas.produto_default
(
	id INTEGER,
    nome TEXT,
    qtde_estoque INTEGER DEFAULT 0
    -- data_aquisicao date DEFAULT CURRENT_DATE
    -- data_aquisicao DATE DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- NOT NULL
-- -----------------------------------------------------

CREATE TABLE produto_notnull
(
	id INTEGER NOT NULL,
	nome TEXT NOT NULL,
	valor NUMERIC
);

-- POPULANDO A TABELA
INSERT INTO notas.produto_notnull (id, nome) VALUES (1, 'Caneta');
INSERT INTO notas.produto_notnull (id, nome, valor) VALUES (2, 'Lapis', 2.5);
INSERT INTO notas.produto_notnull (id, valor) VALUES(1, 1.5 ); -- ESSA DÁ ERRO, PORQUE O NOME NÃO PODE SER NULO

-- -----------------------------------------------------
-- UNIQUE
-- -----------------------------------------------------

CREATE TABLE pessoa_unique
(
	id INTEGER PRIMARY KEY,
    nome VARCHAR(20) UNIQUE,
    cpf INTEGER UNIQUE
);

CREATE TABLE pessoa_unique_sintaxe_alternativa
(
	id INTEGER PRIMARY KEY,
    nome VARCHAR(20),
    cpf INTEGER,
    UNIQUE(nome, cpf) -- coluna que restringe Cpf e Nome SIMULTANEAMENTE
);











