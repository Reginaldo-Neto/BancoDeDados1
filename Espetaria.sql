/*CREATE DATABASE espetaria;		  COMANDO PARA CRIAR O BANCO DE DADOS*/
USE espetaria;						/*COMANDO PARA USAR O BANCO DE DADOS*/

drop table if exists SENTA;		/*DROPANDO RELACIONAMENTOS PARA EXECUTAR VAIRAS VEZES OS TESTES*/
drop table if exists ATENDE;
drop table if exists REALIZA;
drop table if exists ASSA;
drop table if exists GERENCIA_FUN;
drop table if exists GERENCIA_SET;
drop table if exists TRABALHA_EM;
drop table if exists PREPARA;
drop table if exists POSSUI;
drop table if exists VISUALIZA;

drop table if exists PORCOES;		/*DROPANDO TABELAS PARA EXECUTAR VAIRAS VEZES OS TESTES*/

drop table if exists CAIXA;
drop table if exists COZINHA;
drop table if exists CHURRASQUEIRA;
drop table if exists SETORES;

drop table if exists PEDIDOS;
drop table if exists ESPETOS;
drop table if exists GERENTE;

drop table if exists CHURRASQUEIRO;
drop table if exists GARCOM;
drop table if exists FUNCIONARIOS;

drop table if exists CLIENTES;
drop table if exists MESAS;



/* --------------------------------------------- TABELAS ----------------------------------------------*/

CREATE TABLE PORCOES(
	cod INTEGER,
    nome VARCHAR(100),
    valor FLOAT,
    PRIMARY KEY(cod)
);

CREATE TABLE SETORES(
	cod INTEGER,
    nome VARCHAR(100),
    qtd_funcionarios INTEGER,
    PRIMARY KEY(cod)
);

CREATE TABLE CAIXA(
	qtd_mesas_fechadas INT,
    saldo FLOAT,
    cod INTEGER,
    FOREIGN KEY (cod) references SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod)
);

CREATE TABLE COZINHA(
	qtd_porcoes_feitas INTEGER,
    qtd_de_fuincionarios INTEGER,
    cod INTEGER,
    FOREIGN KEY (cod) references SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod)
);

CREATE TABLE CHURRASQUEIRA(
	qtd_carvao_estoque INTEGER,
    qtd_espetos_assados INTEGER,
    cod INTEGER,
    FOREIGN KEY (cod) references SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod)
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

CREATE TABLE FUNCIONARIOS(
	cod INTEGER,
    nome VARCHAR(100),
    salario FLOAT,
    PRIMARY KEY(cod)
);

CREATE TABLE CHURRASQUEIRO(
	qtd_de_espetos INTEGER,
    media_de_tempo FLOAT,
    nota FLOAT,
    cod INTEGER,
    FOREIGN KEY (cod) references FUNCIONARIOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod)
);

CREATE TABLE GARCOM(
	comissao FLOAT,
    nota FLOAT,
    num_mesas_antedidas INTEGER,
    cod INTEGER,
    FOREIGN KEY (cod) references FUNCIONARIOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod)
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
    cod_garcom INTEGER,
    FOREIGN KEY (cpf_cliente) REFERENCES CLIENTES(cpf) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_garcom) REFERENCES GARCOM(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cpf_cliente, cod_garcom)    
);

CREATE TABLE REALIZA(
    cod_pedido INTEGER,
    cod_garcom INTEGER,
    FOREIGN KEY (cod_pedido) REFERENCES PEDIDOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_garcom) REFERENCES GARCOM(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_pedido, cod_garcom)    
);

CREATE TABLE ASSA(
    cod_espeto INTEGER,
    cod_churrasqueiro INTEGER,
    FOREIGN KEY (cod_espeto) REFERENCES ESPETOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_churrasqueiro) REFERENCES CHURRASQUEIRO(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_espeto, cod_churrasqueiro)    
);

CREATE TABLE GERENCIA_FUN(
    cod_gerente INTEGER,
    cod_funcionario INTEGER,
    FOREIGN KEY (cod_gerente) REFERENCES GERENTE(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_gerente, cod_funcionario)    
);

CREATE TABLE GERENCIA_SET(
    cod_gerente INTEGER,
    cod_setor INTEGER,
    FOREIGN KEY (cod_gerente) REFERENCES GERENTE(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_setor) REFERENCES SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_gerente, cod_setor)    
);

CREATE TABLE TRABALHA_EM(
    cod_funcionario INTEGER,
    cod_setor INTEGER,
    FOREIGN KEY (cod_funcionario) REFERENCES FUNCIONARIOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_setor) REFERENCES SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_funcionario, cod_setor)    
);

CREATE TABLE PREPARA(
    cod_porcao INTEGER,
    cod_cozinha INTEGER,
    FOREIGN KEY (cod_porcao) REFERENCES PORCOES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_cozinha) REFERENCES COZINHA(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_porcao, cod_cozinha)    
);

CREATE TABLE POSSUI(
    cod_porcao INTEGER,
    cod_espeto INTEGER,
    cod_pedido INTEGER,
    FOREIGN KEY (cod_porcao) REFERENCES PORCOES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_espeto) REFERENCES ESPETOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_pedido) REFERENCES PEDIDOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_porcao, cod_espeto, cod_pedido)    
);

CREATE TABLE VISUALIZA(
    cod_garcom INTEGER,
    cod_setor INTEGER,
    cod_pedido INTEGER,
    FOREIGN KEY (cod_garcom) REFERENCES GARCOM(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_setor) REFERENCES SETORES(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (cod_pedido) REFERENCES PEDIDOS(cod) ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY (cod_garcom, cod_setor, cod_pedido)    
);

/* ------------------------------------------------------------------------ INSERÇÃO DE DADOS ----------------------------------------------------------*/

INSERT INTO PORCOES (cpf, nome, vaga) VALUES ('12345678900', 'Neto', 1), ('12345678901', 'Greg', 2);
INSERT INTO SETORES (cpf, salario_hora, horas_trabalhadas) VALUES ('12345678900', 5.80, 40);
INSERT INTO CAIXA (cpf, id) VALUES ('12345678900', 1);
