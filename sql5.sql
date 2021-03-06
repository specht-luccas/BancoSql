
/*TRIGGERS*/


DELIMITER $$
CREATE TRIGGER Ex1 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @fuf = new.Uf ;
IF(@fuf != 'RS' AND @fuf != 'SC' AND @fuf != 'SP' AND @fuf != 'RJ' AND @fuf != 'RR' AND @fuf != 'GO' AND @fuf != 'MS' AND
@fuf != 'SE' AND @fuf != 'AP' AND @fuf != 'AC' AND @fuf != 'AL' AND @fuf != 'AM' AND @fuf != 'BA' AND @fuf != 'CE' AND
@fuf != 'DF' AND @fuf != 'ES' AND @fuf != 'MA' AND @fuf != 'MG' AND @fuf != 'MT' AND @fuf != 'PA' AND @fuf != 'PB' AND
@fuf != 'PE' AND @fuf != 'PI' AND @fuf != 'PR' AND @fuf != 'RN' AND @fuf != 'RO' AND @fuf != 'TO' )THEN
SET new.Uf = NULL;
END IF ;
END $$
DELIMITER ;

DROP TRIGGER Ex1;

INSERT INTO `cliente` VALUES (1577,'Laura Gomena','95997  Cuba Blvd.','Warrek','46876','RS','318589545');

SELECT Uf FROM cliente GROUP BY Uf;





/2) Faça um gatilho que não permita atualizar a UF do cliente, caso a UF não seja válida./

DELIMITER $$
CREATE TRIGGER Ex2 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @fuf = new.Uf ;
IF(@fuf = 'RS' OR @fuf = 'SC' OR @fuf = 'SP' OR @fuf = 'RJ'  OR @fuf = 'RR'  OR @fuf = 'GO'  OR @fuf = 'MS'  OR
@fuf = 'SE'  OR @fuf = 'AP'  OR @fuf = 'AC'  OR @fuf = 'AL'  OR @fuf = 'AM'  OR @fuf = 'BA' OR @fuf = 'CE' OR
@fuf = 'DF'  OR @fuf = 'ES'  OR @fuf = 'MA'  OR @fuf = 'MG'  OR @fuf = 'MT' OR @fuf = 'PA' OR @fuf = 'PB' OR
@fuf = 'PE'  OR @fuf = 'PI'  OR @fuf = 'PR'  OR @fuf = 'RN'  OR @fuf = 'RO' OR @fuf = 'TO' )THEN
SET new.Uf = NULL;
END IF ;
END $$
DELIMITER ;

DROP TRIGGER Ex2;

INSERT INTO `cliente` VALUES (1581,'Laura Gomena','95997  Cuba Blvd.','Warrek','46876','RS','318589545');







/*3) Faça um gatilho que, durante o cadastro de um cliente, se a UF estiver em minúsculo, passe a UF
para maiúsculo.*/

DELIMITER $$
CREATE TRIGGER Ex3 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @uf = new.uf;
SET NEW.uf = UPPER(@uf);
END $$
DELIMITER ;

INSERT INTO `cliente` VALUES (1666,'Laura Gomn','99907  Cuba Blvd.','Wairek','46877','rs','319999545');

SELECT uf FROM cliente WHERE codcliente = '1666';

DROP TRIGGER Ex3;

USE compubras;










/4) Faça um gatilho que somente permita cadastrar ie de clientes com 9 a 11 caracteres./

DELIMITER $$
CREATE TRIGGER Ex4 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
set @n = new.nome;
IF(length(@n) >=9 AND length(@n)<=11)
THEN
set new.nome = @n ;
ELSE
set new.nome = NULL;
END IF;
END$$
DELIMITER ;

DROP TRIGGER Ex4;

INSERT INTO `cliente` VALUES (1599,'La Gomena','95097  Cuba Blvd.','Wirrek','46876','SC','318589545');







/*5) Faça um gatilho que só permita que o cliente se cadastre caso o cliente tenha nascido no estado
que está cadastrando. Para isso verifique o nono dígito do ie e a UF, da seguinte forma: 1 (DF-GOMS-MT-TO), 2 (AC-AM-AP-PA-RO-RR), 3 (CE-MA-PI), 4 (AL-PB-PE-RN), 5 (BA-SE), 6
(MG), 7 (ES-RJ), 8 (SP), 9 (PR-SC) e 0 (RS).*/

DELIMITER $$
CREATE TRIGGER Ex5 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @uf = new.Uf;
SET @ie = new.Ie;
IF(substring(@ie, 9, 1)=1 AND (@uf != 'DF' AND @uf != 'GO' AND @uf != 'MS' AND @uf != 'MT' AND @uf != 'TO' ))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=2 AND (@uf != 'AC' AND @uf != 'AM' AND @uf != 'AP' AND @uf != 'PA' AND @uf != 'RO' AND @uf != 'RR' ))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=3 AND (@uf != 'CE' AND @uf != 'MA' AND @uf != 'PI'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=4 AND (@uf != 'AL' AND @uf != 'PB' AND @uf != 'PE' AND @uf != 'RN'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=5 AND (@uf != 'BA' AND @uf != 'SE'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=6 AND (@uf != 'MG'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=7 AND (@uf != 'ES' AND @uf != 'RJ'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=8 AND (@uf != 'SP'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=9 AND (@uf != 'PR' AND @uf != 'SC'))
THEN SET new.Uf = NULL;
END IF;
IF(substring(@ie, 9, 1)=0 AND (@uf != 'RS'))
THEN SET new.Uf = NULL;
END IF;
END$$
DELIMITER ;
 
 
  DROP TRIGGER Ex5;
 
INSERT INTO `cliente` VALUES (1602,'La Gomena','95097  Cuba Blvd.','Wirrek','46876','RS','318589541');







/6) Faça um gatilho que só permita que o vendedor tenha uma faixa de comissão entre A e D./

DELIMITER $$
CREATE TRIGGER Ex6 BEFORE INSERT ON vendedor
FOR EACH ROW
BEGIN
SET @fc = new.faixaComissao;
IF(@fc != 'A' AND @fc !='B'AND @fc !='C'AND @fc !='D')
THEN set new.faixaComissao = NULL;
END IF;
END $$
DELIMITER ;

INSERT INTO `vendedor` VALUES (1900,'Amayi Christensen',1000.00,'E');

SELECT FaixaComissao FROM vendedor;







/*7) Faça um gatilho que não permita cadastrar um prazo de entrega com data menor que a data do
pedido.*/

DELIMITER $$
CREATE TRIGGER Ex7 BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
SET @pe = new.prazoEntrega;
SET @dp = new.dataPedido;
IF(datediff(@dp , @pe) < 0)
THEN SET new.prazoEntrega = NULL;
END IF;
END$$
DELIMITER ;

DROP TRIGGER Ex7;

INSERT INTO `pedido` VALUES (10000,'2013-05-03','2013-04-03',347,158);









/8) Faça um gatilho que não permita criar um itempedido com quantidade igual ou menor que zero./

DELIMITER $$
CREATE TRIGGER Ex8 BEFORE INSERT ON itempedido
FOR EACH ROW
BEGIN
SET @q = new.quantidade;
IF(@q <=0)
THEN SET new.quantidade = NULL;
END IF;
END$$
DELIMITER ;

INSERT INTO `itempedido` VALUES (2300,4906,2592,0);









/9) Faça um gatilho que não permita criar um produto com valor unitário negativo./

DELIMITER $$
CREATE TRIGGER Ex9 BEFORE INSERT ON produto
FOR each row
BEGIN
SET @vu = new.valorUnitario;
IF(@vu < 0)
THEN SET NEW.valorUnitario = NULL;
END IF;
END$$
DELIMITER ;

INSERT INTO `produto` VALUES (5001,'ASPIRADOR DE PO HLD P/TECLADO FD-368',-1);






/10) Faça um gatilho que não permita que a descrição de um produto seja somente um espaço./

DELIMITER $$
CREATE TRIGGER Ex10 BEFORE INSERT ON produto
FOR EACH ROW
BEGIN
SET @d = new.descricao;
IF(@d = ' ')
THEN SET new.descricao = NULL;
END IF;
END$$
DELIMITER ;

INSERT INTO `produto` VALUES (5002,' ',3);

DROP TRIGGER Ex10;