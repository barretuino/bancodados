/**
	Comandos para Primary Key e FK
    Prof. Paulo Barreto
	Aula: 13/11/2023
**/

select * from produtos;

insert into produtos
  (id, descricao, quantidade_embalagem, situacao)
values(3, "Estojo Turma do Balão Mágico", 1, true);

select * from recebimentos;

insert into recebimentos
   (id, id_produto, quantidade_recebida)
values(1, 4, 100),
      (1, 3, 10);

update recebimentos set id_produto = 1
   where id_produto = 4;

alter table recebimentos
   add primary key (id);
   
alter table recebimentos
   add foreign key (id_produto) 
				REFERENCES produtos(id);

-- Tentativa de violação da Integridade / Referencial
delete from recebimentos
   where id_produto = 3;
delete from produtos
   where id = 3;
   
-- Criação da Table nota_fiscal
CREATE TABLE IF NOT EXISTS `curso`.`nota_fiscal` (
  `id_nota` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `data_entrada` DATETIME NULL,
  `data_emissao` DATETIME NULL,
  `status` BOOLEAN,
  PRIMARY KEY (`id_nota`, `id_fornecedor`));

insert into nota_fiscal
	(id_nota, id_fornecedor, data_entrada, 
    data_emissao, status)
values(1, 1, null, null, true),
	  (2, 1, null, null, true),
      (1, 2, '2022-10-01', '2022-10-01', false);

CREATE TABLE IF NOT EXISTS fornecedores(
   id int not null auto_increment,
   razao varchar(40),
   data_cadastro datetime not null,
   primary key (id)
);

select * from fornecedores;

insert into fornecedores  (razao, data_cadastro)
   values ('UNISAL', '1982-01-01'),
          ('Google', '2000-10-05'),
          ('Cantina da Ana', '2005-07-16');

alter table nota_fiscal
	add foreign key (id_fornecedor)
        references fornecedores (id);

select * from nota_fiscal;

select * from recebimentos;




CREATE or REPLACE VIEW vw_recebimento as
	SELECT 
		r.id as id_recebimento,
		p.id as id_produto,
		p.descricao,
		p.quantidade_embalagem,
		r.quantidade_recebida,
		p.quantidade_embalagem * r.quantidade_recebida qtde_unitaria
	FROM
		produtos p,
		recebimentos r
	WHERE
		r.id_produto = p.id;
        
select * from vw_recebimento;

create table if not exists estoques(
  id int not null primary key,
  descricao varchar(100) not null,
  id_produto int not null,
  quantidade numeric(10)
);
	
alter table estoques
   add foreign key (id_produto)
       references produtos(id);

insert into estoques
  (id, descricao, id_produto, quantidade)
values (1, 'Estoque Loja 1', 1, 120);

select * from estoques;

CREATE TRIGGER  tg_atualizar_estoques
 BEFORE INSERT ON recebimentos FOR EACH ROW    
    UPDATE estoques 
    SET quantidade = quantidade + NEW.quantidade_recebida
    WHERE id_produto = NEW.id_produto;   
  
      
insert into recebimentos
  (id, id_produto, quantidade_recebida)
values (7, 1, 20);

CREATE INDEX idx_recebimentos 
    ON recebimentos (id);