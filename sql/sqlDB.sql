-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `Customer_id` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Phone_Number` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `Staff_id` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Roll` VARCHAR(45) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `Booking_id` INT NOT NULL AUTO_INCREMENT,
  `Booking_date` DATE NOT NULL,
  `Table_number` INT NOT NULL,
  `Nbr_of_guests` INT NOT NULL,
  `Customer_id` INT NOT NULL,
  `Staff_id` INT NOT NULL,
  PRIMARY KEY (`Booking_id`),
  INDEX `Customer_id_idx` (`Customer_id` ASC) VISIBLE,
  INDEX `Staff_id_idx` (`Staff_id` ASC) VISIBLE,
  CONSTRAINT `Customer_id_fk`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `LittleLemonDB`.`Customers` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_id_fk`
    FOREIGN KEY (`Staff_id`)
    REFERENCES `LittleLemonDB`.`Staff` (`Staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_Delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_Delivery_status` (
  `Order_delivery_id` INT NOT NULL AUTO_INCREMENT,
  `Delivery_Status` VARCHAR(45) NULL,
  `Delivery_date` DATETIME NULL,
  PRIMARY KEY (`Order_delivery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `Order_id` INT NOT NULL AUTO_INCREMENT,
  `Customer_id` INT NOT NULL,
  `Order_date` DATETIME NULL,
  `Delivery_date` DATETIME NULL,
  `Quantity` DECIMAL(10,2) NOT NULL,
  `Total_cost` DECIMAL(10,2) NOT NULL,
  `Order_delivery_id` INT NOT NULL,
  `Staff_id` INT NOT NULL,
  PRIMARY KEY (`Order_id`),
  INDEX `Customer_id_idx` (`Customer_id` ASC) VISIBLE,
  INDEX `Staff_id_idx` (`Staff_id` ASC) VISIBLE,
  INDEX `Order_delivery_id_fk_idx` (`Order_delivery_id` ASC) VISIBLE,
  CONSTRAINT `Customer_id`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `LittleLemonDB`.`Customers` (`Customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Order_delivery_id`
    FOREIGN KEY (`Order_delivery_id`)
    REFERENCES `LittleLemonDB`.`Order_Delivery_status` (`Order_delivery_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_id`
    FOREIGN KEY (`Staff_id`)
    REFERENCES `LittleLemonDB`.`Staff` (`Staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `Menu_id` INT NOT NULL AUTO_INCREMENT,
  `Starts` VARCHAR(45) NOT NULL,
  `Courses` VARCHAR(45) NULL,
  `Drinks` VARCHAR(45) NULL,
  `Desserts` VARCHAR(45) NULL,
  `Order_id` INT NOT NULL,
  PRIMARY KEY (`Menu_id`),
  INDEX `Order_id_idx` (`Order_id` ASC) VISIBLE,
  CONSTRAINT `Order_id_fk`
    FOREIGN KEY (`Order_id`)
    REFERENCES `LittleLemonDB`.`Orders` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
