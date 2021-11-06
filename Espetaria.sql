/*CREATE DATABASE espetaria;		  COMANDO PARA CRIAR O BANCO DE DADOS*/
USE espetaria;						/*COMANDO PARA USAR O BANCO DE DADOS*/

drop table if exists SENTA;		/*DROPANDO RELACIONAMENTOS PARA EXECUTAR VAIRAS VEZES OS TESTES*/
drop table if exists ATENDE;

drop table if exists PORCOES;		/*DROPANDO TABELAS PARA EXECUTAR VAIRAS VEZES OS TESTES*/

drop table if exists CAIXA;
drop table if exists COZINHA;
drop table if exists CHURRASQUEIRA;
drop table if exists PEDIDOS;

drop table if exists ESPETOS;
drop table if exists SETORES;
drop table if exists GERENTE;
drop table if exists FUNCIONARIOS;

drop table if exists CHURRASQUEIRO;
drop table if exists GARCOM;
drop table if exists CLIENTES;
drop table if exists MESAS;



/* --------------------------------------------- TABELAS ----------------------------------------------*/

CREATE TABLE PORCOES(
	cod INTEGER,
    nome VARCHAR(100),
    PRIMARY KEY(cod)
);

CREATE TABLE CAIXA(
	qtd_mesas_fechadas INT,
    saldo FLOAT
);

CREATE TABLE COZINHA(
	qtd_porcoes_feitas INTEGER,
    qtd_de_fuincionarios INTEGER
);

CREATE TABLE CHURRASQUEIRA(
	qtd_carvao_estoque INTEGER,
    qtd_espetos_assados INTEGER
);

CREATE TABLE SETORES(
	cod INTEGER,
    nome VARCHAR(100),
    qtd_funcionarios INTEGER,
    PRIMARY KEY(cod)
);

CREATE TABLE GERENTE(
	cod INTEGER,
    nome VARCHAR(100),
    comissao FLOAT,
    PRIMARY KEY(cod)
);

CREATE TABLE ESPETOS(
	cod INTEGER,
    nome VARCHAR(100),
    qtd_em_estoque INTEGER,
    PRIMARY KEY(cod)
);

CREATE TABLE PEDIDOS(
	cod INTEGER,
    valor FLOAT,
    mesa INTEGER,
    PRIMARY KEY(cod)
);

CREATE TABLE CHURRASQUEIRO(
	qtd_de_espetos INTEGER,
    media_de_tempo FLOAT,
    nota FLOAT
);

CREATE TABLE GARCOM(
	comissao FLOAT,
    nota FLOAT,
    num_mesas_antedidas INTEGER
);

CREATE TABLE FUNCIONARIOS(
	cod INTEGER,
    nome VARCHAR(100),
    salario FLOAT,
    PRIMARY KEY(cod)
);

CREATE TABLE CLIENTES(
	cpf CHAR(11),
    nome VARCHAR(100),
    qtd_visitas INTEGER,
    PRIMARY KEY (cpf)
);

CREATE TABLE MESAS(
	num INTEGER,
    valor FLOAT,
    qtd_pessoas INTEGER,
    PRIMARY KEY(num)
);

/* ---------------------------------------------- RELACIONAMENTO ------------------------------------------------------------------ */

CREATE TABLE SENTA(
	entrada TIME,
    saida TIME,
    cpf_cliente CHAR(11),
    num_mesa INTEGER,
    FOREIGN KEY (cpf_cliente) REFERENCES CLIENTES(cpf) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (num_mesa) REFERENCES MESAS(num) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cpf_cliente, num_mesa)    
);

CREATE TABLE ATENDE(
    cpf_cliente CHAR(11),
    cod_garom INTEGER,
    FOREIGN KEY (cpf_cliente) REFERENCES CLIENTES(cpf) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_garcom) REFERENCES GARCOM(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cpf_cliente, cod)    
);