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
