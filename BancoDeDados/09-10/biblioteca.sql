Create Schema Biblioteca;
use Biblioteca;

create table biblioteca.livro (    
  ISBN varchar(30) not null,    
  Titulo varchar(256) not null,    
  DataPublicacao date,    
  EstanteID integer);
  
create table biblioteca.estante (
ID integer not null auto_increment,
Localizacao varchar(64) not null,
primary key (ID));

alter table biblioteca.livro 
	add foreign key (EstanteID) 
	references biblioteca.estante (ID);
	
alter table biblioteca.livro 
	add primary key (ISBN);
        
# - a) inserindo as estantes
insert into biblioteca.estante
	values
    (default, 'C10E01'),
	(default, 'C10E02');

# - b) inserindo os livros nas estantes
insert into biblioteca.livro values
	('1234','O pagador de promessas','2008-10-10',1),
    ('1235','Game of Thrones 1','2018-10-10',2),
    ('1236','Breaking Bad','2004-10-10',2),
    ('1237','O Tecido do Cosmo','2003-10-10',1),
    ('1238','Particulas','2010-12-10',2);

# - checando os livros
select * from biblioteca.livro; 
# - c) arrumando a data
update biblioteca.livro set DataPublicacao = '2012-10-10' where ISBN = '1235';
# - checando novamente
select * from biblioteca.livro;

#Adicionando uma nova estante
insert into biblioteca.estante
	values
    (default, 'C10E03');
    
#Movendo livros para a nova estante
update biblioteca.livro set EstanteId = 3 where ISBN = '1235';
update biblioteca.livro set EstanteId = 3 where ISBN = '1236';

#checando se deu tudo certo
select * from biblioteca.livro