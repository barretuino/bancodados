/**
   Aula 09/10/2023
   Comandos DDL
**/
/*Construcao da database*/
create database aula;

/*Apagar a database*/
drop database aula;

/*Criar a tabela de dado*/
create table produto(
   codigo int,
   descricao text,
   quantidade_minima double,
   quantidade_maxima double,
   status boolean
);

/**Exibir detalhes de Banco**/
show tables;
show databases;

ALTER TABLE produto 
CHANGE COLUMN codigo codigo INT NOT NULL ,
ADD PRIMARY KEY (codigo);
;

create table estoque(
   produto int,
   empresa int,
   saldo double
);

ALTER TABLE estoque
CHANGE COLUMN produto produto INT NOT NULL ,
CHANGE COLUMN empresa empresa INT NOT NULL ,
ADD PRIMARY KEY (`produto`, `empresa`);
;

ALTER TABLE `aula`.`estoque` 
ADD CONSTRAINT `fk_produto`
  FOREIGN KEY (`produto`)
  REFERENCES `aula`.`produto` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
/** Comandos DML **/
insert into produto (codigo, descricao,
quantidade_minima, quantidade_maxima, status)
values (1, 'Lapis de Cor', 10, 100, true);

insert into produto (codigo, descricao,
quantidade_minima, quantidade_maxima, status)
values (2, 'Borracha', 5, 25, false);

select * from produto;

insert into estoque (produto, empresa, saldo)
value (1, 1, 12);

select * from estoque;

delete from estoque where produto = 1
and empresa = 1;

delete from produto where codigo = 1;

/**Comandos de remoção DML, removem o conteúdo**/
delete from produto;
truncate produto;

/** Comando DDL, apaga a estrutura**/
drop table estoque;
drop table produto;
drop database aula;

