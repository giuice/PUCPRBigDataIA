create schema TrabalhoDML;
use Trabalhodml
#criando table caixa
create table trabalhodml.Caixa(
	codcaixa integer not null auto_increment,
    saldo decimal(10,2),
    primary key (CodCaixa));

create table trabalhodml.Vendedor(
	codvend integer not null auto_increment,
    nome varchar(200),
    primary key (codvend)
);
create table trabalhodml.Venda(
	numeronf integer not null auto_increment,
    datavenda date not null,
    codcaixa integer not null,
    codvend integer not null,
    primary key (numeronf),
    foreign key (codcaixa) 
	references trabalhodml.Caixa(codcaixa),
    foreign key (codvend) 
	references trabalhodml.Vendedor(codvend)
	
);

create table trabalhodml.Categoria(
	codcategoria integer not null auto_increment,
    nome varchar(200) not null,
    primary key(codcategoria)
);
create table trabalhodml.Produto(
	codproduto integer not null auto_increment,
    descricao varchar(200) not null,
    preco decimal(10,2) not null,
    codcategoria integer not null,
    primary key(codproduto),
    foreign key(codcategoria)
    references trabalhodml.categoria(codcategoria)
);

create table trabalhodml.Similar(
	codprod1 integer not null,
    codprod2 integer not null,
    primary key(codprod1,codprod2),
    foreign key(codprod1)
    references trabalhodml.Produto(codproduto),
    foreign key(codprod2)
    references trabalhodml.Produto(codproduto)
);	

create table trabalhodml.ItemVenda(
	numeronf integer not null,
    codproduto integer not null,
    quantidade integer not null,
    precovenda decimal(10,2),
    primary key(numeronf, codproduto),
    foreign key(numeronf)
    references trabalhodml.Venda(numeronf),
    foreign key(codproduto)
    references trabalhodml.Produto(codproduto)
);

insert into trabalhodml.Vendedor values
(default, 'Giuliano Lemes'),
(default, 'Patricia Martinelli'),
(default, 'Marco Antonio');

insert into trabalhodml.Caixa values(default, 1000);

insert into trabalhodml.categoria values 
(default, 'Beleza'),
(default, 'Nutricao'),
(default, 'Antienvelhecimento'),
(default, 'Maquiagem'),
(default, 'Fitness');

insert into trabalhodml.produto values 
(default, 'Naara tangerina',120.00, 1),
(default, 'Naara chocolate',130.00, 1),
(default, 'Zen Prime',51.00, 5),
(default, 'Zen Fuze', 220, 5),
(default, 'Spa Shampoo', 230, 1),
(default, 'Spa Tonico', 230, 1),
(default, 'Spa Mascara', 200, 1),
(default, 'Nevo Energético', 7, 2),
(default, 'Luminesce Serum', 580, 3),
(default, 'Luminesce Night', 350, 1);

#verificando produtos
select * from produto;

#inserindo produtos similares
insert into trabalhodml.Similar values
(1,2),
(9,10);

select * from caixa;
#
insert into trabalhodml.Venda values
(default,'20181009', 1, 1),
(default,'20181009', 1, 2),
(default,'20181009', 1, 3);

insert into trabalhodml.itemvenda values 
(1, 9, 3, (select preco from trabalhodml.Produto where codproduto = 9)),
(2, 10, 4, (select preco from trabalhodml.Produto where codproduto = 10)),
(3, 1, 2, (select preco from trabalhodml.Produto where codproduto = 1));

#checando
select * from itemvenda;

#atualizando o preço dos 3 produtos vendidos
update Produto set preco = 125 where codproduto =  1;
update Produto set preco = 590 where codproduto =  9;
update Produto set preco = 360 where codproduto =  10;

#checando produtos
select * from produto;

#4. Faça 2 novas vendas, que contenham os produtos atualizados
insert into trabalhodml.Venda values
(default,'20181009', 1, 1),
(default,'20181009', 1, 3);

insert into trabalhodml.itemvenda values 
(4, 9, 1, (select preco from trabalhodml.Produto where codproduto = 9)),
(5, 10, 2, (select preco from trabalhodml.Produto where codproduto = 10));

#Liste os produtos mais vendidos
select p.descricao, sum(quantidade) from itemvenda iv 
inner join produto p 
On iv.codproduto = p.codproduto
group by p.descricao
order by sum(quantidade) desc;

#Liste o preço médio de venda dos produtos
select p.descricao, avg(precovenda) from itemvenda iv 
inner join produto p 
On iv.codproduto = p.codproduto
group by p.descricao
order by sum(quantidade) desc;

#Liste os produtos sem vendas
select descricao from produto p
where not exists
(select 1 from itemvenda iv where iv.codproduto = p.codproduto);

#Responda quais são as categorias de produtos que precisam de melhor divulgação. (Categorias sem venda)
select distinct c.nome, c.codcategoria  from categoria c
left join produto p 
on c.codcategoria = p.codcategoria
where c.codcategoria not in(select p.codcategoria from itemvenda iv
inner join produto p 
on p.codproduto = iv.codproduto
group by p.codcategoria);

