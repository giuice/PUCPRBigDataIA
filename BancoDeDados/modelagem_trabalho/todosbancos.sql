-- MySQL Workbench Synchronization
-- Generated: 2018-09-03 23:03
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: giuice

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `ChurracoDB` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Convidado` (
  `cpf` CHAR(11) NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Bebida` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` TEXT NOT NULL,
  `preco` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Carne` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Churrasco` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `local` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Usuario` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`Convidado_has_Churrasco` (
  `Convidado_cpf` CHAR(11) NOT NULL,
  `Churrasco_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Convidado_cpf`, `Churrasco_id`),
  INDEX `fk_Convidado_has_Churrasco_Churrasco1_idx` (`Churrasco_id` ASC),
  INDEX `fk_Convidado_has_Churrasco_Convidado_idx` (`Convidado_cpf` ASC),
  CONSTRAINT `fk_Convidado_has_Churrasco_Convidado`
    FOREIGN KEY (`Convidado_cpf`)
    REFERENCES `ChurracoDB`.`Convidado` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Convidado_has_Churrasco_Churrasco1`
    FOREIGN KEY (`Churrasco_id`)
    REFERENCES `ChurracoDB`.`Churrasco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`CardapioCarne` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `Carne_id` INT(10) UNSIGNED NOT NULL,
  `Churrasco_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `Carne_id`, `Churrasco_id`),
  INDEX `fk_CardapioCarne_Carne1_idx` (`Carne_id` ASC),
  INDEX `fk_CardapioCarne_Churrasco1_idx` (`Churrasco_id` ASC),
  CONSTRAINT `fk_CardapioCarne_Carne1`
    FOREIGN KEY (`Carne_id`)
    REFERENCES `ChurracoDB`.`Carne` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CardapioCarne_Churrasco1`
    FOREIGN KEY (`Churrasco_id`)
    REFERENCES `ChurracoDB`.`Churrasco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ChurracoDB`.`CardapioBebida` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Churrasco_id` INT(10) UNSIGNED NOT NULL,
  `Bebida_id` INT(11) NOT NULL,
  `quantidade` INT(10) UNSIGNED NOT NULL,
  INDEX `fk_Churrasco_has_Bebida_Bebida1_idx` (`Bebida_id` ASC),
  INDEX `fk_Churrasco_has_Bebida_Churrasco1_idx` (`Churrasco_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Churrasco_has_Bebida_Churrasco1`
    FOREIGN KEY (`Churrasco_id`)
    REFERENCES `ChurracoDB`.`Churrasco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Churrasco_has_Bebida_Bebida1`
    FOREIGN KEY (`Bebida_id`)
    REFERENCES `ChurracoDB`.`Bebida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- MySQL Workbench Synchronization
-- Generated: 2018-09-03 23:19
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: giuice

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `AutoLocadoraDb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Veiculo` (
  `placa` CHAR(7) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `outros` VARCHAR(45) NULL DEFAULT NULL,
  `id_modelo` INT(10) UNSIGNED NOT NULL,
  `id_cor` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`placa`),
  INDEX `fk_Veiculo_Modelo1_idx` (`id_modelo` ASC),
  INDEX `fk_Veiculo_Cor1_idx` (`id_cor` ASC),
  CONSTRAINT `fk_Veiculo_Modelo1`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `AutoLocadoraDb`.`Modelo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Cor1`
    FOREIGN KEY (`id_cor`)
    REFERENCES `AutoLocadoraDb`.`Cor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Revisao` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `valor` DECIMAL(15,2) UNSIGNED NOT NULL,
  `placa` CHAR(7) NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Revisao_Veiculo1_idx` (`placa` ASC),
  CONSTRAINT `fk_Revisao_Veiculo1`
    FOREIGN KEY (`placa`)
    REFERENCES `AutoLocadoraDb`.`Veiculo` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Marca` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Modelo` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `id_marca` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC),
  INDEX `fk_Modelo_Marca_idx` (`id_marca` ASC),
  CONSTRAINT `fk_Modelo_Marca`
    FOREIGN KEY (`id_marca`)
    REFERENCES `AutoLocadoraDb`.`Marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Cor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Contrato` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `preco_diaria` DECIMAL(15,2) UNSIGNED NOT NULL,
  `valor_seguro` DECIMAL(15,2) UNSIGNED NOT NULL,
  `placa` CHAR(7) NOT NULL,
  `Cliente_CPF` CHAR(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Contrato_Veiculo1_idx` (`placa` ASC),
  INDEX `fk_Contrato_Cliente1_idx` (`Cliente_CPF` ASC),
  CONSTRAINT `fk_Contrato_Veiculo1`
    FOREIGN KEY (`placa`)
    REFERENCES `AutoLocadoraDb`.`Veiculo` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contrato_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `AutoLocadoraDb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Cliente` (
  `CPF` CHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `AutoLocadoraDb`.`Fornecedor` (
  `CNPJ` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(400) NULL DEFAULT NULL,
  `outros` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- MySQL Workbench Synchronization
-- Generated: 2018-09-03 23:26
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: giuice

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `BibliotecaDb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Publicacao` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `isbn` VARCHAR(45) NULL DEFAULT NULL,
  `titulo` VARCHAR(250) NOT NULL,
  `id_genero` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Publicacao_Genero_idx` (`id_genero` ASC),
  CONSTRAINT `fk_Publicacao_Genero`
    FOREIGN KEY (`id_genero`)
    REFERENCES `BibliotecaDb`.`Genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Exemplar` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_publicacao` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Exemplar_Publicacao1_idx` (`id_publicacao` ASC),
  CONSTRAINT `fk_Exemplar_Publicacao1`
    FOREIGN KEY (`id_publicacao`)
    REFERENCES `BibliotecaDb`.`Publicacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Genero` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Prateleira` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `localizacao` VARCHAR(45) NOT NULL,
  `id_genero` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `localizacao_UNIQUE` (`localizacao` ASC),
  INDEX `fk_Prateleira_Genero1_idx` (`id_genero` ASC),
  CONSTRAINT `fk_Prateleira_Genero1`
    FOREIGN KEY (`id_genero`)
    REFERENCES `BibliotecaDb`.`Genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Colaborador` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `id_unidade` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  INDEX `fk_Colaborador_Unidade1_idx` (`id_unidade` ASC),
  CONSTRAINT `fk_Colaborador_Unidade1`
    FOREIGN KEY (`id_unidade`)
    REFERENCES `BibliotecaDb`.`Unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Unidade` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Assunto` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Autor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Emprestimo` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_colaborador` INT(10) UNSIGNED NOT NULL,
  `id_exemplar` INT(10) UNSIGNED NOT NULL,
  `data_emprestimo` DATE NOT NULL,
  `data_limite` DATE NOT NULL,
  `data_devolucao` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Emprestimo_Colaborador1_idx` (`id_colaborador` ASC),
  INDEX `fk_Emprestimo_Exemplar1_idx` (`id_exemplar` ASC),
  CONSTRAINT `fk_Emprestimo_Colaborador1`
    FOREIGN KEY (`id_colaborador`)
    REFERENCES `BibliotecaDb`.`Colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Emprestimo_Exemplar1`
    FOREIGN KEY (`id_exemplar`)
    REFERENCES `BibliotecaDb`.`Exemplar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`publicacao_assunto` (
  `id_assunto` INT(10) UNSIGNED NOT NULL,
  `id_publicacao` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_assunto`, `id_publicacao`),
  INDEX `fk_publicacao_assunto_Publicacao1_idx` (`id_publicacao` ASC),
  CONSTRAINT `fk_publicacao_assunto_Publicacao1`
    FOREIGN KEY (`id_publicacao`)
    REFERENCES `BibliotecaDb`.`Publicacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacao_assunto_Assunto1`
    FOREIGN KEY (`id_assunto`)
    REFERENCES `BibliotecaDb`.`Assunto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`publicacao_autor` (
  `id_autor` INT(10) UNSIGNED NOT NULL,
  `id_publicacao` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_autor`, `id_publicacao`),
  INDEX `fk_publicacao_autor_Publicacao1_idx` (`id_publicacao` ASC),
  CONSTRAINT `fk_publicacao_autor_Autor1`
    FOREIGN KEY (`id_autor`)
    REFERENCES `BibliotecaDb`.`Autor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacao_autor_Publicacao1`
    FOREIGN KEY (`id_publicacao`)
    REFERENCES `BibliotecaDb`.`Publicacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BibliotecaDb`.`Reserva` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_colaborador` INT(10) UNSIGNED NOT NULL,
  `id_publicacao` INT(10) UNSIGNED NOT NULL,
  `data_reserva` TIMESTAMP NULL DEFAULT NULL,
  `ativa` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Reserva_Colaborador1_idx` (`id_colaborador` ASC),
  INDEX `fk_Reserva_Publicacao1_idx` (`id_publicacao` ASC),
  CONSTRAINT `fk_Reserva_Colaborador1`
    FOREIGN KEY (`id_colaborador`)
    REFERENCES `BibliotecaDb`.`Colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Publicacao1`
    FOREIGN KEY (`id_publicacao`)
    REFERENCES `BibliotecaDb`.`Publicacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- MySQL Workbench Synchronization
-- Generated: 2018-09-03 23:35
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: giuice

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `cirurgiadb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Especialidade` (
  `idEspecialidade` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEspecialidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Medico` (
  `CRM` INT(10) UNSIGNED NOT NULL,
  `idEspecialidade` INT(10) UNSIGNED NOT NULL,
  `Nome` VARCHAR(200) NULL DEFAULT NULL,
  `Endereco` VARCHAR(250) NULL DEFAULT NULL,
  `Bairro` VARCHAR(200) NULL DEFAULT NULL,
  `UF` VARCHAR(2) NULL DEFAULT NULL,
  `Cidade` VARCHAR(200) NULL DEFAULT NULL,
  `Salario` DECIMAL(15,2) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`CRM`, `idEspecialidade`),
  INDEX `fk_Medico_Especialidade1_idx` (`idEspecialidade` ASC),
  CONSTRAINT `fk_Medico_Especialidade1`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `cirurgiadb`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Paciente` (
  `IdInternacao` INT(10) UNSIGNED NOT NULL,
  `Nome` VARCHAR(200) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(400) NULL DEFAULT NULL,
  `Sexo` VARCHAR(1) NULL DEFAULT NULL,
  `Nascimento` DATE NULL DEFAULT NULL,
  `Profissao` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`IdInternacao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Sala` (
  `idSala` INT(10) UNSIGNED NOT NULL,
  `Andar` VARCHAR(45) NULL DEFAULT NULL,
  `AlaDoCentro` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idSala`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Sala_Especialidade` (
  `idSala` INT(10) UNSIGNED NOT NULL,
  `idEspecialidade` INT(10) UNSIGNED NOT NULL,
  `DataInicio` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idSala`, `idEspecialidade`),
  INDEX `fk_Sala_Especialidade_Especialidade1_idx` (`idEspecialidade` ASC),
  CONSTRAINT `fk_Sala_Especialidade_Sala1`
    FOREIGN KEY (`idSala`)
    REFERENCES `cirurgiadb`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sala_Especialidade_Especialidade1`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `cirurgiadb`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Cirurgia` (
  `idInternacao` INT(10) UNSIGNED NOT NULL,
  `idEspecialidade` INT(10) UNSIGNED NOT NULL,
  `CRM` INT(10) UNSIGNED NOT NULL,
  `idSala` INT(10) UNSIGNED NOT NULL,
  `DataCirurgia` DATE NOT NULL,
  `HoraCirurgia` TIME NOT NULL,
  PRIMARY KEY (`idInternacao`, `idEspecialidade`, `CRM`, `idSala`, `HoraCirurgia`, `DataCirurgia`),
  INDEX `fk_Cirurgia_Especialidade1_idx` (`idEspecialidade` ASC),
  INDEX `fk_Cirurgia_Medico1_idx` (`CRM` ASC),
  INDEX `fk_Cirurgia_Sala1_idx` (`idSala` ASC),
  CONSTRAINT `fk_Cirurgia_Paciente1`
    FOREIGN KEY (`idInternacao`)
    REFERENCES `cirurgiadb`.`Paciente` (`IdInternacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cirurgia_Especialidade1`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `cirurgiadb`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cirurgia_Medico1`
    FOREIGN KEY (`CRM`)
    REFERENCES `cirurgiadb`.`Medico` (`CRM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cirurgia_Sala1`
    FOREIGN KEY (`idSala`)
    REFERENCES `cirurgiadb`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Consumo` (
  `Quantidade` TINYINT(4) NULL DEFAULT NULL,
  `Cirurgia_idInternacao` INT(10) UNSIGNED NOT NULL,
  `Cirurgia_idEspecialidade` INT(10) UNSIGNED NOT NULL,
  `Cirurgia_CRM` INT(10) UNSIGNED NOT NULL,
  `Cirurgia_idSala` INT(10) UNSIGNED NOT NULL,
  `Cirurgia_HoraCirurgia` TIME NOT NULL,
  `Cirurgia_DataCirurgia` DATE NOT NULL,
  `Produto_idProduto` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Cirurgia_idInternacao`, `Cirurgia_idEspecialidade`, `Cirurgia_CRM`, `Cirurgia_idSala`, `Cirurgia_HoraCirurgia`, `Cirurgia_DataCirurgia`, `Produto_idProduto`),
  INDEX `fk_Consumo_Cirurgia1_idx` (`Cirurgia_idInternacao` ASC, `Cirurgia_idEspecialidade` ASC, `Cirurgia_CRM` ASC, `Cirurgia_idSala` ASC, `Cirurgia_HoraCirurgia` ASC, `Cirurgia_DataCirurgia` ASC),
  INDEX `fk_Consumo_Produto1_idx` (`Produto_idProduto` ASC),
  CONSTRAINT `fk_Consumo_Cirurgia1`
    FOREIGN KEY (`Cirurgia_idInternacao` , `Cirurgia_idEspecialidade` , `Cirurgia_CRM` , `Cirurgia_idSala` , `Cirurgia_HoraCirurgia` , `Cirurgia_DataCirurgia`)
    REFERENCES `cirurgiadb`.`Cirurgia` (`idInternacao` , `idEspecialidade` , `CRM` , `idSala` , `HoraCirurgia` , `DataCirurgia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumo_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `cirurgiadb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cirurgiadb`.`Produto` (
  `idProduto` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PrincipioAtivo` VARCHAR(45) NULL DEFAULT NULL,
  `Descricao` VARCHAR(45) NULL DEFAULT NULL,
  `Unidade` BIT(1) NULL DEFAULT NULL,
  `Estoque` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- MySQL Workbench Synchronization
-- Generated: 2018-09-03 23:38
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: giuice

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `EstoqueDB` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Produto` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `valor` DECIMAL NOT NULL,
  `id_classe` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC),
  INDEX `fk_Produto_Classe1_idx` (`id_classe` ASC),
  CONSTRAINT `fk_Produto_Classe1`
    FOREIGN KEY (`id_classe`)
    REFERENCES `EstoqueDB`.`Classe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Cliente` (
  `CPF` CHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NULL DEFAULT NULL,
  `numero` VARCHAR(45) NULL DEFAULT NULL,
  `complemento` VARCHAR(45) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `CEP` INT(11) NULL DEFAULT NULL,
  `id_cidade` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Cliente_Cidade_idx` (`id_cidade` ASC),
  CONSTRAINT `fk_Cliente_Cidade`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `EstoqueDB`.`Cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Cidade` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Venda` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `valor` DECIMAL NOT NULL,
  `id_cliente` CHAR(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Venda_Cliente1_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `EstoqueDB`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Classe` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Parcela` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venda` INT(10) UNSIGNED NOT NULL,
  `data_vencimento` DATE NOT NULL,
  `valor` DECIMAL NOT NULL,
  `data_pagamento` DATE NULL DEFAULT NULL,
  `Parcelacol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `id_venda`),
  INDEX `fk_Parcela_Venda1_idx` (`id_venda` ASC),
  CONSTRAINT `fk_Parcela_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `EstoqueDB`.`Venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `EstoqueDB`.`Produto_Venda` (
  `id_produto` INT(10) UNSIGNED NOT NULL,
  `id_venda` INT(10) UNSIGNED NOT NULL,
  `quantidade` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_produto`, `id_venda`),
  INDEX `fk_Produto_Venda_Venda1_idx` (`id_venda` ASC),
  CONSTRAINT `fk_Produto_Venda_Produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `EstoqueDB`.`Produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Venda_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `EstoqueDB`.`Venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
