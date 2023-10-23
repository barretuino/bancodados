/** Comandos DML - Comandos de Modelagem
	Aula 16/10/2023
	Prof. Ms. Paulo Barreto **/

use aula;

show tables;

/*Comando de inserção de dados
insert into <table> (colunas) values ( );*/
insert into produto (codigo,
descricao, quantidade_minima, 
quantidade_maxima)
values(4,'Caderno Espiral', 10, 200);

/* Comando de consulta de dados
select <colunas> from <table>
 <junção>
 <predicado>
 <sumarização>
 <ordenação>*/

select descricao, codigo, 
quantidade_minima 'mínimo'
from produto
order by quantidade_minima, descricao;

create table cliente(
  codigo int not null,
  nome text,
  documento int);

alter table cliente 
add column tipo char default 'c';

create table fornecedor(
  codigo int not null,
  razao_social text,
  cnpj int);
  
alter table fornecedor 
add column tipo char default 'f';
  
insert into cliente(codigo, nome, documento)
values(1, 'Luiz', 5432189);
insert into cliente(codigo, nome, documento)
values(2, 'Priscila', 9876543);
insert into cliente(codigo, nome, documento)
values(3, 'João', 567890);
insert into cliente(codigo, nome, documento)
values(4, 'Maria Heloisa', 8529637);

insert into fornecedor(codigo, razao_social, cnpj)
values(1, 'UNISAL - Centro Salesiano', 12345);
insert into fornecedor(codigo, razao_social, cnpj)
values(2, 'Latam', 65412);
insert into fornecedor(codigo, razao_social, cnpj)
values(3, 'Restaurante Bom de Garfo', 45671);

select * from cliente;

create view vw_participante as
(
	select 	c.codigo 	'id',
			c.nome 		'descricao',
			c.documento 'documento',
			c.tipo		'tipo'
	from cliente c
	union
	select 	f.codigo 		'id',
			f.razao_social  'descricao',
			f.cnpj			'documento',
			f.tipo			'tipo'
	from fornecedor f);

select * from vw_participante;

/** Agregar valores**/
select e.produto, p.descricao, sum(e.saldo) 
from estoque e, produto p
where e.produto = p.codigo
group by e.produto, p.descricao;

select * from produto p
where p.codigo not in 
	(select e.produto from estoque e);
    
insert into estoque (produto, empresa, saldo)
value (4, 1, 100);

select e.produto, e.saldo from estoque e;

/** Atualização de Valores **/
update estoque set saldo = saldo * 1.10
where produto = 2 and empresa = 1;

/** Remoção de dados **/
delete from estoque e
where e.produto = 4;

delete from produto p 
where p.codigo = 4;

truncate produto;

select * from estoque
