-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SAMPLE44
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SAMPLE44
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAMPLE44` DEFAULT CHARACTER SET utf8 ;
USE `SAMPLE44` ;

-- -----------------------------------------------------
-- Table `SAMPLE44`.`PUBLISHER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`PUBLISHER` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`BOOK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`BOOK` (
  `BookId` INT UNSIGNED NOT NULL,
  `Title` VARCHAR(45) NULL,
  `PublisherName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookId`),
  INDEX `PublisherName_idx` (`PublisherName` ASC),
  CONSTRAINT `BPublisherFK`
    FOREIGN KEY (`PublisherName`)
    REFERENCES `SAMPLE44`.`PUBLISHER` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`BOOK_AUTHORS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`BOOK_AUTHORS` (
  `BookId` INT UNSIGNED NOT NULL,
  `AuthorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookId`, `AuthorName`),
  CONSTRAINT `BAIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`LIBRARY_BRANCH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`LIBRARY_BRANCH` (
  `BranchId` INT UNSIGNED NOT NULL,
  `BranchName` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`BranchId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`BOOK_COPIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`BOOK_COPIES` (
  `BookId` INT UNSIGNED NOT NULL,
  `BranchId` INT UNSIGNED NOT NULL,
  `No_Of_Copies` INT NOT NULL,
  PRIMARY KEY (`BookId`, `BranchId`),
  INDEX `BranchId_idx` (`BranchId` ASC),
  CONSTRAINT `BCIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BCBranchId`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE44`.`LIBRARY_BRANCH` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`BORROWER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`BORROWER` (
  `CardNo` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`CardNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE44`.`BOOK_LOANS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE44`.`BOOK_LOANS` (
  `BookId` INT UNSIGNED NOT NULL,
  `BranchId` INT UNSIGNED NOT NULL,
  `CardNo` VARCHAR(45) NOT NULL,
  `DateOut` DATE NULL,
  `DueDate` DATE NULL,
  PRIMARY KEY (`BookId`, `BranchId`, `CardNo`),
  INDEX `CardNo_idx` (`CardNo` ASC),
  INDEX `BranchId_idx` (`BranchId` ASC),
  CONSTRAINT `BLIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BLBranchIdFK`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE44`.`LIBRARY_BRANCH` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BLCardNoFK`
    FOREIGN KEY (`CardNo`)
    REFERENCES `SAMPLE44`.`BORROWER` (`CardNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/PUBLISHER.txt' INTO TABLE PUBLISHER
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/BOOK.txt' INTO TABLE BOOK
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/BOOK_AUTHORS.txt' INTO TABLE BOOK_AUTHORS
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/BORROWER.txt' INTO TABLE BORROWER
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/LIBRARY_BRANCH.txt' INTO TABLE LIBRARY_BRANCH
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/BOOK_LOANS.txt' INTO TABLE BOOK_LOANS
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';

LOAD DATA LOCAL INFILE '/home/usera/git/Database_Labs/Lab4/Data/BOOK_COPIES.txt' INTO TABLE BOOK_COPIES
FIELDS TERMINATED BY ','
LINES STARTING BY 'start';


SELECT COUNT(*) FROM BOOK;
SELECT COUNT(*) FROM BOOK_AUTHORS;
SELECT COUNT(*) FROM BOOK_COPIES;
SELECT COUNT(*) FROM BOOK_LOANS;
SELECT COUNT(*) FROM BORROWER;
SELECT COUNT(*) FROM LIBRARY_BRANCH;
SELECT COUNT(*) FROM PUBLISHER;


SELECT TABLE_NAME AS 'TABLE', 
IFNULL(ROUND((DATA_LENGTH + INDEX_LENGTH) / power(1024, 2), 2), 0.00) AS 'TOTAL SIZE (MB)', 
IFNULL(ROUND((DATA_LENGTH + INDEX_LENGTH - DATA_FREE) / power(1024, 2), 2), 0.00) AS 'DATA USED SIZE (MB)', 
IFNULL(ROUND(DATA_FREE / POWER(1024, 2), 2), 0.00) AS 'FREE SIZE (MB)'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'SAMPLE44';


OPTIMIZE TABLE BOOK;
OPTIMIZE TABLE BOOK_AUTHORS;
OPTIMIZE TABLE BOOK_COPIES;
OPTIMIZE TABLE BOOK_LOANS;
OPTIMIZE TABLE BORROWER;
OPTIMIZE TABLE LIBRARY_BRANCH;
OPTIMIZE TABLE PUBLISHER;