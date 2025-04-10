# Sistema de E-commerce

Este sistema foi desenvolvido para gerenciar um e-commerce, permitindo o controle de clientes, produtos, pedidos e pagamentos. O objetivo é proporcionar uma plataforma funcional para a venda de produtos, com integração de informações sobre estoque, pedidos e pagamentos.

## Descrição do Projeto

O sistema de e-commerce possui as seguintes funcionalidades:
- **Gestão de Produtos**: Cadastro de produtos com categorias, preços e descrição.
- **Gestão de Clientes**: Cadastro de clientes com informações como CPF, nome e endereço.
- **Pedidos**: Controle de pedidos realizados pelos clientes, com status, data e valores.
- **Pagamentos**: Registro de informações sobre os pagamentos realizados pelos clientes, com suporte a diferentes formas de pagamento (cartão, boleto, pix).
- **Estoque**: Controle da quantidade de produtos disponíveis em estoque.

## Entidades

1. **Cliente**: Representa os clientes que compram produtos no e-commerce.
2. **Produto**: Representa os produtos vendidos na loja.
3. **Pedido**: Representa os pedidos realizados pelos clientes.
4. **Pagamento**: Representa as informações de pagamento para os pedidos.
5. **Estoque**: Controle das quantidades de produtos disponíveis.
6. **Fornecedor**: Representa os fornecedores dos produtos.
7. **Vendedor**: Representa os vendedores que cadastram os produtos e atendem os clientes.
8. **Relação Produto-Estoque**: Relacionamento entre os produtos e os estoques disponíveis.
9. **Relação Produto-Pedido**: Relacionamento entre os produtos e os pedidos realizados.

## Relacionamentos

- Um **cliente** pode realizar vários **pedidos**.
- Um **pedido** pode conter vários **produtos**.
- Um **produto** pode ter várias **peças** relacionadas no estoque.
- Cada **pedido** é associado a um **pagamento**.
- O **produto** está vinculado a um **fornecedor** e pode ser vendido por um **vendedor**.

## Diagrama

O diagrama de entidade-relacionamento (EER) foi elaborado para ilustrar as relações entre as entidades do banco de dados, como clientes, produtos, pedidos, fornecedores, etc.

**Clique aqui para visualizar o diagrama**: 
![Diagrama ER]https://github.com/LudmilaRamos/projeto_ecommerce_dio/blob/main/ecommerce.png 

## Como Rodar o Banco de Dados

1. Clone o repositório e acesse o diretório do projeto:

   ```bash
   git clone https://github.com/LudmilaRamos/ecommerce-db.dio.git
   cd ecommerce-db.dio


## Importe o arquivo SQL para o seu servidor MySQL:
mysql -u seu_usuario -p seu_banco_de_dados < BD-ecommerce.sql

