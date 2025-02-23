-- MySQL Script generated by MySQL Workbench
-- Sat Oct  8 03:37:55 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema npedidos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `npedidos` ;

-- -----------------------------------------------------
-- Schema npedidos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `npedidos` DEFAULT CHARACTER SET utf8 ;
USE `npedidos` ;

-- -----------------------------------------------------
-- Table `npedidos`.`types_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`types_dishes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`food_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`food_dishes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `types_dishes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_food_dishes_types_dishes_idx` (`types_dishes_id` ASC) VISIBLE,
  CONSTRAINT `fk_food_dishes_types_dishes`
    FOREIGN KEY (`types_dishes_id`)
    REFERENCES `npedidos`.`types_dishes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_order` DATETIME NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ordering_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_ordering_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `npedidos`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key_name` VARCHAR(45) NOT NULL,
  `value` TEXT NOT NULL,
  `description` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `key_name_UNIQUE` (`key_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`exclude_days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`exclude_days` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_exclude` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `date_exclude_UNIQUE` (`date_exclude` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`orders_has_food_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`orders_has_food_dishes` (
  `orders_id` INT NOT NULL,
  `food_dishes_id` INT NOT NULL,
  PRIMARY KEY (`orders_id`, `food_dishes_id`),
  INDEX `fk_orders_has_food_dishes_food_dishes1_idx` (`food_dishes_id` ASC) VISIBLE,
  INDEX `fk_orders_has_food_dishes_orders1_idx` (`orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_food_dishes_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `npedidos`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_food_dishes_food_dishes1`
    FOREIGN KEY (`food_dishes_id`)
    REFERENCES `npedidos`.`food_dishes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`menus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `npedidos`.`menus_has_food_dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `npedidos`.`menus_has_food_dishes` (
  `menus_id` INT NOT NULL,
  `food_dishes_id` INT NOT NULL,
  PRIMARY KEY (`menus_id`, `food_dishes_id`),
  INDEX `fk_menus_has_food_dishes_food_dishes1_idx` (`food_dishes_id` ASC) VISIBLE,
  INDEX `fk_menus_has_food_dishes_menus1_idx` (`menus_id` ASC) VISIBLE,
  CONSTRAINT `fk_menus_has_food_dishes_menus1`
    FOREIGN KEY (`menus_id`)
    REFERENCES `npedidos`.`menus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menus_has_food_dishes_food_dishes1`
    FOREIGN KEY (`food_dishes_id`)
    REFERENCES `npedidos`.`food_dishes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
