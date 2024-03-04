USE master
GO
DROP DATABASE palestra

CREATE DATABASE palestra
GO
USE palestra
GO
CREATE TABLE curso
(
	cod_curso	INT NOT NULL,
	nome		VARCHAR(70) NOT NULL,
	sigla		VARCHAR(10) NOT NULL
	PRIMARY KEY (cod_curso)
)
GO
CREATE TABLE aluno
(
	ra			CHAR(7) NOT NULL,
	nome 		VARCHAR(250) NOT NULL,
	cod_curso	INT NOT NULL
	PRIMARY KEY (ra)
	FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso)
)
GO
CREATE TABLE nao_alunos
(
	rg			VARCHAR(9) NOT NULL,
	orgao_exp	CHAR(5) NOT NULL,
	nome		VARCHAR(250) NOT NULL
	PRIMARY KEY (rg, orgao_exp)
)
GO
CREATE TABLE palestrante
(
	cod_palestrante INT IDENTITY(1, 1) NOT NULL,
	nome			VARCHAR(250) NOT NULL,
	empresa			VARCHAR(100) NOT NULL
	PRIMARY KEY (cod_palestrante)
)
GO
CREATE TABLE palestra
(
	cod_palestra	INT IDENTITY(1, 1) NOT NULL,
	titulo 			VARCHAR(MAX) NOT NULL,
	carga_horaria	INT NULL,
	data_palestra	DATETIME	NOT NULL,
	cod_palestrante INT NOT NULL
	PRIMARY KEY (cod_palestra)
	FOREIGN KEY (cod_palestrante) REFERENCES palestrante (cod_palestrante)
)
GO
CREATE TABLE nao_alunos_inscritos
(
	cod_palestra	INT NOT NULL,
	rg				VARCHAR(9) NOT NULL,
	orgao_exp		CHAR(5)	NOT NULL
	PRIMARY KEY (cod_palestra, rg, orgao_exp)
	FOREIGN KEY (cod_palestra) REFERENCES palestra (cod_palestra),
	FOREIGN KEY (rg, orgao_exp) REFERENCES nao_alunos (rg, orgao_exp)
)
GO
CREATE TABLE alunos_inscritos
(
	ra				CHAR(7) NOT NULL,
	cod_palestra	INT NOT NULL
	PRIMARY KEY (ra, cod_palestra)
	FOREIGN KEY (ra) REFERENCES aluno (ra),
	FOREIGN KEY (cod_palestra) REFERENCES palestra (cod_palestra)
)

INSERT INTO curso (cod_curso, nome, sigla) 
VALUES 
(1, 'Engenharia Elétrica', 'EE'),
(2, 'Ciência da Computação', 'CC'),
(3, 'Administração', 'ADM')

INSERT INTO aluno (ra, nome, cod_curso) 
VALUES 
('1234567', 'João Silva', 1),
('2345678', 'Maria Souza', 2),
('3456789', 'Pedro Santos', 1)

INSERT INTO nao_alunos (rg, orgao_exp, nome) 
VALUES 
('123456789', 'SSP', 'José Oliveira'),
('234567890', 'SSP', 'Ana Pereira')

INSERT INTO palestrante (nome, empresa) 
VALUES 
('Carlos Oliveira', 'Tech Solutions'),
('Ana Santos', 'Data Analysis Co.')

INSERT INTO palestra (titulo, carga_horaria, data_palestra, cod_palestrante) 
VALUES 
('Introdução à Inteligência Artificial', 2, '2024-03-15 10:00:00', 1),
('Gestão de Projetos Ágeis', 1, '2024-03-20 14:00:00', 2)

INSERT INTO nao_alunos_inscritos (cod_palestra, rg, orgao_exp) 
VALUES 
(1, '123456789', 'SSP'),
(2, '234567890', 'SSP')

INSERT INTO alunos_inscritos (ra, cod_palestra) 
VALUES 
('1234567', 1),
('2345678', 2)

--O problema está no momento de gerar a lista de presença. A lista de presença deverá vir de uma 
--consulta que retorna (Num_Documento, Nome_Pessoa, Titulo_Palestra, Nome_Palestrante, 
--Carga_Horária e Data).
--A lista deverá ser uma só, por palestra (A condição da consulta é o código 
--da palestra) e contemplar alunos e não alunos (O Num_Documento se referencia ao RA para 
--alunos e RG + Orgao_Exp para não alunos) e estar ordenada pelo Nome_Pessoa.

--Fazer uma view de select que fornaça a saída conforme se pede.

CREATE VIEW palestra_agenda
AS
SELECT 
CONCAT(na.rg, ' ', na.orgao_exp) AS num_documento,
na.nome AS nome,
p.titulo AS titulo_palestra,
p2.nome AS nome_palestrante,
p.carga_horaria AS carga_horaria,
p.data_palestra AS data_palestra,
'Aluno' AS tipo
FROM nao_alunos na, nao_alunos_inscritos nai, palestra p, palestrante p2  
WHERE (nai.rg = na.rg AND nai.orgao_exp = na.orgao_exp) 
	AND nai.cod_palestra = p.cod_palestra
	AND p.cod_palestrante  = p2.cod_palestrante
UNION
SELECT 
a.ra AS num_documento,
a.nome AS nome,
p.titulo AS titulo_palestra,
p2.nome AS nome_palestrante,
p.carga_horaria AS carga_horaria,
p.data_palestra AS data_palestra,
'Não Aluno' AS tipo
FROM aluno a, alunos_inscritos ai, palestra p, palestrante p2
WHERE a.ra = ai.ra
	AND ai.cod_palestra = p.cod_palestra
	AND p.cod_palestrante  = p2.cod_palestrante

SELECT * FROM palestra_agenda
ORDER BY tipo ASC


