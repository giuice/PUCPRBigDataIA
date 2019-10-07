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
