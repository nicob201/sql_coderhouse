insert into cliente
values (12, 'Nicolas', 'Lopez', 27, 'Ri', current_timestamp(), current_timestamp());

insert into cliente (nombre, apellido, edad)
values ('jose', 'chori', 45);

select *
from cliente;

insert into producto (moneda, valor, descripcion)
values  ('ARS', 550.3, 'Chomba'),
		('CLP', 546,'Chomba 2' ),
		('CLP', 56,'Chomba 3' );

select *
from producto
order by 1 desc;
 
 
 
 
-- OTRA CLASE
INSERT INTO PLAY (ID_GAME, ID_SYSTEM_USER, COMPLETED)
    VALUES (
                        ( SELECT ID_GAME FROM GAME WHERE NAME LIKE '%AS%CREE%VAL%' LIMIT 1) 
                    ,   ( SELECT ID_SYSTEM_USER FROM SYSTEM_USER WHERE FIRST_NAME LIKE 'DEB'  LIMIT 1)
                    ,  0
            )
             
             
SELECT * FROM PLAY WHERE ID_GAME = 30 AND ID_SYSTEM_USER = 49


UPDATE EVALUACION_USUARIOS_2 AS T1, (select id_system_user, COUNT(*) AS Q from PLAY where completed = 0 GROUP BY ID_SYSTEM_USER) AS T2
    SET T1.NO_COMPLETADOS = T2.Q
WHERE T1.id_system_user = T2.id_system_user


SELECT * FROM EVALUACION_USUARIOS_2



-- otra clase
ALTER TABLE PERSONAS
    ADD COLUMN EMAIL VARCHAR(100),
    ADD CONSTRAINT FK_PERSONAS_CIUDAD FOREIGN KEY(ID_CIUDAD) REFERENCES CIUDADES (ID_CIUDAD)
        ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CIUDADES
    ADD CONSTRAINT FK_CIUDADES_PAIS FOREIGN KEY(ISO_CODE) REFERENCES PAIS (ISO_CODE)
        ON DELETE CASCADE;
        
        
-- ----------------------
-- CLASE 15
-- ----------------------
DROP DATABASE IF EXISTS CLASE15;
CREATE DATABASE IF NOT EXISTS CLASE15;

USE CLASE15;

CREATE TABLE IF NOT EXISTS PARED (
    ID_PARED INT AUTO_INCREMENT NOT NULL PRIMARY KEY
    , LARGO DECIMAL(6,2) NOT NULL
    , ALTO DECIMAL(6,2) NOT NULL
);

INSERT INTO PARED (LARGO,ALTO)
VALUES (10,10), (2,2), (2,3), (2,4), (3,3), (3,4), (4,4), (2.2,3.85), (3.5,1.7), (6.33,12.8);


delimiter ##
create function suma_2_numeros (n1 int, n2 int)
returns int
deterministic
begin

declare suma_parametros int;
set suma_parametros = n1 + n2;
return suma_parametros;

end ##

delimiter ;

SELECT SUMA_2_NUMEROS(10, 20);


DELIMITER ##
CREATE FUNCTION LITROS_PINTURA (LARGO DECIMAL(10,4), ALTO DECIMAL(10,4),  Q_MANOS INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC 
BEGIN
    DECLARE LITRO_X_METRO DECIMAL(10,4);
    DECLARE LITROS_TOTALES DECIMAL(10,4);
    
    SET LITRO_X_METRO = 0.1;
    SET LITROS_TOTALES = (LARGO * ALTO) * LITRO_X_METRO * Q_MANOS;
    
    RETURN LITROS_TOTALES;

END##

DELIMITER ;


SELECT *
    , LITROS_PINTURA(LARGO, ALTO, 1) L_1_MANO
    , LITROS_PINTURA(LARGO, ALTO, 2) L_2_MANO
    , LITROS_PINTURA(LARGO, ALTO, 3) L_3_MANO
    , LITROS_PINTURA(LARGO, ALTO, 4) L_4_MANO
    , LITROS_PINTURA(LARGO, ALTO, 5) L_5_MANO
 FROM PARED;




delimiter ##
create function get_game(gameId int)
returns varchar(250)
reads sql data
begin
    declare nombre varchar(250);
    
    select name into nombre from gamer.game where id_game = gameId;
    
    return nombre;
end##
delimiter ;



-- ---------------------------------------
--               CLASE 16
-- ---------------------------------------
use gamer;
DELIMITER $$
CREATE PROCEDURE Q_USUARIOS()
BEGIN
    SELECT COUNT(*) FROM SYSTEM_USER;
END$$

DELIMITER ;



drop procedure ULTIMO_USUARIO;
DELIMITER $$
CREATE PROCEDURE ULTIMO_USUARIO(OUT nUser int)
BEGIN                    
    SELECT max(id_system_user) into nUser FROM gamer.SYSTEM_USER;
END$$

DELIMITER ;

call ULTIMO_USUARIO(@ultimo_user);

select @ultimo_user;




use gamer;
DELIMITER $$
CREATE PROCEDURE GENERA_USUARIO(nombre varchar(100), apellido varchar(100), correo varchar(100), contrasenia varchar(25))
BEGIN                    
    DECLARE ID INT;
    CALL ULTIMO_USUARIO(ID);
    SET ID = ID +1;
    
    insert into gamer.system_user values (id, nombre, apellido, correo, contrasenia, 2);

END$$

DELIMITER ;

CALL GENERA_USUARIO (ingresar, parametros)




DELIMITER $$
CREATE PROCEDURE valida_query(query_input varchar(100))
BEGIN                    
    
        if query_input like '%a%' then
            select "El query contiene A" as result;
        ELSEif query_input like '%c%' then
            select "El query contiene C" as result;
        ELSEif query_input like '%;%' then
            select "El query no es valido" as result;
        else
            select * from gamer.system_user;
        end if;

END$$

DELIMITER ;




DELIMITER $$
CREATE PROCEDURE game_ordered(column1 varchar(100), orden int)
BEGIN  
        declare query_base varchar(250);
        declare tipo_orden varchar(10);
        declare query_final varchar(250);
        
        set query_base = 'select name, description from gamer.game ';
        
        if orden = 1 then 
            set tipo_orden = ' asc;';
        else 
            set tipo_orden = ' desc;';
        end if;
        
        if column1 = '' then
            select 'La columna no puede ser vacia';
        else 
            select concat(query_base, ' order by ', column1, ' ', tipo_orden) into query_final;
            
            SET @smtmt = query_final;
            
            PREPARE EJECUTAR FROM @smtmt;
            EXECUTE EJECUTAR;
            deallocate prepare EJECUTAR;
    END IF;
    
END$$
DELIMITER ;


-- ---------------------------------------
--               CLASE 17
-- ---------------------------------------

use gamer;



-- trigger que guarde cambios ante un update
-- la info cambiada se guarda en una tabla de tipo log
create table log_game (
    id_game int,
    changes varchar(250), 
    date_change timestamp
);

-- creamos el trigger de tipo after update
DELIMITER $$
CREATE TRIGGER AU_GAME
AFTER UPDATE
ON GAME FOR EACH ROW
BEGIN
    if (new.description <> old.description or old.name <> new.name) then -- realizar una validacion para evitar que se cree un log si no hay cambios.
        INSERT INTO LOG_GAME VALUES( NEW.ID_GAME,        -- id_game
                                                                    CONCAT('NEW_DESC: ', NEW.DESCRIPTION, ' NEW NAME: ', NEW.NAME, 'OLD DESC: ', OLD.DESCRIPTION, ' OLD NAME :', OLD.NAME ) ,                               -- changes
                                                                    current_timestamp()
                                                                    );
    end if;
END$$

DELIMITER ;

-- validar datos "actuales" en la tabla
select * from game;

-- Ghost Recon: Frontline
-- habitasse

-- realizar un cambio para validar que el trigger funcione correctamente.
update game
set
        name = 'Ghost Recon: Frontline 2.0'
        , description = 'Nueva Version del juego'
where id_game = 66;

-- resultado del update: 1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0

-- revisamos log y nuevo estado del juego...
select * from log_game;

-- NEW_DESC: Nueva Version del juego 2 NEW NAME: Ghost Recon: Frontline 3.0OLD DESC: Nueva Version del juego OLD NAME :Ghost Recon: Frontline 2.0


-- realizar otro update del juego...
update game
set
        name = 'Ghost Recon: Frontline 3.0'
        , description = 'Nueva Version del juego 2'
where id_game = 66;


update game
set
        name = '4'
        , description = '4'
where id_game = 66;

-- resultado del log nuevo:
    NEW_DESC: 4 NEW NAME: 4OLD DESC: Nueva Version del juego 2 OLD NAME :Ghost Recon: Frontline 3.0





-- crear un trigger que nos permita generar un error antes de guardar un registro en la tabla de usuario
delimiter $$
CREATE TRIGGER BI_VALIDA_MAIL_Y_PASS
BEFORE INSERT
ON SYSTEM_USER FOR EACH ROW
BEGIN

    DECLARE MSG_ERR VARCHAR(255);

    IF(NEW.EMAIL NOT LIKE '%@%') THEN -- validacion simple de email
        SET MSG_ERR = 'EL EMAIL NO ES VALIDO';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG_ERR;
    ELSEIF (NEW.PASSWORD NOT LIKE '%1%') THEN -- validacion simple (y mal hecha) de contraseña
        SET MSG_ERR = 'LA CONTRASEÑA NO ES VALIDA';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG_ERR;
    END IF;
END$$
delimiter ;


-- validar el trigger probando las distitnas situaciones
INSERT INTO SYSTEM_USER VALUES (1005, 'MARCOS', 'DARTES', 'ALGO.COM', '982734', 2);

-- Error Code: 1644. EL EMAIL NO ES VALIDO
-- Error Code: 1644. LA CONTRASEÑA NO ES VALIDA
-- Error Code: 1048. Column 'id_system_user' cannot be null

-- crear el trigger pero para que realice todas las validaciones juntas
use gamer;
DROP TRIGGER BI_VALIDA_MAIL_Y_PASS;
delimiter $$
CREATE TRIGGER BI_VALIDA_MAIL_Y_PASS
BEFORE INSERT
ON SYSTEM_USER FOR EACH ROW
BEGIN

    DECLARE MSG_ERR VARCHAR(255);
    SET MSG_ERR = '';


    IF(NEW.EMAIL NOT LIKE '%@%') THEN
        SET MSG_ERR = 'EL EMAIL NO ES VALIDO';
    END IF;

    IF (NEW.PASSWORD NOT LIKE '%1%') THEN
        SET MSG_ERR = CONCAT (MSG_ERR, ' - LA CONTRASEÑA NO ES VALIDA');
    END IF;
    
    IF MSG_ERR <> '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG_ERR;
    END IF;
    
END$$
delimiter ;



INSERT INTO SYSTEM_USER VALUES (1005, 'MARCOS', 'DARTES', 'ALGO.COM', '1982734', 2);
-- Error Code: 1644. EL EMAIL NO ES VALIDO - LA CONTRASEÑA NO ES VALIDA
-- Error Code: 1644. EL EMAIL NO ES VALIDO
-- Error Code: 1644.  - LA CONTRASEÑA NO ES VALIDA





-- DESAFIO GENÉRICO
-- Con la tabla comment del modelo gamers deberás crear dos triggers:
-- Debe detectar la modificación de un registro de la tabla en cuestión, justo antes de que ocurra
-- Debe detectar la eliminación de un registro, registrando también fecha y hora, más el usuario que lo eliminó

-- La tabla de log puede ser un espejo de la tabla elegida o una tabla más simple.


-- CREAR TABLA PARA GUARDAR EL LOG
create table log_comment (
    id_log_comment int auto_increment primary key,
    action varchar(30), 
    id_system_user int, 
    old_f_date datetime,
    new_f_date datetime,
    old_l_date datetime,
    new_l_date datetime, 
    log_time timestamp, 
    USER_LOG VARCHAR(50)
);

-- GENERAR LOG BEFORE UPDATE
delimiter $$
CREATE TRIGGER BU_COMMENT 
BEFORE UPDATE
ON COMMENT FOR EACH ROW
BEGIN
    INSERT INTO log_comment 
		VALUES (NULL, 
				'BEFORE UPDATE', 
                NEW.ID_SYSTEM_USER, 
                OLD.FIRST_DATE, 
                NEW.FIRST_DATE, 
                OLD.LAST_DATE, 
                NEW.LAST_DATE, 
                current_timestamp(), 
                CURRENT_USER());
END$$

-- GENERAR LOG AFTER DELETE
CREATE TRIGGER AD_COMMENT 
AFTER DELETE
ON COMMENT FOR EACH ROW
BEGIN
    INSERT INTO log_comment 
		VALUES (NULL, 
				'AFTER DELETE', 
                NULL, 
                OLD.FIRST_DATE, 
                NULL, 
                OLD.LAST_DATE, 
                NULL, 
                CURRENT_TIMESTAMP(), 
                CURRENT_USER());
END$$

delimiter ;


-- REALIZAR UN UPDATE SOBRE COMMENTARY PARA VALIDAR EL TRIGGER
UPDATE COMMENT 
    SET FIRST_DATE = CURRENT_TIMESTAMP()
WHERE ID_GAME = 1 AND ID_SYSTEM_USER = 294;



-- BORRAR LA TABLA COMMENTARY PARA EVITAR PROBLEMAS DE FK
DELETE FROM COMMENTARY WHERE ID_GAME = 1 AND ID_SYSTEM_USER = 294;
DELETE FROM COMMENT WHERE ID_GAME = 1 AND ID_SYSTEM_USER = 294;

-- VALIDAR QUE LOS CAMBIOS SE HAYAN REALIZADO EN EL LOG.
SELECT * FROM log_comment;




-- ---------------------------------------
--               CLASE 19
-- ---------------------------------------
CREATE USER 'USR_USER1'@'LOCALHOST' IDENTIFIED BY 'sakila';


-- ---------------------------------------
--               CLASE 20
-- ---------------------------------------

select @@autocommit;

set @@autocommit = 0;


-- DEFINIR UNA TRANSACCION

START TRANSACTION;

    INSERT INTO USER_TYPE VALUES(501, 'AMMET 501');

COMMIT;

ROLLBACK;

    SELECT * FROM USER_TYPE ORDER BY ID_USER_TYPE DESC;
    
    
START TRANSACTION;

    INSERT INTO USER_TYPE VALUES(520, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(521, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(522, 'usuario 1 511');
    SAVEPOINT LOTE1;
    
    INSERT INTO USER_TYPE VALUES(523, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(524, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(525, 'usuario 1 511');
    SAVEPOINT LOTE2;
    
    INSERT INTO USER_TYPE VALUES(526, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(527, 'usuario 1 511');
    INSERT INTO USER_TYPE VALUES(528, 'usuario 1 511');
    SAVEPOINT LOTE3;
    

ROLLBACK TO LOTE2;

RELEASE SAVEPOINT LOTE2;
