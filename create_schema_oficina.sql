-- Cria o banco e seleciona
CREATE DATABASE IF NOT EXISTS oficina_dio;
USE oficina_dio;

-- CLIENTE
CREATE TABLE cliente (
    id_cliente   INT PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    telefone     VARCHAR(20),
    email        VARCHAR(100),
    cpf_cnpj     VARCHAR(20)  -- pode ser PF ou PJ
);

-- VEICULO
CREATE TABLE veiculo (
    id_veiculo   INT PRIMARY KEY,
    id_cliente   INT NOT NULL,
    placa        VARCHAR(10) NOT NULL UNIQUE,
    modelo       VARCHAR(50) NOT NULL,
    ano          INT,
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- MECANICO
CREATE TABLE mecanico (
    id_mecanico  INT PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

-- SERVICO (catálogo de serviços da oficina)
CREATE TABLE servico (
    id_servico   INT PRIMARY KEY,
    descricao    VARCHAR(100) NOT NULL,
    valor_base   DECIMAL(10,2) NOT NULL
);

-- PECA (catálogo de peças)
CREATE TABLE peca (
    id_peca      INT PRIMARY KEY,
    descricao    VARCHAR(100) NOT NULL,
    preco        DECIMAL(10,2) NOT NULL
);

-- ORDEM DE SERVICO (OS)
CREATE TABLE ordem_servico (
    id_os        INT PRIMARY KEY,
    id_veiculo   INT NOT NULL,
    id_mecanico  INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    status       VARCHAR(20) NOT NULL, -- Aberta, Em andamento, Fechada
    valor_total  DECIMAL(10,2),
    CONSTRAINT fk_os_veiculo
        FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    CONSTRAINT fk_os_mecanico
        FOREIGN KEY (id_mecanico) REFERENCES mecanico(id_mecanico)
);

-- Itens de SERVICO executados em uma OS (N:N entre OS e SERVICO)
CREATE TABLE os_servico (
    id_os        INT,
    id_servico   INT,
    quantidade   INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os)      REFERENCES ordem_servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);

-- PEÇAS utilizadas em uma OS (N:N entre OS e PECA)
CREATE TABLE os_peca (
    id_os        INT,
    id_peca      INT,
    quantidade   INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os)   REFERENCES ordem_servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES peca(id_peca)
);
