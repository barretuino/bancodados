/** Criar a estrutura de tabelas da
aula de hoje **/
CREATE TABLE Ambulatorios (
			nroa		     	integer,
			andar		     	numeric(3) NOT NULL,
			capacidade      	smallint,    
			PRIMARY KEY(nroa) 	
);

CREATE TABLE Medicos (
		codm		      	integer,
		nome		      	varchar(40) NOT NULL,
		idade            	smallint    NOT NULL,
		especialidade    	char(20), 
		CPF              	numeric(11) UNIQUE, 
		cidade           	varchar(30),  
		nroa             	integer,
   PRIMARY KEY(codm)
);

ALTER TABLE `aula`.`medicos` 
ADD INDEX `nro_idx` (`nroa` ASC) VISIBLE;
;
ALTER TABLE `aula`.`medicos` 
ADD CONSTRAINT `nro`
  FOREIGN KEY (`nroa`)
  REFERENCES `aula`.`ambulatorios` (`nroa`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


/** Comandos DML **/
insert into ambulatorios (nroa, andar, capacidade)
values(1, 1, 25), (2, 1, 25);
      
insert into medicos(codm, nome, idade, especialidade, 
		CPF, cidade, nroa) 
values(1, 'Luis Sales', 34, 'Cardiologista', 
27867899800, 'Americana-SP', 1);

select * from medicos;

update medicos set cidade = 'Florianopolis-SC'
where  cidade = 'Americana-SP';

delete from medicos
where (especialidade = 'Cardiologia' or
cidade = 'Florianopolis-SC')
and codm = 1; 

select e.saldo 			saldo_atual, 
	   e.saldo * 1.10 	saldo_projetado
 from estoque e;
 
 alter table produto
 add column preco numeric;
 
 update produto set preco = 10
 where codigo = 1;
 
 /** Seleção de multi origem com filtragem de dados**/
 select e.produto, 
		e.saldo, 
		p.preco * e.saldo 'valor'
 from estoque e, produto p
 where p.codigo = e.produto;
 
 
 select nroa, count(andar) from ambulatorios
 group by nroa;
 
 select * from produto
 where codigo in (1, 3, 5);