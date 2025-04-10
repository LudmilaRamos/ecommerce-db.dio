-- Criação do Banco de Dados para o cenário do E-commerce
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela cliente (PF ou PJ)
CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(20),
    Minit CHAR(3),
    Lname VARCHAR(20) NOT NULL,
    CPF CHAR(11) NOT NULL,  -- CPF é obrigatório para PF
    CNPJ CHAR(14),         -- CNPJ é obrigatório para PJ
    tipoCliente ENUM('PF', 'PJ') NOT NULL,  -- Determina se é PF ou PJ
    Address VARCHAR(30),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
    CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ),
    CHECK ((tipoCliente = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR 
           (tipoCliente = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL))  -- Restrição de que não pode ter ambos
);

-- Tabela produto
CREATE TABLE produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(100),  -- Nome do produto
    classification_kids BOOLEAN,  -- Se é produto infantil
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis'),  -- Categoria do produto
    avaliacao FLOAT,  -- Avaliação do produto
    size VARCHAR(10)  -- Tamanho do produto
);

-- Tabela pagamentos
CREATE TABLE pagamentos (
    idCliente INT,
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    tipoPagamento ENUM('Boleto', 'Pix', 'Cartão', 'Dois cartões'),
    valor FLOAT,
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

-- Tabela pedido
CREATE TABLE pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedidoCliente INT,
    pedidoStatus ENUM('Cancelado', 'Confirmado', 'Em processamento'),
    pedidoDescricao VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idPedidoCliente) REFERENCES cliente(idCliente)
);

-- Tabela produtoEstoque
CREATE TABLE produtoEstoque (
    idProdEstoque INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),  -- Localização do produto
    quantidade INT DEFAULT 0       -- Quantidade no estoque
);

-- Tabela fornecedor
CREATE TABLE fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_social VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    CONSTRAINT unique_fornecedor UNIQUE (CNPJ)
);

-- Tabela vendedor
CREATE TABLE vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    nomeSocial VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),  -- Nome alternativo
    CNPJ CHAR(14),  -- Para PJ
    CPF CHAR(11),   -- Para PF
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_CNPJ_vendedor UNIQUE(CNPJ),
    CONSTRAINT unique_cpf_vendedor UNIQUE(CPF)
);

-- Tabela produtos_por_vendedor
CREATE TABLE produtos_por_vendedor (
    idPvendedor INT,
    idProduto INT, 
    produtoQuantidade INT DEFAULT 1,
    PRIMARY KEY(idPvendedor, idProduto),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idPvendedor) REFERENCES vendedor(idVendedor),
    CONSTRAINT fk_produto_vendedor_prod FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

-- Inserção de dados fictícios para cliente
INSERT INTO cliente (Fname, Minit, Lname, CPF, CNPJ, tipoCliente, Address) VALUES
('João', 'A', 'Silva', '12345678901', NULL, 'PF', 'Rua 1'),
('Maria', 'B', 'Souza', '23456789012', NULL, 'PF', 'Rua 2'),
('Carlos', 'C', 'Pereira', '34567890123', NULL, 'PF', 'Rua 3'),
('Ana', 'D', 'Mendes', '45678901234', NULL, 'PF', 'Rua 4'),
('Luiza', 'E', 'Oliveira', '56789012345', NULL, 'PF', 'Rua 5');

-- Inserção de dados fictícios para produto
INSERT INTO produto (Pname, classification_kids, category, avaliacao, size) VALUES
('Smartphone', FALSE, 'Eletrônico', 4.5, 'Médio'),
('Camiseta', FALSE, 'Vestimenta', 4.0, 'M'),
('Boneca', TRUE, 'Brinquedos', 4.8, 'Pequeno'),
('Biscoito', FALSE, 'Alimentos', 3.9, 'Pequeno'),
('Sofá', FALSE, 'Moveis', 4.6, 'Grande');

-- Inserção de dados fictícios para fornecedor
INSERT INTO fornecedor (nome_social, CNPJ, contact) VALUES
('Fornecedor A', '12345678000100', '11999999999'),
('Fornecedor B', '23456789000111', '11888888888'),
('Fornecedor C', '34567890000122', '11777777777'),
('Fornecedor D', '45678901000133', '11666666666'),
('Fornecedor E', '56789012000144', '11555555555');

-- Inserção de dados fictícios para vendedor
INSERT INTO vendedor (nomeSocial, AbstName, CNPJ, CPF, location, contact) VALUES
('Loja X', 'X Store', '12345678000100', NULL, 'SP', '11999999999'),
('Loja Y', 'Y Store', NULL, '12345678901', 'RJ', '11888888888'),
('Loja Z', 'Z Market', '34567890000122', NULL, 'MG', '11777777777'),
('Loja W', 'W Store', NULL, '23456789012', 'BA', '11666666666'),
('Loja K', 'K Shop', '56789012000144', NULL, 'PR', '11555555555');

-- Inserção de dados fictícios para pagamentos


INSERT INTO pagamentos (idCliente, tipoPagamento, valor) VALUES
(1, 'Pix', 199.99),
(2, 'Boleto', 89.50),
(3, 'Cartão', 1200.00),
(4, 'Dois cartões', 499.90),
(5, 'Pix', 59.99);

--  algumas consultas sql 

-- consultar pedidos feitos ( coloquei na forma de texto)
-- SELECT idPedidoCliente, COUNT(*) AS total_pedidos
-- FROM pedido
-- GROUP BY idPedidoCliente;

-- Algum vendedor também é fornecedor?

-- SELECT v.idVendedor, v.nomeSocial, f.idFornecedor, f.nome_social
-- FROM vendedor v
-- JOIN fornecedor f ON v.CNPJ = f.CNPJ;


-- Relação produto, fornecedor, estoque

-- SELECT p.idProduto, p.Pname, f.idFornecedor, f.nome_social, pe.storageLocation, pe.quantidade
-- FROM produto p
-- JOIN produtos_por_vendedor pv ON p.idProduto = pv.idProduto
-- JOIN fornecedor f ON pv.idPvendedor = f.idFornecedor
-- JOIN produtoEstoque pe ON p.idProduto = pe.idProdEstoque;



-- Consulta para mostrar todos os pedidos confirmados, ordenados por valor de envio
SELECT idPedido, idPedidoCliente, pedidoStatus, pedidoDescricao, sendValue
FROM pedido
WHERE pedidoStatus = 'Confirmado'
ORDER BY sendValue DESC;

-- Consulta para listar os produtos vendidos mais de 3 vezes
SELECT p.Pname, COUNT(pd.idPedido) AS qtd_vendas
FROM produto p
JOIN pedido pd ON p.idProduto = pd.idPedido
GROUP BY p.Pname
HAVING COUNT(pd.idPedido) > 3;

-- Consulta para calcular o total de vendas de cada produto, somando os valores de envio
SELECT p.Pname, SUM(pd.sendValue) AS total_vendas
FROM produto p
JOIN pedido pd ON p.idProduto = pd.idPedido
GROUP BY p.Pname;

