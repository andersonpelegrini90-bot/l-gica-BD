-- Cria o banco e seleciona
CREATE DATABASE IF NOT EXISTS ecommerce_dio;
USE ecommerce_dio;

-- CLIENTE (dados comuns)
CREATE TABLE cliente (
    id_cliente      INT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100),
    tipo_cliente    ENUM('PF','PJ') NOT NULL   -- garante PF ou PJ
);

-- CLIENTE_PF (pessoa física)
CREATE TABLE cliente_pf (
    id_cliente  INT PRIMARY KEY,
    cpf         VARCHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_cliente_pf_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- CLIENTE_PJ (pessoa jurídica)
CREATE TABLE cliente_pj (
    id_cliente  INT PRIMARY KEY,
    cnpj        VARCHAR(18) NOT NULL UNIQUE,
    CONSTRAINT fk_cliente_pj_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- PRODUTO
CREATE TABLE produto (
    id_produto  INT PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    preco       DECIMAL(10,2) NOT NULL
);

-- FORNECEDOR
CREATE TABLE fornecedor (
    id_fornecedor    INT PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL
);

-- Relação PRODUTO x FORNECEDOR (N:N)
CREATE TABLE produto_fornecedor (
    id_produto    INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- ESTOQUE
CREATE TABLE estoque (
    id_estoque   INT PRIMARY KEY,
    id_produto   INT NOT NULL,
    quantidade   INT NOT NULL,
    localizacao  VARCHAR(100),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- PEDIDO
CREATE TABLE pedido (
    id_pedido    INT PRIMARY KEY,
    id_cliente   INT NOT NULL,
    data_pedido  DATE NOT NULL,
    valor_total  DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ITENS DO PEDIDO
CREATE TABLE item_pedido (
    id_pedido       INT,
    id_produto      INT,
    quantidade      INT NOT NULL,
    preco_unitario  DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- FORMA DE PAGAMENTO
CREATE TABLE forma_pagamento (
    id_forma   INT PRIMARY KEY,
    descricao  VARCHAR(50) NOT NULL
);

-- Relação PEDIDO x FORMA_PAGAMENTO (N:N)
CREATE TABLE pedido_pagamento (
    id_pedido  INT,
    id_forma   INT,
    PRIMARY KEY (id_pedido, id_forma),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_forma)  REFERENCES forma_pagamento(id_forma)
);

-- ENTREGA (status + código de rastreio)
CREATE TABLE entrega (
    id_entrega       INT PRIMARY KEY,
    id_pedido        INT NOT NULL,
    status           VARCHAR(30) NOT NULL,
    codigo_rastreio  VARCHAR(50),
    data_envio       DATE,
    data_entrega     DATE,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
