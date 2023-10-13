-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema NBA_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NBA_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NBA_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `NBA_1` ;

-- -----------------------------------------------------
-- Table `NBA_1`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`city` (
  `CITY_ID` INT NOT NULL,
  `CITY_NAME` TEXT NOT NULL,
  `STATE` TEXT NOT NULL,
  `COUNTRY` TEXT NOT NULL,
  PRIMARY KEY (`CITY_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `NBA_1`.`arena`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`arena` (
  `ARENA_ID` INT NOT NULL,
  `ARENA_NAME` TEXT NOT NULL,
  `ARENA_CAPACITY` TEXT NOT NULL,
  `BUILD_YEAR` INT NOT NULL,
  `ARENA_CITY_ID` INT NOT NULL,
  PRIMARY KEY (`ARENA_ID`),
  INDEX `CITY_ID_idx` (`ARENA_CITY_ID` ASC) VISIBLE,
  CONSTRAINT `CITY_ID`
    FOREIGN KEY (`ARENA_CITY_ID`)
    REFERENCES `NBA_1`.`city` (`CITY_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `NBA_1`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`teams` (
  `TEAM_ID` INT NOT NULL,
  `YEAR_FORMED` INT NOT NULL,
  `YEAR_PRESENT` INT NOT NULL,
  `TEAMNAME` TEXT NOT NULL,
  `ABBREVIATION` TEXT NOT NULL,
  `NICKNAME` TEXT NOT NULL,
  `OWNER` TEXT NOT NULL,
  `GENERALMANAGER` TEXT NOT NULL,
  `HEADCOACH` TEXT NOT NULL,
  `TEAMS_ARENA_ID` INT NOT NULL,
  PRIMARY KEY (`TEAM_ID`),
  INDEX `ARENA_ID_idx` (`TEAMS_ARENA_ID` ASC) VISIBLE,
  CONSTRAINT `ARENA_ID2`
    FOREIGN KEY (`TEAMS_ARENA_ID`)
    REFERENCES `NBA_1`.`arena` (`ARENA_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `NBA_1`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`games` (
  `GAME_ID` INT NOT NULL,
  `HOME_TEAM_ID` INT NOT NULL,
  `GAME_DATE_EST` DATETIME NOT NULL,
  `SEASON` INT NOT NULL,
  `PTS_home` INT NOT NULL,
  `FG_PCT_home` DOUBLE NOT NULL,
  `FT_PCT_home` DOUBLE NOT NULL,
  `FG3_PCT_home` DOUBLE NOT NULL,
  `AST_home` INT NOT NULL,
  `REB_home` INT NOT NULL,
  `VISITOR_TEAM_ID` INT NOT NULL,
  `PTS_away` INT NOT NULL,
  `FG_PCT_away` DOUBLE NOT NULL,
  `FT_PCT_away` DOUBLE NOT NULL,
  `FG3_PCT_away` DOUBLE NOT NULL,
  `AST_away` INT NOT NULL,
  `REB_away` INT NOT NULL,
  `HOME_TEAM_WINS` INT NOT NULL,
  PRIMARY KEY (`GAME_ID`),
  INDEX `GAMES_HOME_ID_idx` (`HOME_TEAM_ID` ASC) VISIBLE,
  INDEX `GAMES_VISIT_ID_idx` (`VISITOR_TEAM_ID` ASC) VISIBLE,
  CONSTRAINT `GAMES_HOME_ID`
    FOREIGN KEY (`HOME_TEAM_ID`)
    REFERENCES `NBA_1`.`teams` (`TEAM_ID`),
  CONSTRAINT `GAMES_VISIT_ID`
    FOREIGN KEY (`VISITOR_TEAM_ID`)
    REFERENCES `NBA_1`.`teams` (`TEAM_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `NBA_1`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`players` (
  `PLAYER_ID` INT NOT NULL,
  `PLAYER_NAME` TEXT NOT NULL,
  `TEAM_ID` INT NOT NULL,
  PRIMARY KEY (`PLAYER_ID`),
  INDEX `player_team_id_idx` (`TEAM_ID` ASC) VISIBLE,
  CONSTRAINT `PLAYER_TEAM_ID`
    FOREIGN KEY (`TEAM_ID`)
    REFERENCES `NBA_1`.`teams` (`TEAM_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `NBA_1`.`player_games_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NBA_1`.`player_games_details` (
  `PLAYER_ID` INT NOT NULL,
  `GAME_ID` INT NOT NULL,
  `START_POSITION` TEXT NULL DEFAULT NULL,
  `MIN` TEXT NULL DEFAULT NULL,
  `FGM` INT NULL DEFAULT NULL,
  `FGA` INT NULL DEFAULT NULL,
  `FG_PCT` DOUBLE NULL DEFAULT NULL,
  `FG3M` INT NULL DEFAULT NULL,
  `FG3A` INT NULL DEFAULT NULL,
  `FG3_PCT` DOUBLE NULL DEFAULT NULL,
  `FTM` INT NULL DEFAULT NULL,
  `FTA` INT NULL DEFAULT NULL,
  `FT_PCT` DOUBLE NULL DEFAULT NULL,
  `OREB` INT NULL DEFAULT NULL,
  `DREB` INT NULL DEFAULT NULL,
  `REB` INT NULL DEFAULT NULL,
  `AST` INT NULL DEFAULT NULL,
  `STL` INT NULL DEFAULT NULL,
  `BLK` INT NULL DEFAULT NULL,
  `TO` INT NULL DEFAULT NULL,
  `PF` INT NULL DEFAULT NULL,
  `PTS` INT NULL DEFAULT NULL,
  `PLUS_MINUS` INT NULL DEFAULT NULL,
  PRIMARY KEY (`PLAYER_ID`, `GAME_ID`),
  INDEX `GAME_ID_idx` (`GAME_ID` ASC) VISIBLE,
  CONSTRAINT `pgd_game_id`
    FOREIGN KEY (`GAME_ID`)
    REFERENCES `NBA_1`.`games` (`GAME_ID`),
  CONSTRAINT `pgd_player_id`
    FOREIGN KEY (`PLAYER_ID`)
    REFERENCES `NBA_1`.`players` (`PLAYER_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
