CREATE SCHEMA IF NOT EXISTS `viaVerde`;

USE `viaVerde`;

-- CRIANDO TABELA clients

CREATE TABLE IF NOT EXISTS viaVerde.clients (
  `id-cpf` CHAR(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE (`email`)
  ); 	

-- Table `viaVerde`.`farmers`

CREATE TABLE IF NOT EXISTS `viaVerde`.`farmers` (
  `id-cpf` CHAR(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `certificado-organico` BOOLEAN NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id-cpf`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `viaVerde`.`feiras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`feiras` (
  `id-feira` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `adress` VARCHAR(60) NULL,
  PRIMARY KEY (`id-feira`));


-- -----------------------------------------------------
-- Table `viaVerde`.`compras-vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`compras-vendas` (
  `id-compra` INT NOT NULL AUTO_INCREMENT,
  `clients_id-cpf` CHAR(11) NOT NULL,
  `farmers_id-cpf` CHAR(11) NOT NULL,
  `resgate-data` DATETIME NOT NULL, -- A GENTE IA USAR O TIMESTAMP
  `feiras_id-feira` INT NOT NULL,
  PRIMARY KEY (`id-compra`),
  INDEX `fk_compras_clients1_idx` (`clients_id-cpf` ASC) VISIBLE,
  INDEX `fk_compras_farmers1_idx` (`farmers_id-cpf` ASC) VISIBLE,
  INDEX `fk_compras-vendas_feiras1_idx` (`feiras_id-feira` ASC) VISIBLE,
  CONSTRAINT `fk_compras_clients1`
    FOREIGN KEY (`clients_id-cpf`)
    REFERENCES `viaVerde`.`clients` (`id-cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_farmers1`
    FOREIGN KEY (`farmers_id-cpf`)
    REFERENCES `viaVerde`.`farmers` (`id-cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras-vendas_feiras1`
    FOREIGN KEY (`feiras_id-feira`)
    REFERENCES `viaVerde`.`feiras` (`id-feira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `viaVerde`.`dia-de-funcionamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`dia-de-funcionamento` (
  `feiras_id-feira` INT NOT NULL ,
  -- chave composta de feiras com dia-de-funcionamento
  `dia-de-funcionamento` DATE NULL,
  `abertura` TIME NULL,
  `fechamento` TIME NULL,
  INDEX `fk_calendario_feiras1_idx` (`feiras_id-feira` ASC) VISIBLE,
  CONSTRAINT `fk_calendario_feiras1`
	-- UNIQUE INDEX `feiras_UNIQUE` (`feiras_id-feira` ASC) VISIBLE, -- PERIGO FAZER
    FOREIGN KEY (`feiras_id-feira`)
    REFERENCES `viaVerde`.`feiras` (`id-feira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `viaVerde`.`feiras_tem_farmers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`feiras_tem_farmers` (
  `feiras_id-feira` INT NOT NULL,
  `farmers_id-cpf` CHAR(11) NOT NULL,
  PRIMARY KEY (`feiras_id-feira`, `farmers_id-cpf`),
  INDEX `fk_feiras_has_farmers_farmers1_idx` (`farmers_id-cpf` ASC) VISIBLE,
  INDEX `fk_feiras_has_farmers_feiras1_idx` (`feiras_id-feira` ASC) VISIBLE,
  CONSTRAINT `fk_feiras_tem_farmers_feiras1`
    FOREIGN KEY (`feiras_id-feira`)
    REFERENCES `viaVerde`.`feiras` (`id-feira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feiras_tem_farmers_farmers1`
    FOREIGN KEY (`farmers_id-cpf`)
    REFERENCES `viaVerde`.`farmers` (`id-cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- POPULANDO clients

START TRANSACTION; -- FAZER PESQUISAR
-- Usado para começar a realizar transações, após a criação do schema

USE `viaVerde`;

INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('69013032893', 'Rebecca Maria Marlene', 'becca@gmail.com');
INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('14268305300', 'Renan Lorenzo Sérgio Costa', 'renancosta@gmail.com');
INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('20341345407', 'Martin Pietro Diego da Mata', 'martinpdmata@gmail.com');
INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('44434759078', 'Maya Juliana da Paz', 'mayadapaz@hotmail.com');
INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('03289369013', 'Vanessa Alessandra da Luz', 'nessaluz@hotmail.com');
INSERT INTO `viaVerde`.`clients` (`id-cpf`, `name`, `email`) VALUES ('75907844434', 'Teste com mesmo CPF', 'testecpf@gmail.com'); -- mesmo cpf da anterior

-- ALTERANDO clients

UPDATE `clients`
SET `email` = 'beccamm@gmail.com'
WHERE `id-cpf` = '69013032893';

-- CONSULTANDO TODOS OS clients
SELECT * FROM `viaVerde`.`clients`;

-- FAZER COMO CONSULTAR APENAS UM ITEM, POR SUAS CARACTERÍSTICAS
-- SELECT '69013032893' FROM `viaVerde`.`clients`;
-- FAZER OUTRAS CONSULTAS


-- POPULANDO farmers

INSERT INTO `viaVerde`.`farmers` (`id-cpf`, `name`, `certificado-organico`, `email`) VALUES ('15334358944', 'Josiane Maria de Souza', True, 'josiane@fetape.com');
INSERT INTO `viaVerde`.`farmers` (`id-cpf`, `name`, `certificado-organico`, `email`) VALUES ('13538944345', 'Jose', False, 'jose@fetape.com');
INSERT INTO `viaVerde`.`farmers` (`id-cpf`, `name`, `certificado-organico`, `email`) VALUES ('03289369013', 'Vanessa Alessandra da Luz', True, 'nessaluz2@hotmail.com');
INSERT INTO `viaVerde`.`farmers` (`id-cpf`, `name`, `certificado-organico`, `email`) VALUES ('44955616429', 'Katyene Cavalcanti Reis', True, 'katyene.reis@geradornv.com.br');
INSERT INTO `viaVerde`.`farmers` (`id-cpf`, `name`, `certificado-organico`, `email`) VALUES ('86287626046', 'Benedito Livramento Cruz', True, 'benedito.cruz@geradornv.com.br');

SELECT * FROM `viaVerde`.`farmers`;

-- consultar quem é produtor e cliente 

SELECT `clients`.`id-cpf`, `farmers`.`id-cpf`
	FROM `clients`
	INNER JOIN `farmers`
		 on `clients`.`id-cpf` = `farmers`.`id-cpf`;
-- FAZER ELE IMPRIMIR name E COISAS MAIS

-- POPULANDO AS FEIRAS
INSERT INTO `viaVerde`.`feiras` (`name`, `adress`) VALUES ('FETAPE', 'R. Gervásio Pires, 876 - Santo Amaro, Recife - PE, 50050-070');
INSERT INTO `viaVerde`.`feiras` (`name`, `adress`) VALUES ('Santo Amaro', 'Rua Frei Cassimiro, SN - Santo Amaro, Recife - PE');
INSERT INTO `viaVerde`.`feiras` (`name`, `adress`) VALUES ('Casa Amarela', 'Rua Padre Lemos, 94 - Casa Amarela, Recife - PE');
INSERT INTO `viaVerde`.`feiras` (`name`, `adress`) VALUES ('Parnamirim', 'Rua do Parnamirim, SN - Parnamirim, Recife - PE');

-- CONSULTANDO AS FEIRAS
SELECT * FROM `viaVerde`.`feiras`;

-- POPULANDO DIA-DE-FUNCIONAMENTO

INSERT INTO `viaVerde`.`dia-de-funcionamento` VALUES(1, '2022-06-25', '07:00:00', '16:00:00');
INSERT INTO `viaVerde`.`dia-de-funcionamento` VALUES(2, '2022-06-25', '08:00:00', '17:00:00');
INSERT INTO `viaVerde`.`dia-de-funcionamento` VALUES(3, '2022-06-25', '10:00:00', '18:00:00');
INSERT INTO `viaVerde`.`dia-de-funcionamento` VALUES(4, '2022-06-25', '06:00:00', '11:00:00');

-- ISSO TA ERRADO, PODE SER SÓ UMA DATA E COLOCAR OS DADOS COMO TIME
SELECT * FROM `viaVerde`.`dia-de-funcionamento`;

-- POPULANDO FEIRAS_TEM_farmers
INSERT INTO `viaVerde`.`feiras_tem_farmers` VALUES(1, '15334358944');
INSERT INTO `viaVerde`.`feiras_tem_farmers` VALUES(3, '13538944345');
INSERT INTO `viaVerde`.`feiras_tem_farmers` VALUES(4, '03289369013');
INSERT INTO `viaVerde`.`feiras_tem_farmers` VALUES(2, '44955616429');
INSERT INTO `viaVerde`.`feiras_tem_farmers` VALUES(1, '86287626046');

SELECT * FROM `viaVerde`.`feiras_tem_farmers`;
-- ver como imprime com name

-- POPULANDO COMPRA-VENDA
INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('69013032893', '15334358944', '2022-06-25 15:35:00', 1);
INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('14268305300', '13538944345', '2022-06-25 10:48:00', 2);
INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('20341345407', '03289369013', '2022-06-25 17:40:00', 3);
INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('44434759078', '15334358944', '2022-06-25 10:00:00', 4);

INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('03289369013', '86287626046', '2022-06-25 13:45:00', 1);
INSERT INTO `viaVerde`.`compras-vendas` (`clients_id-cpf`, `farmers_id-cpf`, `resgate-data`, `feiras_id-feira`) VALUES('75907844434', '44955616429', '2022-06-25 10:15:00', 2);

SELECT * FROM `viaVerde`.`compras-vendas`;

-- fazer chave composta de feiras com dia-de-funcionamento





-- FAZER SE DER TEMPO, USAR O POSTGREE PRA LOCALIZAÇÃO
-- https://mundogeo.com/2009/01/01/mysql-e-postgresql/#:~:text=O%20MySQL%20oferece%20uma%20funcionalidade,ao%20padr%C3%A3o%20do%20SQL%2FMM.

-- FAZER SE DER TEMPO, FORMATAR VALORES DE DATAS E AFINS PARA PADRÃO BR
-- https://pt.stackoverflow.com/questions/17679/como-inserir-date-e-datetime-em-uma-tabela-no-mysql






