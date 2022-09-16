-- MySQL Script generated by MySQL Workbench
-- Fri Sep 16 18:14:04 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema S02T01N01AdriaMartiComas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema S02T01N01AdriaMartiComas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `S02T01N01AdriaMartiComas` DEFAULT CHARACTER SET utf8 ;
USE `S02T01N01AdriaMartiComas` ;

-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Adreces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Adreces` (
  `Adreces_id` INT NOT NULL,
  `Adreces_carrer` VARCHAR(45) NULL,
  `Adreces_numero` INT NULL,
  `Adreces_pis` VARCHAR(45) NULL,
  `Adreces_porta` VARCHAR(10) NULL,
  `Adreces_ciutat` VARCHAR(45) NULL,
  `Adreces_codi postal` VARCHAR(12) NULL,
  `Adreces_pais` VARCHAR(45) NULL,
  PRIMARY KEY (`Adreces_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Proveidors` (
  `Proveidors_id` INT NOT NULL AUTO_INCREMENT,
  `Proveidors_nom` VARCHAR(45) NULL,
  `Adreces_Adreces_id` INT NOT NULL,
  `Proveidors_telefon` INT NULL,
  `Proveidors_fax` INT NULL,
  `Proveidors_nif` VARCHAR(9) NULL,
  PRIMARY KEY (`Proveidors_id`, `Adreces_Adreces_id`),
  INDEX `fk_Proveidors_Adreces_idx` (`Adreces_Adreces_id` ASC),
  CONSTRAINT `fk_Proveidors_Adreces`
    FOREIGN KEY (`Adreces_Adreces_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Adreces` (`Adreces_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Marques` (
  `Marques_id` INT NOT NULL AUTO_INCREMENT,
  `Marques_nom` VARCHAR(45) NULL,
  `Proveidors_Proveidors_id` INT NOT NULL,
  PRIMARY KEY (`Marques_id`),
  INDEX `fk_Marques_Proveidors1_idx` (`Proveidors_Proveidors_id` ASC),
  CONSTRAINT `fk_Marques_Proveidors1`
    FOREIGN KEY (`Proveidors_Proveidors_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Proveidors` (`Proveidors_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Ulleres` (
  `Ulleres_id` INT NOT NULL AUTO_INCREMENT,
  `Marques_Marques_id` INT NOT NULL,
  `Ulleres_graduacio_dreta` VARCHAR(45) NULL,
  `Ulleres_graduacio_esquerra` VARCHAR(45) NULL,
  `Ulleres_tipus_de muntura` VARCHAR(1) NULL COMMENT 'valors possibles:\nF = flotante\nP = pasta\nM = metalica',
  `Ulleres_color_muntura` VARCHAR(45) NULL,
  `Ulleres_color_vidres` VARCHAR(45) NULL,
  `Ulleres_preu` DECIMAL(10) NULL,
  PRIMARY KEY (`Ulleres_id`),
  INDEX `fk_Ulleres_Marques1_idx` (`Marques_Marques_id` ASC),
  CONSTRAINT `fk_Ulleres_Marques1`
    FOREIGN KEY (`Marques_Marques_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Marques` (`Marques_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Clients` (
  `Clients_id` INT NOT NULL AUTO_INCREMENT,
  `Clients_nom` VARCHAR(45) NULL,
  `Adreces_Adreces_id` INT NOT NULL,
  `Clients_telefon` INT NULL,
  `Clients_mail` VARCHAR(254) NULL,
  `Clients_data_registre` DATETIME NULL,
  `Clients_` VARCHAR(45) NULL,
  `Clients_Recomenat_per_Clients_id` INT NOT NULL,
  PRIMARY KEY (`Clients_id`, `Adreces_Adreces_id`, `Clients_Recomenat_per_Clients_id`),
  INDEX `fk_Clients_Adreces1_idx` (`Adreces_Adreces_id` ASC),
  INDEX `fk_Clients_Clients1_idx` (`Clients_Recomenat_per_Clients_id` ASC),
  CONSTRAINT `fk_Clients_Adreces1`
    FOREIGN KEY (`Adreces_Adreces_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Adreces` (`Adreces_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clients_Clients1`
    FOREIGN KEY (`Clients_Recomenat_per_Clients_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Clients` (`Clients_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`Empleats` (
  `Empleats_id` INT NOT NULL,
  `Empleats_nom` VARCHAR(45) NULL,
  `Empleats_nif` VARCHAR(45) NULL,
  PRIMARY KEY (`Empleats_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S02T01N01AdriaMartiComas`.`ventes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S02T01N01AdriaMartiComas`.`ventes` (
  `ventes_id` INT NOT NULL,
  `Empleats_Empleats_id` INT NOT NULL,
  `Ulleres_Ulleres_id` INT NOT NULL,
  `Clients_Clients_id` INT NOT NULL,
  PRIMARY KEY (`ventes_id`, `Empleats_Empleats_id`, `Ulleres_Ulleres_id`),
  INDEX `fk_ventes_Empleats1_idx` (`Empleats_Empleats_id` ASC),
  INDEX `fk_ventes_Ulleres1_idx` (`Ulleres_Ulleres_id` ASC),
  INDEX `fk_ventes_Clients1_idx` (`Clients_Clients_id` ASC),
  CONSTRAINT `fk_ventes_Empleats1`
    FOREIGN KEY (`Empleats_Empleats_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Empleats` (`Empleats_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ventes_Ulleres1`
    FOREIGN KEY (`Ulleres_Ulleres_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Ulleres` (`Ulleres_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ventes_Clients1`
    FOREIGN KEY (`Clients_Clients_id`)
    REFERENCES `S02T01N01AdriaMartiComas`.`Clients` (`Clients_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
