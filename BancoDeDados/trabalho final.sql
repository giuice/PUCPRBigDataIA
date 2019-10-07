create schema CondominioDB;
use CondominioDB;

create table Residencia(
	codResidencia integer not null auto_increment,
    descricao varchar(200),
    primary key (codResidencia));
    
create table Usuario(
	codUsuario integer not null auto_increment,
    nome varchar(250) not null,
    isAdmin boolean default false not null,
    primary key(codUsuario)    
);
create table Morador(
	codUsuario integer not null,
    codResidencia integer not null,
    nome varchar(250),
    isOwner bool default false,
    dataEntrada datetime default CURRENT_TIMESTAMP not null,
    dataSaida datetime null,
    primary key(codUsuario,codResidencia),
    foreign key (codResidencia) 
	references Residencia(codResidencia),
    foreign key(codUsuario)
    references Usuario(codUsuario));
    
create table Mural(
	codMural integer not null auto_increment,
    codUsuario integer not null,
    mensagem varchar(5000) not null,
    datamsg datetime default CURRENT_TIMESTAMP not null,
    primary key (codMural),
    foreign key (codUsuario)
    references Morador(codUsuario));
    
create table SalaoFesta(
	codSalao integer not null auto_increment,
    descricao varchar(500),
    primary key (codSalao));

create table ReservaSalao(
	dataReserva date not null,
    codResidencia integer not null,
    primary key(dataReserva, codResidencia),
    foreign key (codResidencia)
    references Residencia(codResidencia));

create table Enquete(
	codEnquete integer not null auto_increment,
    title varchar(200),
    description varchar(500),
    primary key(codEnquete)
    );
    
create table Vote(
	codEnquete integer not null,
    codUsuario integer not null,
    answer boolean not null,
    primary key(codEnquete, codUsuario),
    foreign key(codEnquete)
    references Enquete(codEnquete),
    foreign key(codUsuario)
    references Morador(codUsuario)
);

#DML PARA INSERÇÃO DE USUÁRIOS
    

    
    