CREATE SCHEMA IF NOT EXISTS `viaVerde`;

USE `viaVerde`;

-- -----------------------------------------------------
-- tabela CLIENTS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`clients`
(
  `id_cpf` CHAR(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cpf`),
  UNIQUE (`email`)
  ); 	

-- -----------------------------------------------------
-- tabela FARMERS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`farmers`
(
  `id_cpf` CHAR(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `organic_certificate` BOOLEAN NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cpf`),
  UNIQUE (`email`)
);

-- -----------------------------------------------------
-- tabela MARKETS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`markets`
(
  `id_market` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `adress` VARCHAR(60) NULL,
  PRIMARY KEY (`id_market`)
);

-- -----------------------------------------------------
-- tabela BUYS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`buys` (
  `id_buy` INT NOT NULL AUTO_INCREMENT,
  `clients_id_cpf` CHAR(11) NOT NULL,
  `farmers_id_cpf` CHAR(11) NOT NULL,
  `recue_data` DATETIME NOT NULL, -- A GENTE IA USAR O TIMESTAMP, mas era complexa e é mais específica 
  `markets_id_market` INT NOT NULL,
  PRIMARY KEY (`id_buy`),
  FOREIGN KEY (`clients_id_cpf`) REFERENCES `viaVerde`.`clients` (`id_cpf`),
  FOREIGN KEY (`farmers_id_cpf`) REFERENCES `viaVerde`.`farmers` (`id_cpf`),
  FOREIGN KEY (`markets_id_market`) REFERENCES `viaVerde`.`markets` (`id_market`)
);


-- -----------------------------------------------------
-- tabela OPERATION_DAY
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`operation_days` (
	`markets_id_market` INT NOT NULL,
	`operation_day` DATE NOT NULL,
	`opening` TIME NULL,
	`closure` TIME NULL,
    FOREIGN KEY (`markets_id_market`) REFERENCES `viaVerde`.`markets` (`id_market`),
	PRIMARY KEY (`markets_id_market`, `operation_day`)
);

-- -----------------------------------------------------
-- tabela MARKETS_WAS_FARMERS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viaVerde`.`markets_have_farmers` (
	`markets_id_market` INT NOT NULL,
	`farmers_id_cpf` CHAR(11) NOT NULL,
	
    PRIMARY KEY (`markets_id_market`, `farmers_id_cpf`),
	FOREIGN KEY (`markets_id_market`) REFERENCES `viaVerde`.`markets` (`id_market`),
	FOREIGN KEY (`farmers_id_cpf`) REFERENCES `viaVerde`.`farmers` (`id_cpf`)
);

-- -----------------------------------------------------
-- POPULANDO E CONSULTANDO AS TABELAS
-- -----------------------------------------------------

USE `viaVerde`;

INSERT INTO `viaVerde`.`clients` VALUES ('69013032893', 'Rebecca Maria Marlene', 'becca@gmail.com');
INSERT INTO `viaVerde`.`clients` VALUES ('14268305300', 'Renan Lorenzo Sérgio Costa', 'renancosta@gmail.com');
INSERT INTO `viaVerde`.`clients` VALUES ('20341345407', 'Martin Pietro Diego da Mata', 'martinpdmata@gmail.com');
INSERT INTO `viaVerde`.`clients` VALUES ('44434759078', 'Maya Juliana da Paz', 'mayadapaz@hotmail.com');
INSERT INTO `viaVerde`.`clients` VALUES ('03289369013', 'Vanessa Alessandra da Luz', 'nessaluz@hotmail.com');
-- pra dar erro e testar tua fé:
INSERT INTO `viaVerde`.`clients` VALUES ('03289369013', 'Teste com mesmo CPF', 'testecpf@gmail.com'); -- mesmo cpf da anterior

-- -----------------------------------------------------
-- consultar todos os clientes
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`clients`;

-- ALTERANDO clients
UPDATE `clients`
SET `email` = 'beccamm@gmail.com'
WHERE `id_cpf` = '69013032893';

-- -----------------------------------------------------
-- consultar todos os clientes
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`clients`; -- observar que houve alteração em becca

-- -----------------------------------------------------
-- populando FARMERS
-- -----------------------------------------------------
INSERT INTO `viaVerde`.`farmers` VALUES ('15334358944', 'Josiane Maria de Souza', True, 'josiane@fetape.com');
INSERT INTO `viaVerde`.`farmers` VALUES ('13538944345', 'José Ferreira da Costa', False, 'costaze@fetape.com');
INSERT INTO `viaVerde`.`farmers` VALUES ('03289369013', 'Vanessa Alessandra da Luz', True, 'nessaluz2@hotmail.com');
INSERT INTO `viaVerde`.`farmers` VALUES ('44955616429', 'Katyene Cavalcanti Reis', True, 'katyene.reis@geradornv.com.br');
INSERT INTO `viaVerde`.`farmers` VALUES ('86287626046', 'Benedito Livramento Cruz', True, 'benedito.cruz@geradornv.com.br');
INSERT INTO `viaVerde`.`farmers` VALUES ('12477634522', 'Marcos Antonio Silva', False, 'marcantonio@gmail.com');

-- -----------------------------------------------------
-- consultar quem tem certificado orgânico
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`farmers` WHERE organic_certificate = 1;

-- -----------------------------------------------------
-- consultar quem é produtor e cliente simultaneamente
-- -----------------------------------------------------
SELECT `clients`.`id_cpf`, `farmers`.`id_cpf`
	FROM `clients`
	INNER JOIN `farmers`
		 on `clients`.`id_cpf` = `farmers`.`id_cpf`;

-- -----------------------------------------------------
-- populando MARKETS
-- -----------------------------------------------------
INSERT INTO `viaVerde`.`markets` VALUES (DEFAULT, 'FETAPE', 'R. Gervásio Pires, 876 - Santo Amaro, Recife - PE, 50050-070');
INSERT INTO `viaVerde`.`markets` VALUES (DEFAULT, 'Santo Amaro', 'Rua Frei Cassimiro, SN - Santo Amaro, Recife - PE');
INSERT INTO `viaVerde`.`markets` VALUES (DEFAULT, 'Casa Amarela', 'Rua Padre Lemos, 94 - Casa Amarela, Recife - PE');
INSERT INTO `viaVerde`.`markets` VALUES (DEFAULT, 'Parnamirim', 'Rua do Parnamirim, SN - Parnamirim, Recife - PE');

-- -----------------------------------------------------
-- consultando a feira de santo amaro
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`markets` WHERE `name` = "Santo Amaro";

-- -----------------------------------------------------
-- populando OPERATION_DAYS
-- -----------------------------------------------------
INSERT INTO `viaVerde`.`operation_days` VALUES(1, '2022-06-25', '07:00:00', '16:00:00');
INSERT INTO `viaVerde`.`operation_days` VALUES(2, '2022-06-27', '08:00:00', '17:00:00');
INSERT INTO `viaVerde`.`operation_days` VALUES(3, '2022-06-25', '10:00:00', '18:00:00');
INSERT INTO `viaVerde`.`operation_days` VALUES(4, '2022-06-27', '06:00:00', '11:00:00');

-- -----------------------------------------------------
-- consultar as feiras da data de hoje
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`operation_days` WHERE operation_day = '2022-06-27'; -- data do dia da apresentação

SELECT *, `name` FROM `viaVerde`.`operation_days`, `viaVerde`.`markets` WHERE operation_day = '2022-06-27'; -- seleciona, também, o nome das feiras de hoje

-- POPULANDO MARKETS_HAVE_FARMERS
INSERT INTO `viaVerde`.`markets_have_farmers` VALUES(1, '15334358944');
INSERT INTO `viaVerde`.`markets_have_farmers` VALUES(3, '13538944345');
INSERT INTO `viaVerde`.`markets_have_farmers` VALUES(4, '03289369013');
INSERT INTO `viaVerde`.`markets_have_farmers` VALUES(2, '44955616429');
INSERT INTO `viaVerde`.`markets_have_farmers` VALUES(1, '86287626046');

-- -----------------------------------------------------
-- consultar quem é da feira da FETAPE (feira 1)
-- -----------------------------------------------------
SELECT *, `name` FROM `viaVerde`.`markets_have_farmers`, `viaVerde`.`farmers` WHERE `markets_id_market` = 1;

-- -----------------------------------------------------
-- populando BUYS
-- -----------------------------------------------------
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '69013032893', '15334358944', '2022-06-27 15:35:00', 1);
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '14268305300', '13538944345', '2022-06-27 10:48:00', 2);
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '20341345407', '03289369013', '2022-06-27 17:40:00', 3);
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '44434759078', '15334358944', '2022-06-27 10:00:00', 4);
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '03289369013', '86287626046', '2022-06-27 13:45:00', 1);
INSERT INTO `viaVerde`.`buys` VALUES(DEFAULT, '75907844434', '44955616429', '2022-06-27 10:15:00', 2);

-- -----------------------------------------------------
-- consultando quais compras foram feitas na feira da FETAPE
-- -----------------------------------------------------
SELECT * FROM `viaVerde`.`buys` WHERE `markets_id_market` = 1;
