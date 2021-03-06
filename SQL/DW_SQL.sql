-- MySQL Script generated by MySQL Workbench
-- Sat Feb 29 11:39:41 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DW_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DW_DB` ;

-- -----------------------------------------------------
-- Schema DW_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DW_DB` DEFAULT CHARACTER SET utf8 ;
USE `DW_DB` ;

-- -----------------------------------------------------
-- Table `DW_DB`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `dataNascimento` DATETIME NOT NULL,
  `CPF` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Projeto` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Projeto` (
  `idProjeto` INT NOT NULL,
  `dataCriacao` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProjeto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`ONG`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`ONG` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`ONG` (
  `idONG` INT NOT NULL,
  `dataCriacao` DATETIME NOT NULL,
  `nomeFantasia` VARCHAR(45) NOT NULL,
  `CNPJ` INT NOT NULL,
  PRIMARY KEY (`idONG`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Publicacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Publicacao` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Publicacao` (
  `idPublicacao` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  `dataPublic` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `URLConteudo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPublicacao`),
  INDEX `fk_Publicacao_Projeto1_idx` (`Projeto_idProjeto` ASC) VISIBLE,
  CONSTRAINT `fk_Publicacao_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `DW_DB`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Comentario` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Comentario` (
  `idComentario` INT NOT NULL,
  `Publicacao_idPublicacao` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `data` DATETIME NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  INDEX `fk_Comentario_Publicacao1_idx` (`Publicacao_idPublicacao` ASC) VISIBLE,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_Comentario_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Comentario_Publicacao1`
    FOREIGN KEY (`Publicacao_idPublicacao`)
    REFERENCES `DW_DB`.`Publicacao` (`idPublicacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DW_DB`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Endereco` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Endereco` (
  `idEndereco` INT NOT NULL,
  `CEP` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `municipio` VARCHAR(45) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `dataCadastro` DATETIME NOT NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Contato` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Contato` (
  `idContato` INT NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Caixa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Caixa` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Caixa` (
  `idCaixa` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  `saldo` FLOAT NOT NULL,
  `dataUltimaEntrada` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCaixa`),
  INDEX `fk_Caixa_Projeto1_idx` (`Projeto_idProjeto` ASC) VISIBLE,
  CONSTRAINT `fk_Caixa_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `DW_DB`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Historico_Doacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Historico_Doacao` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Historico_Doacao` (
  `idHistoricoCaixa` VARCHAR(45) NOT NULL,
  `Caixa_idCaixa` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `valor` FLOAT NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`idHistoricoCaixa`),
  INDEX `fk_Caixa_Historico_Caixa1_idx` (`Caixa_idCaixa` ASC) VISIBLE,
  INDEX `fk_Caixa_Historico_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Caixa_Historico_Caixa1`
    FOREIGN KEY (`Caixa_idCaixa`)
    REFERENCES `DW_DB`.`Caixa` (`idCaixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caixa_Historico_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DW_DB`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Usuario_Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Usuario_Endereco` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Usuario_Endereco` (
  `idUsuario_Endereco` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`idUsuario_Endereco`),
  INDEX `fk_Usuario_Endereco_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Usuario_Endereco_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Endereco_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DW_DB`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Endereco_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `DW_DB`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Usuario_contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Usuario_contato` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Usuario_contato` (
  `idUsuarioContato` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Contato_idContato` INT NOT NULL,
  INDEX `fk_Usuario_contato_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Usuario_contato_Contato1_idx` (`Contato_idContato` ASC) VISIBLE,
  PRIMARY KEY (`idUsuarioContato`),
  CONSTRAINT `fk_Usuario_contato_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DW_DB`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_contato_Contato1`
    FOREIGN KEY (`Contato_idContato`)
    REFERENCES `DW_DB`.`Contato` (`idContato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`ONG_Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`ONG_Endereco` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`ONG_Endereco` (
  `idONGEndereco` VARCHAR(45) NOT NULL,
  `ONG_idONG` INT NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  INDEX `fk_ONG_Endereco_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  PRIMARY KEY (`idONGEndereco`),
  CONSTRAINT `fk_ONG_Endereco_ONG1`
    FOREIGN KEY (`ONG_idONG`)
    REFERENCES `DW_DB`.`ONG` (`idONG`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ONG_Endereco_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `DW_DB`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`ONG_Contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`ONG_Contato` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`ONG_Contato` (
  `idONG_Contato` INT NOT NULL,
  `ONG_idONG` INT NOT NULL,
  `Contato_idContato` INT NOT NULL,
  INDEX `fk_ONG_Contato_ONG1_idx` (`ONG_idONG` ASC) VISIBLE,
  INDEX `fk_ONG_Contato_Contato1_idx` (`Contato_idContato` ASC) VISIBLE,
  CONSTRAINT `fk_ONG_Contato_ONG1`
    FOREIGN KEY (`ONG_idONG`)
    REFERENCES `DW_DB`.`ONG` (`idONG`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ONG_Contato_Contato1`
    FOREIGN KEY (`Contato_idContato`)
    REFERENCES `DW_DB`.`Contato` (`idContato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`ONG_Projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`ONG_Projeto` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`ONG_Projeto` (
  `idONG_Projeto` INT NOT NULL,
  `ONG_idONG1` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  INDEX `fk_ONG_Projeto_ONG2_idx` (`ONG_idONG1` ASC) VISIBLE,
  INDEX `fk_ONG_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC) VISIBLE,
  CONSTRAINT `fk_ONG_Projeto_ONG2`
    FOREIGN KEY (`ONG_idONG1`)
    REFERENCES `DW_DB`.`ONG` (`idONG`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ONG_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `DW_DB`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_DB`.`Benfeitor_Projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DW_DB`.`Benfeitor_Projeto` ;

CREATE TABLE IF NOT EXISTS `DW_DB`.`Benfeitor_Projeto` (
  `idBenfeitor_Projeto` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`idBenfeitor_Projeto`),
  INDEX `fk_Benfeitor_Projeto_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Benfeitor_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC) VISIBLE,
  CONSTRAINT `fk_Benfeitor_Projeto_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DW_DB`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Benfeitor_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `DW_DB`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
