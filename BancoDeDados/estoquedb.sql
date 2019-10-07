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
