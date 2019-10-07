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
