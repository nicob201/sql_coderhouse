DROP DATABASE IF EXISTS tienda_online;
DROP ROLE IF EXISTS 'ROL_COMPRAS'@'LOCALHOST';
DROP ROLE IF EXISTS 'ROL_VENTAS'@'LOCALHOST';
DROP USER IF EXISTS 'USR_COMPRAS1'@'LOCALHOST';
DROP USER IF EXISTS 'USR_COMPRAS2'@'LOCALHOST';
DROP USER IF EXISTS 'USR_VENTAS1'@'LOCALHOST';
CREATE DATABASE tienda_online;
USE tienda_online;

-- ///////////////////////////////////////////////
--              CREACION DE TABLAS
-- //////////////////////////////////////////////

-- Tabla tienda_online.proveedores
CREATE TABLE tienda_online.proveedores (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NULL,
  cuit VARCHAR(45) NULL,
  email VARCHAR(50) NULL DEFAULT 'N/A',
  telefono VARCHAR(45) NULL,
  direccion VARCHAR(45) NULL
  );

-- Tabla tienda_online.categorias
CREATE TABLE tienda_online.categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL
  );

-- Table tienda_online.provincias
CREATE TABLE tienda_online.provincias (
  id_provincia INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL
  );

-- Table tienda_online.ciudades
CREATE TABLE IF NOT EXISTS tienda_online.ciudades (
  id_ciudad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  CP VARCHAR(10) NOT NULL,
  fk_id_provincia INT NULL,
  FOREIGN KEY (fk_id_provincia) REFERENCES tienda_online.provincias (id_provincia) ON DELETE RESTRICT ON UPDATE CASCADE
  );

-- Tabla tienda_online.clientes
CREATE TABLE tienda_online.clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) default 'N/A',
  telefono VARCHAR(45) default 'N/A',
  email VARCHAR(50) default 'N/A',
  fk_id_ciudad INT NULL,
  FOREIGN KEY (fk_id_ciudad) REFERENCES tienda_online.ciudades (id_ciudad) ON UPDATE CASCADE ON DELETE CASCADE
  );
  
-- Tabla tienda_online.productos
CREATE TABLE tienda_online.productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  descripcion VARCHAR(256) NULL,
  fk_id_proveedor INT NULL,
  fk_id_categoria INT NULL,
  FOREIGN KEY (fk_id_proveedor) REFERENCES tienda_online.proveedores (id_proveedor) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (fk_id_categoria) REFERENCES tienda_online.categorias (id_categoria) ON UPDATE CASCADE ON DELETE CASCADE
  );
  
-- Tabla tienda_online.ordenes_de_compra
CREATE TABLE tienda_online.ordenes_de_compra (
  id_orden INT AUTO_INCREMENT PRIMARY KEY,
  numero_orden INT NOT NULL,
  fecha_orden DATETIME NOT NULL,
  estado_orden VARCHAR(45) NOT NULL,
  fk_id_cliente INT NULL,
  fk_id_producto INT NULL,
  cantidad INT NOT NULL,
  precio INT NOT NULL,
  FOREIGN KEY (fk_id_cliente) REFERENCES tienda_online.clientes (id_cliente) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (fk_id_producto) REFERENCES tienda_online.productos (id_producto) ON UPDATE CASCADE ON DELETE CASCADE
  );

-- Tabla tienda_online.facturas
CREATE TABLE tienda_online.facturas (
  id_factura INT AUTO_INCREMENT PRIMARY KEY,
  numero_factura VARCHAR(45) NOT NULL,
  fecha_factura DATETIME NOT NULL,
  fk_id_cliente INT NULL,
  fk_id_orden INT NULL,
  FOREIGN KEY (fk_id_cliente) REFERENCES tienda_online.clientes (id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (fk_id_orden) REFERENCES tienda_online.ordenes_de_compra (id_orden) ON UPDATE CASCADE ON DELETE RESTRICT
  );

-- Tabla tienda_online.ventas
CREATE TABLE tienda_online.ventas (
  id_venta INT AUTO_INCREMENT PRIMARY KEY,
  fk_id_orden INT NULL,
  FOREIGN KEY (fk_id_orden) REFERENCES tienda_online.ordenes_de_compra (id_orden) ON UPDATE CASCADE ON DELETE CASCADE
  );

-- Tabla tienda_online.stock
CREATE TABLE tienda_online.stock (
  id_stock INT AUTO_INCREMENT PRIMARY KEY,
  fk_id_producto INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (fk_id_producto) REFERENCES tienda_online.productos (id_producto) ON UPDATE CASCADE ON DELETE CASCADE
  );

-- Tabla tienda_online.compras
CREATE TABLE tienda_online.compras (
  id_compra INT AUTO_INCREMENT PRIMARY KEY,
  fk_id_producto INT NOT NULL,
  fk_id_proveedor INT NOT NULL,
  precio INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario INT NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (fk_id_producto) REFERENCES tienda_online.productos (id_producto),
  FOREIGN KEY (fk_id_proveedor) REFERENCES tienda_online.proveedores (id_proveedor)
  );


-- ///////////////////////////////////////////////
--                   INSERTS
-- //////////////////////////////////////////////

INSERT INTO tienda_online.categorias (id_categoria, nombre) 
VALUES  (0001, 'Procesadores'),
		(0002, 'Ram'),
		(0003, 'Almacenamiento'),
		(0004, 'Motherboards'),
		(0005, 'GPUs'),
		(0006, 'Monitores');

INSERT INTO tienda_online.provincias (id_provincia, nombre) 
VALUES  (1, 'Cordoba'),
		(2, 'Buenos Aires'),
		(3, 'Santa Fe'),
		(4, 'Mendoza'),
		(5, 'San Luis'),
        (6, 'Chubut'),
        (7, 'Jujuy');

INSERT INTO tienda_online.ciudades (id_ciudad, nombre, CP, fk_id_provincia) 
VALUES  (001, 'Cordoba', '13234', 1),
		(002, 'Rio Cuarto', '32156', 1),
		(003, 'Colonia Caroya', '32165', 1),
		(004, 'Mar del Plata', '89796', 2),
		(005, 'La Plata', '99876', 2),
		(006, 'Mendoza', '98765', 4),
		(007, 'Santa Fe', '33216', 3),
		(008, 'Rosario', '65483', 3),
		(009, 'Trelew', '32143', 6),
		(010, 'Punilla', '75315', 1),
		(011, 'Unquillo', '95143', 1),
		(012, 'La Quiaca', '65497', 7),
		(013, 'Bahia Blanca', '35735', 2),
		(014, 'Merlo', '03513', 5),
		(015, 'Laboulaye', '34376', 1);

INSERT INTO tienda_online.clientes (id_cliente, nombre, apellido, direccion, telefono, email, fk_id_ciudad) 
VALUES  (01, 'Leo', 'Messi', 'Calle 1', '0303453', 'leomessi@elmail.com', 001),
		(02, 'Pipa', 'Higuain', 'Calle 2', '0303454', 'pipita@elmail.com', 010),
		(03, 'Roman', 'Riquelme', 'Calle 3', '0303455', 'roman@elmail.com', 001),
		(04, 'Zlatan', 'Ibrahimovic', 'Calle 4', '0303456', 'zlatan@elmail.com', 011),
		(05, 'Walter', 'Samuel', 'Calle 5', '0303457', 'walter@elmail.com', 003),
		(06, 'Sergio', 'Agüero', 'Calle 6', '0303458', 'sergio@elmail.com', 013),
		(07, 'Sebastian', 'Veron', 'Calle 7', '0303459', 'seba@elmail.com', 001),
		(08, 'Javier', 'Mascherano', 'Calle 8', '0303460', 'javi@elmail.com', 001),
		(09, 'Angel', 'Di Maria', 'Calle 9', '0303461', 'fideo@elmail.com', 005),
		(10, 'Giovanni', 'Lo Celso', 'Calle 10', '0303462', 'gio@elmail.com', 015),
		(11, 'Dario', 'Benedetto', 'Calle 11', '0303463', 'pipa@elmail.com', 006),
		(12, 'Zinedine', 'Zidane', 'Calle 12', '0303464', 'zidane@elmail.com', 010),
		(13, 'Andres', 'Iniesta', 'Calle 13', '0303465', 'andres@elmail.com', 007),
		(14, 'Carles', 'Puyol', 'Calle 14', '0303466', 'carles@elmail.com', 012),
		(15, 'Lionel', 'Scaloni', 'Calle 15', '0303467', 'scaloni@elmail.com', 013);

INSERT INTO tienda_online.proveedores (id_proveedor, nombre, cuit, email, telefono, direccion) 
VALUES  (1, 'Insumos SA', '123456789', 'aaabbb@gmail.com', '13265465', 'Calle A 1589'),
		(2, 'Mouse SRL', '101112131', 'cccddd@gmail.com', '63514654', 'Av A 963'),
		(3, 'Telefonos SRL', '415161718', 'eeefff@gmail.com', '24135665', 'Av B 78'),
		(4, 'Provedoor SA', '192021222', 'ggghhh@yaho.com', '32156481', 'Calle X 123'),
		(5, 'Computer', '324252627', 'iiijjj@gmail.com', '32165845', 'Calle B 458'),
		(6, 'Logitech', '282930313', 'kkkllll@hotmail.com', '65468432', 'Calle P 786'),
		(7, 'Kingston', '323334353', 'mmmnnn@outlook.com', '65165462', 'Calle I 714'),
		(8, 'AMD', '637383940', 'oooppp@outlook.com', '68543298', 'Calle C 9877'),
		(9, 'Intel', '414243444', 'qqqrrr@gmail.com', '89879530', 'Av D 7314'),
		(10, 'Lenovo', '546474849', 'sssttt@hotmail.com', '58792435', 'Calle G 2323'),
		(11, 'Asus', '505152535', 'uuuvvv@hotmail.com', '56188932', 'Calle F 5656'),
		(12, 'Philips', '455565758', 'wwwxxx@outlook.com', '12546325', 'Calle D 453'),
		(13, 'LG', '596061626', 'yyyzzz@outlook.com', '37856985', 'Av F 4369'),
		(14, 'Nvidia', '636465666', 'abc1@gmail.com', '32156987', 'Calle T 8989'),
		(15, 'Sony', '768697071', 'def1@hotmail.com', '98763254', 'Calle R 7474');
        
INSERT INTO tienda_online.productos (id_producto, nombre, precio, descripcion, fk_id_proveedor, fk_id_categoria) 
VALUES  (1, 'AMD Ryzen 5 3600', '28000', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor', 1, 0001),
		(2, 'AMD Ryzen 3 2100', '7000', 'Cum sociis natoque penatibus et magnis dis parturient montes', 1, 0001),
		(3, 'Ram ddr4 3000', '2500', 'Donec quam felis, ultricies nec, pellentesque eu', 11, 0002),
		(4, 'Ram ddr4 3200', '27500', 'Nulla consequat massa quis enim', 5, 0002),
		(5, 'Ram ddr4 1200', '15000', 'Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu', 5, 0002),
		(6, 'Intel i9 11900', '33000', 'In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo', 9, 0001),
		(7, 'Disco SSD 480gb', '23000', 'Nullam dictum felis eu pede mollis pretium', 12, 0003),
		(8, 'Seagate 2TB', '34000', 'Integer tincidunt', 2, 0003),
		(9, 'MSI a320', '1800', 'Vivamus elementum semper nisi', 7, 0004),
		(10, 'AsRock 580', '25000', 'Aenean vulputate eleifend tellus', 13, 0004),
		(11, 'H310m', '99000', 'Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim', 15, 0004),
		(12, 'Geforce 1660 Super', '37000', 'Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus', 4, 0005),
		(13, 'RX 5600 XT', '45000', 'Phasellus viverra nulla ut metus varius laoreet', 8, 0005),
		(14, 'Asus 22', '28000', 'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue', 14, 0006),
		(15, 'Samsung 27', '24000', 'Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus', 3, 0006);

INSERT INTO tienda_online.stock (id_stock, fk_id_producto, cantidad) 
VALUES  (1, 5, 5),
		(2, 7, 41),
		(3, 2, 22),
		(4, 13, 15),
		(5, 3, 2),
		(6, 15, 13),
		(7, 9, 15),
		(8, 11, 20),
		(9, 8, 30),
		(10, 12, 10);

INSERT INTO tienda_online.compras (id_compra, fk_id_producto, fk_id_proveedor, precio, cantidad, precio_unitario, fecha) 
VALUES  (1, 5, 8, 60000, 2, 30000, '2022-01-20'),
		(2, 10, 5, 150000, 5, 30000, '2022-04-18'),
		(3, 4, 2, 300000, 10, 30000, '2022-04-11'),
		(4, 3, 7, 500000, 20, 13000, '2022-02-22'),
		(5, 1, 14, 75000, 3, 25000, '2022-07-09'),
		(6, 15, 1, 85000, 4, 21250, '2022-08-17'),
		(7, 7, 9, 45000, 2, 22500, '2022-08-08'),
		(8, 5, 6, 20000, 1, 20000, '2022-01-17'),
		(9, 12, 15, 250000, 10, 25000, '2022-04-15'),
		(10, 3, 11, 650000, 50, 25000, '2021-09-23'),
		(11, 9, 5, 90000, 1, 90000, '2021-10-10'),
		(12, 11, 9, 80000, 2, 40000, '2022-01-15'),
		(13, 2, 10, 6000, 1, 6000, '2022-02-12'),
		(14, 3, 13, 2000, 1, 2000, '2022-03-02'),
		(15, 7, 13, 15000, 10, 1500, '2022-01-27');

INSERT INTO tienda_online.ordenes_de_compra (id_orden, numero_orden, fecha_orden, estado_orden, fk_id_cliente, fk_id_producto, cantidad, precio) 
VALUES  (1, 1111, '2022-03-05', 'Entregado', 05, 13, 1, 25000),
		(2, 1122, '2022-02-09', 'Entregado', 07, 05, 5, 5000),
		(3, 1133, '2022-03-21', 'Pendiente Pago', 03, 03, 20, 32000),
		(4, 1144, '2022-03-19', 'Entregado', 01, 11, 2, 7500),
		(5, 1155, '2022-01-07', 'Pendiente Pago', 09, 15, 3, 10000),
		(6, 1166, '2022-03-26', 'Confirmada', 11, 01, 13, 21000),
		(7, 1177, '2022-02-08', 'Entregado', 13, 01, 10, 50000),
		(8, 1188, '2022-02-19', 'Entregado', 15, 02, 5, 15000),
		(9, 1199, '2022-02-10', 'Confirmada', 02, 05, 1, 2500),
		(10, 2222, '2022-02-20', 'Entregado', 04, 09, 2, 4200),
		(11, 2233, '2022-03-19', 'Confirmada', 06, 10, 10, 40000),
		(12, 2244, '2022-05-03', 'Confirmada', 08, 05, 5, 22000),
		(13, 2255, '2022-04-04', 'Entregado', 10, 11, 15, 11000),
		(14, 2266, '2022-04-13', 'Pendiente Pago', 12, 13, 1, 10500),
		(15, 2277, '2022-01-24', 'Pendiente Pago', 14, 13, 5, 8200);

INSERT INTO tienda_online.facturas (id_factura, numero_factura, fecha_factura, fk_id_cliente, fk_id_orden) 
VALUES  (1, 'C0001-0001', '2022-02-23', 05, 1),
		(2, 'A0001-0002', '2022-01-20', 06, 3),
		(3, 'A0001-0003', '2022-02-02', 07, 5),
		(4, 'C0001-0004', '2022-03-28', 08, 7),
		(5, 'B0001-0005', '2022-01-06', 09, 9),
		(6, 'A0001-0006', '2022-03-13', 01, 11),
		(7, 'B0001-0007', '2022-01-26', 02, 13),
		(8, 'C0001-0008', '2022-01-27', 03, 15),
		(9, 'C0001-0009', '2022-05-03', 04, 2),
		(10, 'C0001-0010', '2022-03-08', 05, 4),
		(11, 'A0001-0011', '2022-01-19', 12, 6),
		(12, 'B0001-0012', '2022-04-24', 13, 8),
		(13, 'B0001-0013', '2022-04-11', 14, 10),
		(14, 'A0001-0014', '2022-05-04', 15, 12),
		(15, 'C0001-0015', '2022-01-08', 11, 14);
        
INSERT INTO tienda_online.ventas (id_venta, fk_id_orden) 
VALUES  (1, 15),
		(2, 14),
		(3, 13),
		(4, 12),
		(5, 11),
		(6, 1),
		(7, 2),
		(8, 3),
		(9, 4),
		(10, 5);

-- ///////////////////////////////////////////////
--                   VISTAS
-- //////////////////////////////////////////////

-- Vista que indica el total de compras realizadas a por cada cliente, ordenadas de forma descendente
CREATE VIEW compras_por_cliente AS
    SELECT 
        CONCAT(nombre, ' ', apellido) AS nombre_cliente, total
    FROM
        clientes
            INNER JOIN
        (SELECT 
            fk_id_cliente, SUM(cantidad * precio) AS total
        FROM
            ordenes_de_compra
        GROUP BY fk_id_cliente) AS cli ON clientes.id_cliente = cli.fk_id_cliente
    ORDER BY total DESC;
    
-- Query para ejercutar ejemplo de la Vista "compras_por_cliente":
-- SELECT * FROM compras_por_cliente;


-- Vista para unir tabla 'ordenes de compra' con tabla 'productos' donde conincide el nº de id de producto, nos permite ver que producto se compra en cada orden
CREATE VIEW productos_por_orden AS
    SELECT 
        ordenes_de_compra.numero_orden AS numero_de_orden,
        productos.nombre AS producto_comprado,
        productos.precio AS precio
    FROM
        ordenes_de_compra
            LEFT JOIN
        productos ON ordenes_de_compra.fk_id_producto = productos.id_producto
    ORDER BY numero_de_orden DESC;
    
-- Query para ejercutar ejemplo de la Vista "productos_por_orden":
-- SELECT * FROM productos_por_orden;


-- Vista para indicar cantidad total de productos por categoria de producto
CREATE VIEW productos_por_categoria AS
    SELECT 
        categorias.nombre as Categoria, COUNT(productos.fk_id_categoria) as Cantidad_Total
    FROM
        productos
            INNER JOIN
        categorias ON categorias.id_categoria = productos.fk_id_categoria
    GROUP BY categorias.nombre;
    
-- Query para ejercutar ejemplo de la Vista "productos_por_categoria":
-- SELECT * FROM productos_por_categoria;
    
    
-- Vista que indica la cantidad de ordenes por estado de cada una
CREATE VIEW cantidad_ordenes_por_estado AS
    SELECT 
        estado_orden, COUNT(id_orden) AS Cantidad_de_ordenes
    FROM
        ordenes_de_compra
    GROUP BY estado_orden;
    
-- Query para ejercutar ejemplo de la Vista "cantidad_ordenes_por_estado":
-- SELECT * FROM cantidad_ordenes_por_estado;
    

-- Vista que indica el total de compras realizadas a cada proveedor, ordenadas de forma descendente
CREATE VIEW compras_por_prov AS
    SELECT 
        nombre, total
    FROM
        proveedores
            INNER JOIN
        (SELECT 
            fk_id_proveedor, SUM(precio * cantidad) AS total
        FROM
            compras
        GROUP BY fk_id_proveedor) AS prov ON proveedores.id_proveedor = prov.fk_id_proveedor
    ORDER BY total DESC;
    
-- Query para ejercutar ejemplo de la Vista "compras_por_prov":
-- SELECT * FROM compras_por_prov;
    
    
-- Vista que indica el promedio de ventas por estado de cada orden de compra
CREATE VIEW prom_por_estado_orden AS
    SELECT 
        AVG(precio * cantidad) AS promedio_ventas, estado_orden
    FROM
        ordenes_de_compra
    GROUP BY estado_orden;
    
-- Query para ejercutar ejemplo de la Vista "prom_por_estado_orden":
-- SELECT * FROM prom_por_estado_orden;
    
    
-- ///////////////////////////////////////////////
--                   FUNCIONES
-- //////////////////////////////////////////////

-- Funcion que indica el total de la orden de compra, ingresando el nº de orden (ver columna "numero_de_orden" tabla "ordenes_de_compra")
delimiter ##
CREATE FUNCTION monto_orden (num_orden INT)
RETURNS VARCHAR(250)
READS SQL DATA
BEGIN
    DECLARE n_orden INT;
    
    SELECT (cantidad * precio) INTO n_orden FROM tienda_online.ordenes_de_compra WHERE numero_orden = num_orden;
    
    RETURN n_orden;
END ##
delimiter ;
/* -- Query para ejercutar ejemplo de la Funcion "monto_orden":
SELECT monto_orden (1111);
SELECT monto_orden (1166);
SELECT monto_orden (2222);
*/


-- Funcion que calcula el beneficio que deja cada producto, ingresando como parámetros el costo (tabla "compras" columna "precio unitario") y el precio de venta (tabla "productos" columna "precio")
delimiter ##
CREATE FUNCTION beneficio_por_producto (costo INT, precio_venta INT)
RETURNS DECIMAL (10,2)
READS SQL DATA
BEGIN
	DECLARE beneficio DECIMAL(10,2);

	SET beneficio = (precio_venta - costo);

	RETURN beneficio;
END ##
delimiter ;
/* -- Query para ejercutar ejemplo de la Funcion "beneficio_por_producto":
SELECT beneficio_por_producto (22500, 23000);
SELECT beneficio_por_producto (13000, 24500);
SELECT beneficio_por_producto (6000, 45000);
*/


-- Funcion que indica Nombre y Apellido del cliente ingresando como parámetro el id (tabla "clientes" columna "id_cliente")
delimiter ##
CREATE FUNCTION nombre_cliente (id_del_cliente INT)
RETURNS VARCHAR(45)
READS SQL DATA
BEGIN
	DECLARE nombre VARCHAR(45);
    
	SELECT CONCAT(clientes.nombre,' ',clientes.apellido) INTO nombre FROM tienda_online.clientes WHERE id_cliente = id_del_cliente;

	RETURN nombre;
END##
delimiter ;
/* -- Query para ejercutar ejemplo de la Funcion "nombre_cliente":
SELECT nombre_cliente (1);
SELECT nombre_cliente (3);
SELECT nombre_cliente (6);
*/


-- Funcion que devuelve la cantidad de clientes que hay de acuerdo a la ciudad indicada como parámetro
delimiter ##
CREATE FUNCTION clientes_por_ciudad (ciudad_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE cant_cli INT;
    
    SELECT COUNT(id_cliente) INTO cant_cli FROM tienda_online.clientes WHERE fk_id_ciudad = ciudad_id;
    
    RETURN cant_cli;
END ##
delimiter ;
/* -- Query para ejercutar ejemplo de la Funcion "clientes_por_ciudad":
SELECT clientes_por_ciudad (10);
SELECT clientes_por_ciudad (1);
SELECT clientes_por_ciudad (3);
*/


-- ///////////////////////////////////////////////
--               STORED PROCEDURES
-- //////////////////////////////////////////////

-- Stored Procedure que devuelve el id del ultimo proveedor
delimiter ##
CREATE PROCEDURE sp_ultimo_proveedor (OUT num_proveedor INT)
BEGIN
    SELECT MAX(id_proveedor) INTO num_proveedor FROM tienda_online.proveedores;
END##
delimiter ;
/* -- Query para ejercutar ejemplo de SP "sp_ultimo_proveedor":
CALL sp_ultimo_proveedor(@ultimo_proveedor);
SELECT @ultimo_proveedor;
*/


-- Stored Procedure para crear un nuevo proveedor ingresando los datos
delimiter ##
CREATE PROCEDURE sp_generar_proveedor(
	prov_nombre VARCHAR (45),
	prov_cuit VARCHAR (45),
	prov_email VARCHAR (50),
	prov_telefono VARCHAR (45),
	prov_direccion VARCHAR (45)
)
BEGIN 
	DECLARE id INT;
	CALL sp_ultimo_proveedor(id);
    SET id = id + 1;
	INSERT INTO tienda_online.proveedores VALUES (id, prov_nombre, prov_cuit, prov_email, prov_telefono, prov_direccion);
    SELECT 'PROVEEDOR AGREGADO CON EXITO';
END##
delimiter ;
/* -- Query para ejercutar ejemplo de SP "sp_generar_proveedor", creando el registro 16 y 17 en la tabla proveedores:
CALL sp_generar_proveedor ('CompraGamer', '333245875', 'compra@gamer.com', '35123788', 'Calle 28');
CALL sp_generar_proveedor ('PCMaster', '873243355', 'pc@master.com', '35255879', 'Av. 35');
SELECT * FROM proveedores ORDER BY id_proveedor DESC;
*/


-- Stored Procedure para ordenar la tabla productos por precio o nombre DESC
delimiter ##
CREATE PROCEDURE sp_ordenar_productos(
	columna VARCHAR(45),
	orden INT
)
BEGIN
	DECLARE query_select VARCHAR (250);
    DECLARE ordenado VARCHAR (10);
    DECLARE query_armado VARCHAR (250);
    SET query_select = 'SELECT nombre, precio, descripcion FROM tienda_online.productos ';
    
    IF orden = '0' THEN 
		SET ordenado = ' asc;';
    ELSE
		SET ordenado = ' desc;';
	END IF;
    
    IF columna = '' THEN
		SELECT 'Se debe indicar la columna por la cual ordenar';
	ELSE 
		SELECT CONCAT(query_select,'ORDER BY',' ',columna,' ',ordenado) INTO query_armado;
	
		SET @query_ordenador = query_armado;
		PREPARE STOREPROCEDURE FROM @query_ordenador;
		EXECUTE STOREPROCEDURE;
		DEALLOCATE PREPARE STOREPROCEDURE;
	END IF;
END##
delimiter ;
-- Query para ejercutar ejemplo de SP "sp_ordenar_productos", CALL 1 ordena desc por precio, CALL 2 ordena desc por nombre:
-- CALL sp_ordenar_productos('precio', 1);
-- CALL sp_ordenar_productos('nombre', 1);


-- Stored Procedure que devuelve el id del ultimo cliente
delimiter ##
CREATE PROCEDURE sp_ultimo_cliente (OUT num_cliente INT)
BEGIN
    SELECT MAX(id_cliente) INTO num_cliente FROM tienda_online.clientes;
END##
delimiter ;
/* -- Query para ejercutar ejemplo de SP "sp_ultimo_cliente":
CALL sp_ultimo_cliente(@ultimo_cliente);
SELECT @ultimo_cliente;
*/


-- Stored Procedure para crear un nuevo cliente ingresando los datos del mismo
delimiter ##
CREATE PROCEDURE sp_generar_cliente(
	cli_nombre VARCHAR (45),
	cli_apellido VARCHAR (45),
	cli_direccion VARCHAR (45),
	cli_telefono VARCHAR (45),
	cli_email VARCHAR (45),
    cli_fk_id_ciudad INT
)
BEGIN 
	DECLARE id INT;
	CALL sp_ultimo_cliente(id);
    SET id = id + 1;
	INSERT INTO tienda_online.clientes VALUES (cli_nombre, cli_apellido, cli_direccion, cli_telefono, cli_email, cli_fk_id_ciudad);
    SELECT 'CLIENTE AGREGADO CON EXITO';
END##
delimiter ;
/* -- Query para ejercutar ejemplo de SP "sp_generar_cliente", creando el registro 16 y 17 en la tabla clientes:
CALL sp_generar_cliente ('Charles', 'LeClerc', 'Calle 1487', '0303473', 'chale@elmail.com', 001);
CALL sp_generar_cliente ('Lewis', 'Hamilton', 'Calle 89', '0309653', 'lwh@elmail.com', 003);
SELECT * FROM clientes ORDER BY id_cliente DESC;
*/


-- ///////////////////////////////////////////////
--                   TRIGGERS
-- //////////////////////////////////////////////

-- Query para crear tabla de logs de modificaciones a tabla "proveedores"
CREATE TABLE log_proveedores (
    id_log_prov INT AUTO_INCREMENT PRIMARY KEY,
    tipo_accion VARCHAR(30),
    old_nombre VARCHAR(30),
    new_nombre VARCHAR(30),
    old_email VARCHAR(30),
    new_email VARCHAR(30),
    old_telefono VARCHAR(50),
    new_telefono VARCHAR(50),
    old_direccion VARCHAR(50),
    new_direccion VARCHAR(50),
    log_time TIMESTAMP,
    user_log VARCHAR(50)
);


-- Trigger BEFORE UPDATE en tabla proveedores, registra en la tabla "log_proveedores" los nuevos cambios junto con los registros viejos y la fecha
delimiter ##
CREATE TRIGGER bu_proveedores 
BEFORE UPDATE
ON proveedores FOR EACH ROW
BEGIN
    INSERT INTO log_proveedores 
		VALUES (NULL, 
				'BEFORE UPDATE', 
                old.nombre,
				new.nombre,
				old.email,
				new.email,
				old.telefono,
				new.telefono,
				old.direccion,
				new.direccion,
                CURRENT_TIMESTAMP(),
                CURRENT_USER()
                );
END##
delimiter ;
-- Query para probar Trigger "bu_proveedores" con un UPDATE al proveedor 1 y 5
UPDATE proveedores SET nombre = 'Proveedor_nuevo', email = 'provnuevo@email.com', telefono = '4556363', direccion = 'Calle nueva' WHERE id_proveedor = 1;
UPDATE proveedores SET nombre = 'Proveedor_Nuevo2', email = 'provnuevo222@email.com', telefono = '3877746', direccion = 'Av nueva' WHERE id_proveedor = 5;
-- SELECT * FROM log_proveedores;



-- Query para crear tabla "log_compras" para registrar los insert que se realicen
CREATE TABLE log_compras (
    id_log_com INT AUTO_INCREMENT PRIMARY KEY,
    tipo_accion VARCHAR(30),
    precio INT,
    cantidad INT,
    precio_unit INT,
    log_time TIMESTAMP,
    user_log VARCHAR(50)
);

-- Trigger AFTER INSERT en tabla compras, registra en la tabla "log_compras" los datos insertados junto con la fecha y el usuario que lo hizo
delimiter ##
CREATE TRIGGER ai_compras
AFTER INSERT
ON compras FOR EACH ROW
BEGIN
    INSERT INTO log_compras 
		VALUES (NULL, 
				'AFTER INSERT', 
                NEW.precio,
                NEW.cantidad,
                NEW.precio_unitario,
                CURRENT_TIMESTAMP(),
                CURRENT_USER()
                );
END##
delimiter ;
-- Query para probar Trigger "ai_compras" con un INSERT
INSERT INTO tienda_online.compras VALUES (NULL, 7, 10, '70000', 2, '35000', '2022-03-02');
-- SELECT * FROM log_compras;

-- Trigger AFTER DELETE en tabla proveedores, registra en la tabla "log_proveedores" los datos borrados junto con la fecha y el usuario
delimiter ##
CREATE TRIGGER ad_proveedores
AFTER DELETE
ON proveedores FOR EACH ROW
BEGIN
    INSERT INTO log_proveedores 
		VALUES (NULL, 
				'AFTER DELETE', 
                OLD.nombre, 
                NULL, 
                OLD.email, 
                NULL, 
                OLD.telefono, 
                NULL, 
                OLD.direccion, 
                NULL,
                CURRENT_TIMESTAMP(),
                CURRENT_USER()
                );
END##
delimiter ;
/* -- Query para probar Trigger "ad_proveedores" con un DELETE al proveedor 1 (es necesario borrar las tablas que se relacionan con las FK, borrar en el orden en que están)
1) delete from compras;
2) delete from facturas;
3) delete from ventas;
4) delete from ordenes_de_compra;
5) delete from stock;
6) delete from productos;
DELETE FROM proveedores WHERE id_proveedor = 1;
SELECT * FROM log_proveedores;
*/


-- Trigger BEFORE DELETE que indica mensaje de alerta cuando se quiere eliminar un registro de la tabla "clientes"
delimiter ##
CREATE TRIGGER bd_cliente
BEFORE DELETE
ON clientes FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ACCION NO PERMITIDA';
END##
delimiter ;
-- Query para probar Trigger "bd_cliente"
-- DELETE from clientes where id_cliente = 5;


-- Trigger BEFORE INSERT en tabla productos, verifica que el precio del nuevo producto no sea menor a 0
delimiter ##
CREATE TRIGGER bi_productos
BEFORE INSERT
ON productos FOR EACH ROW
BEGIN    
    IF NEW.precio < 0 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'EL PRECIO NO PUEDE SER MENOR A 0';
	END IF;
END##
delimiter ;
-- Query para probar Trigger "bi_productos" haciendo un insert a la tabla "productos" de un producto con precio menor a 0
-- INSERT INTO tienda_online.productos VALUES (18, 'AMD Ryzen 9 7600', -45000, 'Lorem ipsum', 1, 0001);


-- Trigger BEFORE INSERT en tabla clientes, verifica que el email del nuevo cliente tenga el formato correcto
delimiter ##
CREATE TRIGGER bi_clientes
BEFORE INSERT
ON clientes FOR EACH ROW
BEGIN
    IF (NEW.email NOT LIKE '%@%') THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'EMAIL NO VALIDO';
	END IF;
END##
delimiter ;
-- Query para probar Trigger "bi_clientes" haciendo un insert a la tabla "clientes" con un email incorrecto
-- INSERT INTO tienda_online.clientes VALUES (null, 'Juan', 'Lopez', 'Calle 8', '0303483', 'jlopelmail.com', 001);


-- ///////////////////////////////////////////////
--                ROLES Y USUARIOS
-- //////////////////////////////////////////////

-- Creación de Roles para el área de Compras y Ventas de la empresa
CREATE ROLE 'ROL_COMPRAS'@'LOCALHOST';
CREATE ROLE 'ROL_VENTAS'@'LOCALHOST';

-- Asignación de los permisos al rol de compras sobre las tablas "compras", "proveedores" y "productos"
GRANT SELECT, UPDATE, INSERT ON tienda_online.compras TO 'ROL_COMPRAS'@'LOCALHOST';
GRANT SELECT, UPDATE, INSERT ON tienda_online.proveedores TO 'ROL_COMPRAS'@'LOCALHOST';
GRANT SELECT, UPDATE, INSERT ON tienda_online.productos TO 'ROL_COMPRAS'@'LOCALHOST';

-- Asignación de los permisos de solo lectura al rol de "ventas" sobre todas las tablas de la base de datos
GRANT SELECT ON tienda_online.* TO 'ROL_VENTAS'@'LOCALHOST';

-- Creación de usuarios para el área Compras
CREATE USER 'USR_COMPRAS1'@'LOCALHOST' IDENTIFIED BY 'compras1' DEFAULT ROLE 'ROL_COMPRAS'@'LOCALHOST';
CREATE USER 'USR_COMPRAS2'@'LOCALHOST' IDENTIFIED BY 'compras2' DEFAULT ROLE 'ROL_COMPRAS'@'LOCALHOST';

-- Creación de usuarios para el área Ventas
CREATE USER 'USR_VENTAS1'@'LOCALHOST' IDENTIFIED BY 'ventas1' DEFAULT ROLE 'ROL_VENTAS'@'LOCALHOST';

/* -- Querys para probar permisos del usuario USR_COMPRAS1 o USR_COMPRAS2:
SELECT * FROM proveedores; -- Permitido
SELECT * FROM clientes; -- NO Permitido
INSERT INTO tienda_online.compras VALUES  (null, 5, 8, 60000, 2, 30000, '2022-01-20'); -- Permitido
UPDATE tienda_online.compras SET precio = '11111' WHERE (id_compra = '1'); -- Permitido
DELETE FROM proveedores WHERE id = 1; -- NO Permitido
*/

/* -- Querys para probar permisos del usuario USR_VENTAS1:
SELECT * FROM clientes; -- Permitido
SELECT * FROM ordenes_de_compra; -- Permitido
INSERT INTO tienda_online.proveedores VALUES (NULL, 'Sony2', '478547854', 'de31@hotmail.com', '98798798', 'Calle S 7878'); -- NO Permitido
UPDATE tienda_online.compras SET precio = '11111' WHERE (id_compra = '1'); -- NO Permitido
DELETE FROM clientes WHERE id = 1; -- NO Permitido
*/


-- ///////////////////////////////////////////////
--                 TRANSACCIONES
-- //////////////////////////////////////////////
/*
-- Transaccion para insertar un registro en tabla "productos" y query para eliminar un registro de la tabla "stock"
START TRANSACTION;

INSERT INTO tienda_online.productos	VALUES  (NULL, 'AMD Ryzen 7 5600', 39000, 'Lorem ipsum dolor sit amet', 8, 0001);
DELETE FROM stock WHERE id_stock = 1;
-- SELECT * FROM productos ORDER BY id_producto DESC; -- Se observa el nuevo registro con id_producto = 16
-- SELECT * FROM stock; -- Se observa que no está en la tabla Stock el registro con id = 1

-- Sentencia ROLLBACK para deshacer los cambios anteriores
ROLLBACK;
-- SELECT * FROM productos ORDER BY id_producto DESC; -- La tabla vuelve a tener los 15 registros originales
-- SELECT * FROM stock; -- Aparece nuevamente el registro 1

-- Sentencia COMMIT para confirmar y aplicar los cambios
COMMIT;


-- Transaccion para ingresar muchos registros con SAVEPOINT
START TRANSACTION;
-- Insertar registros en tabla "clientes"
INSERT INTO tienda_online.clientes 
VALUES  (NULL, 'Karim', 'Benzema', 'Calle 99', '0303457', 'karim@elmail.com', 003),
		(NULL, 'Gabriel', 'Jesus', 'Calle 120', '4589457', 'gabi@elmail.com', 003),
        (NULL, 'Cristiano', 'Ronaldo', 'Calle 130', '4589457', 'cr7@elmail.com', 007);
-- SAVEPOINT "LOTE1"
SAVEPOINT LOTE1_INSERT;
-- Control de INSERT realizados a tabla CLIENTES (registros 16, 17 y 18)
-- SELECT * FROM clientes ORDER BY id_cliente DESC;

-- Nuevos registros en tabla CLIENTES
INSERT INTO tienda_online.clientes 
VALUES  (NULL, 'Homero', 'Simpson', 'Siempreviva 123', '4589457', 'hs@elmail.com', 004),
		(NULL, 'Bart', 'Simpson', 'Siempreviva 123', '4589457', 'bs@elmail.com', 004),
		(NULL, 'Luka', 'Modric', 'Calle 110', '034587', 'lika@elmail.com', 005);
-- SAVEPOINT "LOTE2"
SAVEPOINT LOTE2_INSERT;
-- Control de INSERT realizados a tabla "clientes" (registros 19, 20 y 21)
-- SELECT * FROM clientes ORDER BY id_cliente DESC;

-- Al ejecutar este ROLLBACK la tabla posee hasta los registros del SAVEPOINT LOTE1 (registros 16, 17 y 18)
ROLLBACK TO LOTE1_INSERT;
-- SELECT * FROM clientes ORDER BY id_cliente DESC;

-- Borrar el SAVEPOINT LOTE1
RELEASE SAVEPOINT LOTE1_INSERT;

-- Deshace todos los INSERT y deja la tabla "clientes" como al inicio (15 registros)
ROLLBACK;
-- SELECT * FROM clientes ORDER BY id_cliente DESC;

-- Confirmar todos los cambios
COMMIT;
*/