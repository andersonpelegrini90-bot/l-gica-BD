USE ecommerce_dio;

-- INSERTS de exemplo
INSERT INTO cliente (id_cliente, nome, email, tipo_cliente) VALUES
(1, 'Ana Silva', 'ana@email.com', 'PF'),
(2, 'Loja ABC', 'contato@abc.com', 'PJ');

INSERT INTO cliente_pf (id_cliente, cpf) VALUES
(1, '123.456.789-00');

INSERT INTO cliente_pj (id_cliente, cnpj) VALUES
(2, '12.345.678/0001-99');

INSERT INTO produto (id_produto, nome, preco) VALUES
(1, 'Mouse', 50.00),
(2, 'Teclado', 120.00);

INSERT INTO fornecedor (id_fornecedor, nome) VALUES
(1, 'Fornecedor X'),
(2, 'Fornecedor Y');

INSERT INTO produto_fornecedor (id_produto, id_fornecedor) VALUES
(1, 1),
(1, 2),
(2, 1);

INSERT INTO estoque (id_estoque, id_produto, quantidade, localizacao) VALUES
(1, 1, 100, 'CD São Paulo'),
(2, 2, 50, 'CD São Paulo');

INSERT INTO pedido (id_pedido, id_cliente, data_pedido, valor_total) VALUES
(1, 1, '2026-02-01', 170.00),
(2, 2, '2026-02-02', 1200.00);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 50.00),
(1, 2, 1, 120.00),
(2, 2, 10, 120.00);

INSERT INTO forma_pagamento (id_forma, descricao) VALUES
(1, 'Cartão de Crédito'),
(2, 'Boleto'),
(3, 'Pix');

INSERT INTO pedido_pagamento (id_pedido, id_forma) VALUES
(1, 1),
(1, 3),
(2, 2);

INSERT INTO entrega (id_entrega, id_pedido, status, codigo_rastreio, data_envio, data_entrega) VALUES
(1, 1, 'Enviado', 'R123456BR', '2026-02-02', NULL),
(2, 2, 'Entregue', 'R654321BR', '2026-02-03', '2026-02-05');

----------------------------------------------------------------
-- QUERIES DO DESAFIO
----------------------------------------------------------------

-- 1) Recuperações simples com SELECT
SELECT id_cliente, nome, email FROM cliente;

-- 2) Filtros com WHERE
SELECT nome, preco
FROM produto
WHERE preco > 100.00;

-- 3) Expressão para atributo derivado (preço com 10% de desconto)
SELECT 
    nome,
    preco,
    preco * 0.9 AS preco_com_desconto
FROM produto;

-- 4) ORDER BY (ordenar produtos por preço desc)
SELECT nome, preco
FROM produto
ORDER BY preco DESC;

-- 5) Quantos pedidos foram feitos por cada cliente? (GROUP BY + HAVING)
SELECT 
    c.nome,
    COUNT(p.id_pedido) AS qtde_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING COUNT(p.id_pedido) > 0;

-- 6) Relação de produtos, fornecedores e estoques (JOINs)
SELECT 
    p.nome        AS produto,
    f.nome        AS fornecedor,
    e.quantidade  AS qtd_estoque,
    e.localizacao
FROM produto p
JOIN produto_fornecedor pf ON p.id_produto = pf.id_produto
JOIN fornecedor f         ON pf.id_fornecedor = f.id_fornecedor
LEFT JOIN estoque e       ON p.id_produto = e.id_produto;

-- 7) Relação de nomes de fornecedores e nomes dos produtos
SELECT 
    f.nome AS fornecedor,
    p.nome AS produto
FROM fornecedor f
JOIN produto_fornecedor pf ON f.id_fornecedor = pf.id_fornecedor
JOIN produto p             ON pf.id_produto = p.id_produto
ORDER BY f.nome, p.nome;
