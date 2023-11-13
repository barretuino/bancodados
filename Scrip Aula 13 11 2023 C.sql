/**
	AULA 13/11/2023
    Junções de Tabelas e Funções de Agregação
    Prof. Paulo Barreto
**/
use curso;

select * from recebimentos r;
select distinct(r.id_produto) from recebimentos r;

insert into recebimentos (id, id_produto, quantidade_recebida)
values (7, 2, 100);

-- Aplicar um operação aritmética
CREATE VIEW vi_recebimento_projecao as
SELECT 
    r.id_produto AS produto,
    r.quantidade_recebida AS qtde_original,
    (r.quantidade_recebida * 1.10) AS qtde_prospectada
FROM
    recebimentos r;
    
select 
   r.qtde_original + r.qtde_prospectada
from vi_recebimento_projecao r;

-- Problema da junção do produto cartesiano
SELECT  *
FROM
    nota_fiscal n,
    fornecedores f
WHERE n.id_fornecedor = f.id;

select * from produtos p
where p.id in (1, 2)
and p.descricao like 'L%';

select substr(descricao, 1, 3) 
from produtos;

CREATE TABLE IF NOT EXISTS `curso`.`nota_fiscal_saida` (
  `id_nota` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `data_entrada` DATETIME NULL,
  `data_emissao` DATETIME NULL,
  `status` BOOLEAN,
  PRIMARY KEY (`id_nota`, `id_fornecedor`));
  
insert into nota_fiscal_saida
	(id_nota, id_fornecedor, data_entrada, 
    data_emissao, status)
values(4, 1, '2022-11-08', '2022-11-09', true),
	  (6, 1, '2022-11-07', '2022-11-10', true),
      (7, 1, '2022-10-01', '2022-10-01', false),
      (1, 2, '2022-11-07', '2022-11-10', true),
      (2, 2, '2022-11-07', '2022-11-10', true);

select * from nota_fiscal
  union
select * from nota_fiscal_saida;

select id_nota from nota_fiscal
intesect
select id_nota from nota_fiscal_saida;

select * from recebimentos r
order by r.id desc

-- Funções nativas de agregação
SELECT 
    SUM(r.quantidade_recebida) as total,
    avg(r.quantidade_recebida) as média,
    min(r.quantidade_recebida) as menor,
    max(r.quantidade_recebida) as maior,
    count(r.quantidade_recebida) as contagem
FROM
    recebimentos r;
    
select 
   f.id_nota nota,
   ifnull(data_entrada, 'NAO informada') entrada,   
from nota_fiscal f;

SELECT 
    r.id AS recebimento,
    r.id_produto AS produto,
    IF(r.quantidade_recebida < 0,
        0,
        r.quantidade_recebida) as qtde_recebida
FROM
    recebimentos r;
    
select 
	id_fornecedor as fornecedor,
    count(*) as n_recebimentos
   from nota_fiscal
group by id_fornecedor;

select sum(r.qtde_original) as original,
       sum(r.qtde_prospectada) as futura,
       r.produto
from vi_recebimento_projecao r
having sum(r.qtde_prospectada) > 80;

-- select com subselect
SELECT 
    *
FROM
    produtos p
WHERE
    p.id IN 
       (SELECT distinct (r.id_produto) FROM recebimentos r);

-- Funções
CREATE FUNCTION exibir_texto (s CHAR(20))
     RETURNS CHAR(50) DETERMINISTIC
RETURN CONCAT('seja Bem Vindo, seu texto é ',s,'!');
    
select exibir_texto('Veja isso');

-- Procedure
delimiter //
drop procedure aplicar_reajuste;
CREATE PROCEDURE aplicar_reajuste
 (IN percentual numeric, 
  OUT novo_valor numeric)
       BEGIN
         SELECT  r.qtde_original * percentual
         INTO novo_valor FROM 
             vi_recebimento_projecao r
		where r.produto = 2;
       END; 
//
call aplicar_reajuste(7, @novo_valor);
select @novo_valor;