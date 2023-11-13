/**
    Comandos de DML - Modelagem de Dados
    Prof. Paulo Barreto
    Data 13/11/2023
**/
-- Definir a tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL,
    descricao VARCHAR(40),
    quantidade_embalagem NUMERIC,
    situacao BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS recebimentos(
    id int not null,
    id_produto int not null,
    quantidade_recebida numeric
);
insert into recebimentos
   (id, id_produto, quantidade_recebida)
values  (1, 1, 5), 
		(2, 2, 7), 
		(3, 1, 8), 
		(4, 2, 6);

select * from recebimentos;

-- Consulta que retorne informações de duas
-- ou mais tabelas
SELECT 
    r.id,
    p.id,
    p.descricao,
    p.quantidade_embalagem,
    r.quantidade_recebida,
    p.quantidade_embalagem * r.quantidade_recebida qtde_unitaria
FROM
    produtos p,
    recebimentos r
WHERE
    r.id_produto = p.id;

-- Apagar a tabela
DROP TABLE produto;

-- CRUD - Create, Read, Update e Delete
-- Inserção de Dados (Create)
insert into produtos
  (id, descricao, quantidade_embalagem, situacao)
values(1, "Lápis", 12, true),
      (2, "Caderno", 1, false);

-- Leitura ou de Seleção de Dados (Read)
select * from produtos;

-- Atualização de Dados (Update)
UPDATE produtos 
SET 
    quantidade_embalagem = 1
WHERE
    quantidade_embalagem IS NULL;

-- Remoção de Dados (Delete)
DELETE FROM produtos 
WHERE
    descricao = 'Caderno';
    
-- Remoção massiva dos dados de uma table
truncate produtos;