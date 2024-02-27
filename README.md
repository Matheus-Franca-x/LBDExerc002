# LBDExerc002

EXERCÍCIO UNION – LABORATÓRIO DE BANCO DE DADOS FATEC ZL
Prof. M.Sc. Leandro Colevati dos Santos
Considere o MER abaixo do domínio de palestras em uma Faculdade. Palestrantes apresentarão 
palestras para alunos e não alunos. Para o caso de alunos, seus dados já são referenciáveis em 
outro sistema, portanto, basta saber seu RA, no entanto, para não alunos, para prover 
certificados, é importante saber seu RG e Órgão Expedidor. 
O problema está no momento de gerar a lista de presença. A lista de presença deverá vir de uma 
consulta que retorna (Num_Documento, Nome_Pessoa, Titulo_Palestra, Nome_Palestrante, 
Carga_Horária e Data). A lista deverá ser uma só, por palestra (A condição da consulta é o código 
da palestra) e contemplar alunos e não alunos (O Num_Documento se referencia ao RA para 
alunos e RG + Orgao_Exp para não alunos) e estar ordenada pelo Nome_Pessoa.
Fazer uma view de select que fornaça a saída conforme se pede

<h1 align="center">Banco de dados</h1>

![image](https://github.com/Matheus-Franca-x/LBDExerc002/assets/99504777/43d3e9e3-dc1d-4f3b-942d-95d7e38a0ef6)

