# Projeto Lógico de Banco de Dados - E-commerce (DIO)

Este repositório faz parte do lab **"Construindo seu Primeiro Projeto Lógico de Banco de Dados"** da DIO.  
Aqui eu desenvolvo um modelo lógico de banco de dados para um cenário de e-commerce, com criação do esquema em SQL e algumas consultas de exemplo.

## Cenário do projeto

O objetivo é modelar um banco de dados para uma loja virtual (e-commerce), pensando em como os dados seriam organizados para atender o dia a dia do negócio: cadastro de clientes, pedidos, produtos, fornecedores, estoque, formas de pagamento e entregas.

O foco é praticar modelagem lógica e criação de tabelas no banco de dados, incluindo chaves primárias, chaves estrangeiras e relacionamentos entre as tabelas, como visto no curso da DIO.

## Refinamentos aplicados (regras de negócio)

Durante o desafio, foram aplicados alguns refinamentos importantes no modelo:

- **Cliente PF e PJ**  
  - Uma conta de cliente pode ser **Pessoa Física (PF)** ou **Pessoa Jurídica (PJ)**, mas não as duas ao mesmo tempo.  
  - Para isso, foi criada uma tabela `cliente` com os dados comuns (nome, email, tipo_cliente) e duas tabelas específicas:
    - `cliente_pf`: guarda o CPF vinculado ao cliente.  
    - `cliente_pj`: guarda o CNPJ vinculado ao cliente.

- **Pagamento (mais de uma forma por pedido)**  
  - Um mesmo pedido pode ser pago usando **mais de uma forma de pagamento** (ex.: parte no cartão, parte no Pix).  
  - Foram criadas:
    - `forma_pagamento`: cadastro das formas de pagamento (cartão, boleto, pix etc.).  
    - `pedido_pagamento`: tabela de relacionamento entre pedido e forma de pagamento (muitos-para-muitos).

- **Entrega (status + código de rastreio)**  
  - Cada pedido possui informações de entrega, incluindo **status** (Enviado, Entregue, etc.) e **código de rastreio**.  
  - Para isso, foi criada a tabela `entrega`, ligada ao `pedido`.

## Modelo lógico (tabelas do esquema)

Abaixo, um resumo das principais tabelas do esquema lógico:

- `cliente`  
  - `id_cliente` (PK)  
  - `nome`  
  - `email`  
  - `tipo_cliente` (PF ou PJ)

- `cliente_pf`  
  - `id_cliente` (PK / FK para `cliente`)  
  - `cpf`

- `cliente_pj`  
  - `id_cliente` (PK / FK para `cliente`)  
  - `cnpj`

- `produto`  
  - `id_produto` (PK)  
  - `nome`  
  - `preco`

- `fornecedor`  
  - `id_fornecedor` (PK)  
  - `nome`

- `produto_fornecedor` (relacionamento muitos-para-muitos)  
  - `id_produto` (FK para `produto`)  
  - `id_fornecedor` (FK para `fornecedor`)

- `estoque`  
  - `id_estoque` (PK)  
  - `id_produto` (FK)  
  - `quantidade`  
  - `localizacao`

- `pedido`  
  - `id_pedido` (PK)  
  - `id_cliente` (FK)  
  - `data_pedido`  
  - `valor_total`

- `item_pedido`  
  - `id_pedido` (FK)  
  - `id_produto` (FK)  
  - `quantidade`  
  - `preco_unitario`

- `forma_pagamento`  
  - `id_forma` (PK)  
  - `descricao`

- `pedido_pagamento`  
  - `id_pedido` (FK)  
  - `id_forma` (FK)

- `entrega`  
  - `id_entrega` (PK)  
  - `id_pedido` (FK)  
  - `status`  
  - `codigo_rastreio`  
  - `data_envio`  
  - `data_entrega`

## Scripts incluídos neste repositório

- `create_schema.sql`  
  Script com a criação do banco de dados `ecommerce_dio` e de todas as tabelas (estrutura do projeto lógico).

- `data_and_queries.sql`  
  Script com:
  - Inserção de alguns dados de exemplo (clientes, produtos, pedidos etc.).  
  - Consultas SQL para testar o modelo e praticar SELECT, filtros e JOINs.

## Exemplos de perguntas respondidas pelas consultas

Algumas das perguntas de negócio que podem ser respondidas com as queries deste projeto são:

- **Quantos pedidos foram feitos por cada cliente?**  
  Usando `GROUP BY` para contar pedidos por cliente.

- **Qual a relação de produtos, fornecedores e estoques?**  
  Usando `JOIN` entre `produto`, `produto_fornecedor`, `fornecedor` e `estoque`.

- **Qual a relação de nomes dos fornecedores e nomes dos produtos?**  
  Mostrando quais produtos cada fornecedor fornece.

Além disso, as queries também demonstram:

- Recuperação simples de dados com `SELECT`.  
- Filtros com `WHERE`.  
- Criação de atributos derivados com expressões (por exemplo, preço com desconto).  
- Ordenação com `ORDER BY`.  
- Agrupamento e filtros em grupos com `GROUP BY` e `HAVING`.  
- Junções entre várias tabelas para obter visões mais completas do e-commerce.

---

Este projeto faz parte da minha jornada de aprendizado em banco de dados e SQL, e foi desenvolvido seguindo as orientações do lab da DIO para praticar modelagem lógica e implementação em SQL.
