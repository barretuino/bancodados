/*
   Esquema de Criação do Banco de Dados
   Comando DDL create
*/
create database aula;

/*Defir a base de dados em uso*/
use aula;

show tables;

/* Apaga a estrutura da database */
drop database aula;

/* Criação de uma Tabela */
create table aluno(
   ra int,
   nome varchar(50),
   dataNascimento date
);

desc table aluno;