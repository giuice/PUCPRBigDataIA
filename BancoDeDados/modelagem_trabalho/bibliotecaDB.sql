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
