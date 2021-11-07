/* BANCO DE DADOS - ESPETARIA
ALUNO: REGINALDO GREGÓRIO DE SOUZA NETO
RA:2252813

LINK DO GIT-HUB: https://github.com/Reginaldo-Neto/BancoDeDados1.git

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
    capacidade_de_funcionarios INTEGER,
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

INSERT INTO PORCOES 
(cod, nome, valor) VALUES 
(0, 'Molho de Alho', 0.50),
(1, 'Arroz', 2.50), 
(2, 'Vinagrete', 2.00), 
(3, 'Repolho', 2.00), 
(4, 'Farofa', 2.00),
(5, 'Mandioca', 0.00),
(6, 'Completo', 6.00);

INSERT INTO CLIENTES 
(cpf, nome, qtd_visitas) VALUES 
(01234567890 , 'Aline', 1),
(01234567891 , 'Bruno', 1),
(01234567892 , 'Ana', 2),
(01234567893, 'Clara', 2),
(01234567894, 'José', 3),
(01234567895, 'João', 1),
(01234567896, 'Celso', 4),
(01234567897, 'Sasha', 3),
(01234567898, 'Felipe', 5),
(01234567899, 'Cecília', 2),
(09876543211, 'Geraldo', 1),
(09876543212, 'Márcia', 3),
(09876543213, 'Luís', 5),
(09876543214, 'Catarina', 4);

INSERT INTO FUNCIONARIOS 
(salario, nome, cod) VALUES 
(1100.00, 'Jair', 10),
(1100.00, 'Claudia', 11),
(1100.00, 'Lucas', 12),
(1100.00, 'Marcio', 13),
(1100.00, 'Mateus', 14),
(1100.00, 'Luzia', 15),
(1100.00, 'Carla', 16),
(1100.00, 'Laura', 17);

INSERT INTO MESAS
(num, valor, qtd_pessoas) VALUES
(1, 100.50, 2),
(3, 200.50, 3),
(5, 300, 4),
(7, 50, 1),
(9, 90.00, 1),
(11, 78.50, 2);

INSERT INTO GARCOM
(cod, comissao, nota, num_mesas_antedidas) VALUES
(10, 100, 5, 50),
(11, 100, 4, 50),
(12, 100, 3, 50);

INSERT INTO CHURRASQUEIRO
(cod, nota, media_de_tempo, qtd_de_espetos) VALUES
(13, 5, 10, 500);

INSERT INTO GERENTE
(cod, nome, comissao) VALUES
(100, 'Reginaldo', 3000);

INSERT INTO GERENCIA_FUN
(cod_gerente, cod_funcionario) VALUES
(100, 10),
(100, 11),
(100, 12),
(100, 13),
(100, 14),
(100, 15),
(100, 16),
(100, 17);

INSERT INTO SETORES
(cod, nome, qtd_funcionarios) VALUES
(1, 'Churrasqueira', 1),
(2, 'Cozinha', 3),
(3, 'Caixa', 1);

INSERT INTO GERENCIA_SET
(cod_gerente, cod_setor) VALUES
(100, 1),
(100, 2),
(100, 3);

INSERT INTO CAIXA
(qtd_mesas_fechadas, saldo, cod) VALUES
(250, 10000.00, 3);

INSERT INTO COZINHA
(qtd_porcoes_feitas, capacidade_de_funcionarios, cod) VALUES
(650, 4, 2);

INSERT INTO CHURRASQUEIRA
(cod, qtd_carvao_estoque, qtd_espetos_assados) VALUES
(1, 250, 3000);

INSERT INTO ESPETOS
(cod, nome, qtd_em_estoque) VALUES
(1, 'Alcatra', 300),
(2, 'Picanha', 50),
(3, 'Maminha', 200),
(4, 'Medalhão de Frango', 200),
(5, 'Medalhão de Alcatra', 200),
(6, 'Coração', 200),
(7, 'Asa', 200),
(8, 'Coxa', 200),
(9, 'Pernil', 200),
(10, 'Linguiça', 200);

INSERT INTO PEDIDOS
(cod, valor, mesa) VALUES
(1, 100.50, 1),
(2, 200.50, 3),
(3, 300, 5);

INSERT INTO SENTA
(entrada, saida, cpf_cliente, num_mesa) VALUES
(19, 20, 01234567890, 1),
(19, 21, 01234567891, 3),
(20, 22, 01234567892, 5);

INSERT INTO ATENDE
(cpf_cliente, cod_garcom) VALUES
(01234567890, 10),
(01234567891, 11),
(01234567892, 12);

INSERT INTO REALIZA
(cod_pedido, cod_garcom) VALUES
(1, 10),
(2, 11),
(3, 12);