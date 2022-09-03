/* BACKUP BASE "tienda_online"
Incluye TABLAS: categorias, ciudades, clientes, compras, facturas, log_compras, log_proveedores, ordenes_de_compra, productos, proveedores, provincias, stock, ventas
Incluye STORED PROCEDURES: sp_generar_cliente, sp_generar_proveedor, sp_ordenar_productos, sp_ultimo_cliente, sp_ultimo_proveedor
Incluye FUNCIONES: beneficio_por_producto, clientes_por_ciudad, monto_orden, nombre_cliente
Incluye VISTAS: cantidad_ordenes_por_estado, compras_por_cliente, compras_por_prov, productos_por_categoria, productos_por_orden, prom_por_estado_orden
Incluye TRIGGERS: bi_clientes, ai_compras, bi_productos, bu_proveedores, ad_proveedores
*/
CREATE DATABASE  IF NOT EXISTS `tienda_online` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tienda_online`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tienda_online
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `cantidad_ordenes_por_estado`
--

DROP TABLE IF EXISTS `cantidad_ordenes_por_estado`;
/*!50001 DROP VIEW IF EXISTS `cantidad_ordenes_por_estado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cantidad_ordenes_por_estado` AS SELECT 
 1 AS `estado_orden`,
 1 AS `Cantidad_de_ordenes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Procesadores'),(2,'Ram'),(3,'Almacenamiento'),(4,'Motherboards'),(5,'GPUs'),(6,'Monitores');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudades`
--

DROP TABLE IF EXISTS `ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudades` (
  `id_ciudad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `CP` varchar(10) NOT NULL,
  `fk_id_provincia` int DEFAULT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `fk_id_provincia` (`fk_id_provincia`),
  CONSTRAINT `ciudades_ibfk_1` FOREIGN KEY (`fk_id_provincia`) REFERENCES `provincias` (`id_provincia`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
INSERT INTO `ciudades` VALUES (1,'Cordoba','13234',1),(2,'Rio Cuarto','32156',1),(3,'Colonia Caroya','32165',1),(4,'Mar del Plata','89796',2),(5,'La Plata','99876',2),(6,'Mendoza','98765',4),(7,'Santa Fe','33216',3),(8,'Rosario','65483',3),(9,'Trelew','32143',6),(10,'Punilla','75315',1),(11,'Unquillo','95143',1),(12,'La Quiaca','65497',7),(13,'Bahia Blanca','35735',2),(14,'Merlo','03513',5),(15,'Laboulaye','34376',1);
/*!40000 ALTER TABLE `ciudades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `direccion` varchar(45) DEFAULT 'N/A',
  `telefono` varchar(45) DEFAULT 'N/A',
  `email` varchar(50) DEFAULT 'N/A',
  `fk_id_ciudad` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `fk_id_ciudad` (`fk_id_ciudad`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`fk_id_ciudad`) REFERENCES `ciudades` (`id_ciudad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Leo','Messi','Calle 1','0303453','leomessi@elmail.com',1),(2,'Pipa','Higuain','Calle 2','0303454','pipita@elmail.com',10),(3,'Roman','Riquelme','Calle 3','0303455','roman@elmail.com',1),(4,'Zlatan','Ibrahimovic','Calle 4','0303456','zlatan@elmail.com',11),(5,'Walter','Samuel','Calle 5','0303457','walter@elmail.com',3),(6,'Sergio','Agüero','Calle 6','0303458','sergio@elmail.com',13),(7,'Sebastian','Veron','Calle 7','0303459','seba@elmail.com',1),(8,'Javier','Mascherano','Calle 8','0303460','javi@elmail.com',1),(9,'Angel','Di Maria','Calle 9','0303461','fideo@elmail.com',5),(10,'Giovanni','Lo Celso','Calle 10','0303462','gio@elmail.com',15),(11,'Dario','Benedetto','Calle 11','0303463','pipa@elmail.com',6),(12,'Zinedine','Zidane','Calle 12','0303464','zidane@elmail.com',10),(13,'Andres','Iniesta','Calle 13','0303465','andres@elmail.com',7),(14,'Carles','Puyol','Calle 14','0303466','carles@elmail.com',12),(15,'Lionel','Scaloni','Calle 15','0303467','scaloni@elmail.com',13);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bi_clientes` BEFORE INSERT ON `clientes` FOR EACH ROW BEGIN
    IF (NEW.email NOT LIKE '%@%') THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'EMAIL NO VALIDO';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bd_cliente` BEFORE DELETE ON `clientes` FOR EACH ROW BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ACCION NO PERMITIDA';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `fk_id_producto` int NOT NULL,
  `fk_id_proveedor` int NOT NULL,
  `precio` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` int NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `fk_id_producto` (`fk_id_producto`),
  KEY `fk_id_proveedor` (`fk_id_proveedor`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`fk_id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`fk_id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,5,8,60000,2,30000,'2022-01-20'),(2,10,5,150000,5,30000,'2022-04-18'),(3,4,2,300000,10,30000,'2022-04-11'),(4,3,7,500000,20,13000,'2022-02-22'),(5,1,14,75000,3,25000,'2022-07-09'),(6,15,1,85000,4,21250,'2022-08-17'),(7,7,9,45000,2,22500,'2022-08-08'),(8,5,6,20000,1,20000,'2022-01-17'),(9,12,15,250000,10,25000,'2022-04-15'),(10,3,11,650000,50,25000,'2021-09-23'),(11,9,5,90000,1,90000,'2021-10-10'),(12,11,9,80000,2,40000,'2022-01-15'),(13,2,10,6000,1,6000,'2022-02-12'),(14,3,13,2000,1,2000,'2022-03-02'),(15,7,13,15000,10,1500,'2022-01-27'),(16,7,10,70000,2,35000,'2022-03-02');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ai_compras` AFTER INSERT ON `compras` FOR EACH ROW BEGIN
    INSERT INTO log_compras 
		VALUES (NULL, 
				'AFTER INSERT', 
                NEW.precio,
                NEW.cantidad,
                NEW.precio_unitario,
                CURRENT_TIMESTAMP(),
                CURRENT_USER()
                );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `compras_por_cliente`
--

DROP TABLE IF EXISTS `compras_por_cliente`;
/*!50001 DROP VIEW IF EXISTS `compras_por_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `compras_por_cliente` AS SELECT 
 1 AS `nombre_cliente`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `compras_por_prov`
--

DROP TABLE IF EXISTS `compras_por_prov`;
/*!50001 DROP VIEW IF EXISTS `compras_por_prov`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `compras_por_prov` AS SELECT 
 1 AS `nombre`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(45) NOT NULL,
  `fecha_factura` datetime NOT NULL,
  `fk_id_cliente` int DEFAULT NULL,
  `fk_id_orden` int DEFAULT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `fk_id_cliente` (`fk_id_cliente`),
  KEY `fk_id_orden` (`fk_id_orden`),
  CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`fk_id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `facturas_ibfk_2` FOREIGN KEY (`fk_id_orden`) REFERENCES `ordenes_de_compra` (`id_orden`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,'C0001-0001','2022-02-23 00:00:00',5,1),(2,'A0001-0002','2022-01-20 00:00:00',6,3),(3,'A0001-0003','2022-02-02 00:00:00',7,5),(4,'C0001-0004','2022-03-28 00:00:00',8,7),(5,'B0001-0005','2022-01-06 00:00:00',9,9),(6,'A0001-0006','2022-03-13 00:00:00',1,11),(7,'B0001-0007','2022-01-26 00:00:00',2,13),(8,'C0001-0008','2022-01-27 00:00:00',3,15),(9,'C0001-0009','2022-05-03 00:00:00',4,2),(10,'C0001-0010','2022-03-08 00:00:00',5,4),(11,'A0001-0011','2022-01-19 00:00:00',12,6),(12,'B0001-0012','2022-04-24 00:00:00',13,8),(13,'B0001-0013','2022-04-11 00:00:00',14,10),(14,'A0001-0014','2022-05-04 00:00:00',15,12),(15,'C0001-0015','2022-01-08 00:00:00',11,14);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_compras`
--

DROP TABLE IF EXISTS `log_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_compras` (
  `id_log_com` int NOT NULL AUTO_INCREMENT,
  `tipo_accion` varchar(30) DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unit` int DEFAULT NULL,
  `log_time` timestamp NULL DEFAULT NULL,
  `user_log` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_log_com`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_compras`
--

LOCK TABLES `log_compras` WRITE;
/*!40000 ALTER TABLE `log_compras` DISABLE KEYS */;
INSERT INTO `log_compras` VALUES (1,'AFTER INSERT',70000,2,35000,'2022-06-14 22:31:01','root@localhost');
/*!40000 ALTER TABLE `log_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_proveedores`
--

DROP TABLE IF EXISTS `log_proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_proveedores` (
  `id_log_prov` int NOT NULL AUTO_INCREMENT,
  `tipo_accion` varchar(30) DEFAULT NULL,
  `old_nombre` varchar(30) DEFAULT NULL,
  `new_nombre` varchar(30) DEFAULT NULL,
  `old_email` varchar(30) DEFAULT NULL,
  `new_email` varchar(30) DEFAULT NULL,
  `old_telefono` varchar(50) DEFAULT NULL,
  `new_telefono` varchar(50) DEFAULT NULL,
  `old_direccion` varchar(50) DEFAULT NULL,
  `new_direccion` varchar(50) DEFAULT NULL,
  `log_time` timestamp NULL DEFAULT NULL,
  `user_log` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_log_prov`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_proveedores`
--

LOCK TABLES `log_proveedores` WRITE;
/*!40000 ALTER TABLE `log_proveedores` DISABLE KEYS */;
INSERT INTO `log_proveedores` VALUES (1,'BEFORE UPDATE','Insumos SA','Proveedor_nuevo','aaabbb@gmail.com','provnuevo@email.com','13265465','4556363','Calle A 1589','Calle nueva','2022-06-14 22:31:01','root@localhost'),(2,'BEFORE UPDATE','Computer','Proveedor_Nuevo2','iiijjj@gmail.com','provnuevo222@email.com','32165845','3877746','Calle B 458','Av nueva','2022-06-14 22:31:01','root@localhost');
/*!40000 ALTER TABLE `log_proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_de_compra`
--

DROP TABLE IF EXISTS `ordenes_de_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_de_compra` (
  `id_orden` int NOT NULL AUTO_INCREMENT,
  `numero_orden` int NOT NULL,
  `fecha_orden` datetime NOT NULL,
  `estado_orden` varchar(45) NOT NULL,
  `fk_id_cliente` int DEFAULT NULL,
  `fk_id_producto` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio` int NOT NULL,
  PRIMARY KEY (`id_orden`),
  KEY `fk_id_cliente` (`fk_id_cliente`),
  KEY `fk_id_producto` (`fk_id_producto`),
  CONSTRAINT `ordenes_de_compra_ibfk_1` FOREIGN KEY (`fk_id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_de_compra_ibfk_2` FOREIGN KEY (`fk_id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_de_compra`
--

LOCK TABLES `ordenes_de_compra` WRITE;
/*!40000 ALTER TABLE `ordenes_de_compra` DISABLE KEYS */;
INSERT INTO `ordenes_de_compra` VALUES (1,1111,'2022-03-05 00:00:00','Entregado',5,13,1,25000),(2,1122,'2022-02-09 00:00:00','Entregado',7,5,5,5000),(3,1133,'2022-03-21 00:00:00','Pendiente Pago',3,3,20,32000),(4,1144,'2022-03-19 00:00:00','Entregado',1,11,2,7500),(5,1155,'2022-01-07 00:00:00','Pendiente Pago',9,15,3,10000),(6,1166,'2022-03-26 00:00:00','Confirmada',11,1,13,21000),(7,1177,'2022-02-08 00:00:00','Entregado',13,1,10,50000),(8,1188,'2022-02-19 00:00:00','Entregado',15,2,5,15000),(9,1199,'2022-02-10 00:00:00','Confirmada',2,5,1,2500),(10,2222,'2022-02-20 00:00:00','Entregado',4,9,2,4200),(11,2233,'2022-03-19 00:00:00','Confirmada',6,10,10,40000),(12,2244,'2022-05-03 00:00:00','Confirmada',8,5,5,22000),(13,2255,'2022-04-04 00:00:00','Entregado',10,11,15,11000),(14,2266,'2022-04-13 00:00:00','Pendiente Pago',12,13,1,10500),(15,2277,'2022-01-24 00:00:00','Pendiente Pago',14,13,5,8200);
/*!40000 ALTER TABLE `ordenes_de_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `precio` int NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `fk_id_proveedor` int DEFAULT NULL,
  `fk_id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `fk_id_proveedor` (`fk_id_proveedor`),
  KEY `fk_id_categoria` (`fk_id_categoria`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`fk_id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`fk_id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'AMD Ryzen 5 3600',28000,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor',1,1),(2,'AMD Ryzen 3 2100',7000,'Cum sociis natoque penatibus et magnis dis parturient montes',1,1),(3,'Ram ddr4 3000',2500,'Donec quam felis, ultricies nec, pellentesque eu',11,2),(4,'Ram ddr4 3200',27500,'Nulla consequat massa quis enim',5,2),(5,'Ram ddr4 1200',15000,'Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu',5,2),(6,'Intel i9 11900',33000,'In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo',9,1),(7,'Disco SSD 480gb',23000,'Nullam dictum felis eu pede mollis pretium',12,3),(8,'Seagate 2TB',34000,'Integer tincidunt',2,3),(9,'MSI a320',1800,'Vivamus elementum semper nisi',7,4),(10,'AsRock 580',25000,'Aenean vulputate eleifend tellus',13,4),(11,'H310m',99000,'Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim',15,4),(12,'Geforce 1660 Super',37000,'Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus',4,5),(13,'RX 5600 XT',45000,'Phasellus viverra nulla ut metus varius laoreet',8,5),(14,'Asus 22',28000,'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue',14,6),(15,'Samsung 27',24000,'Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus',3,6);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bi_productos` BEFORE INSERT ON `productos` FOR EACH ROW BEGIN    
    IF NEW.precio < 0 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'EL PRECIO NO PUEDE SER MENOR A 0';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `productos_por_categoria`
--

DROP TABLE IF EXISTS `productos_por_categoria`;
/*!50001 DROP VIEW IF EXISTS `productos_por_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `productos_por_categoria` AS SELECT 
 1 AS `Categoria`,
 1 AS `Cantidad_Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `productos_por_orden`
--

DROP TABLE IF EXISTS `productos_por_orden`;
/*!50001 DROP VIEW IF EXISTS `productos_por_orden`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `productos_por_orden` AS SELECT 
 1 AS `numero_de_orden`,
 1 AS `producto_comprado`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `prom_por_estado_orden`
--

DROP TABLE IF EXISTS `prom_por_estado_orden`;
/*!50001 DROP VIEW IF EXISTS `prom_por_estado_orden`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `prom_por_estado_orden` AS SELECT 
 1 AS `promedio_ventas`,
 1 AS `estado_orden`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `cuit` varchar(45) DEFAULT NULL,
  `email` varchar(50) DEFAULT 'N/A',
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor_nuevo','123456789','provnuevo@email.com','4556363','Calle nueva'),(2,'Mouse SRL','101112131','cccddd@gmail.com','63514654','Av A 963'),(3,'Telefonos SRL','415161718','eeefff@gmail.com','24135665','Av B 78'),(4,'Provedoor SA','192021222','ggghhh@yaho.com','32156481','Calle X 123'),(5,'Proveedor_Nuevo2','324252627','provnuevo222@email.com','3877746','Av nueva'),(6,'Logitech','282930313','kkkllll@hotmail.com','65468432','Calle P 786'),(7,'Kingston','323334353','mmmnnn@outlook.com','65165462','Calle I 714'),(8,'AMD','637383940','oooppp@outlook.com','68543298','Calle C 9877'),(9,'Intel','414243444','qqqrrr@gmail.com','89879530','Av D 7314'),(10,'Lenovo','546474849','sssttt@hotmail.com','58792435','Calle G 2323'),(11,'Asus','505152535','uuuvvv@hotmail.com','56188932','Calle F 5656'),(12,'Philips','455565758','wwwxxx@outlook.com','12546325','Calle D 453'),(13,'LG','596061626','yyyzzz@outlook.com','37856985','Av F 4369'),(14,'Nvidia','636465666','abc1@gmail.com','32156987','Calle T 8989'),(15,'Sony','768697071','def1@hotmail.com','98763254','Calle R 7474');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bu_proveedores` BEFORE UPDATE ON `proveedores` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ad_proveedores` AFTER DELETE ON `proveedores` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provincias` (
  `id_provincia` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincias`
--

LOCK TABLES `provincias` WRITE;
/*!40000 ALTER TABLE `provincias` DISABLE KEYS */;
INSERT INTO `provincias` VALUES (1,'Cordoba'),(2,'Buenos Aires'),(3,'Santa Fe'),(4,'Mendoza'),(5,'San Luis'),(6,'Chubut'),(7,'Jujuy');
/*!40000 ALTER TABLE `provincias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `fk_id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_stock`),
  KEY `fk_id_producto` (`fk_id_producto`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`fk_id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,5,5),(2,7,41),(3,2,22),(4,13,15),(5,3,2),(6,15,13),(7,9,15),(8,11,20),(9,8,30),(10,12,10);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fk_id_orden` int DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `fk_id_orden` (`fk_id_orden`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`fk_id_orden`) REFERENCES `ordenes_de_compra` (`id_orden`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (6,1),(7,2),(8,3),(9,4),(10,5),(5,11),(4,12),(3,13),(2,14),(1,15);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tienda_online'
--

--
-- Dumping routines for database 'tienda_online'
--
/*!50003 DROP FUNCTION IF EXISTS `beneficio_por_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `beneficio_por_producto`(costo INT, precio_venta INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
	DECLARE beneficio DECIMAL(10,2);

	SET beneficio = (precio_venta - costo);

	RETURN beneficio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `clientes_por_ciudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `clientes_por_ciudad`(ciudad_id INT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE cant_cli INT;
    
    SELECT COUNT(id_cliente) INTO cant_cli FROM tienda_online.clientes WHERE fk_id_ciudad = ciudad_id;
    
    RETURN cant_cli;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `monto_orden` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `monto_orden`(num_orden INT) RETURNS varchar(250) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE n_orden INT;
    
    SELECT (cantidad * precio) INTO n_orden FROM tienda_online.ordenes_de_compra WHERE numero_orden = num_orden;
    
    RETURN n_orden;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `nombre_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nombre_cliente`(id_del_cliente INT) RETURNS varchar(45) CHARSET utf8mb4
    READS SQL DATA
BEGIN
	DECLARE nombre VARCHAR(45);
    
	SELECT CONCAT(clientes.nombre,' ',clientes.apellido) INTO nombre FROM tienda_online.clientes WHERE id_cliente = id_del_cliente;

	RETURN nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_generar_cliente`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_generar_proveedor`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ordenar_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordenar_productos`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ultimo_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ultimo_cliente`(OUT num_cliente INT)
BEGIN
    SELECT MAX(id_cliente) INTO num_cliente FROM tienda_online.clientes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ultimo_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ultimo_proveedor`(OUT num_proveedor INT)
BEGIN
    SELECT MAX(id_proveedor) INTO num_proveedor FROM tienda_online.proveedores;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `cantidad_ordenes_por_estado`
--

/*!50001 DROP VIEW IF EXISTS `cantidad_ordenes_por_estado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cantidad_ordenes_por_estado` AS select `ordenes_de_compra`.`estado_orden` AS `estado_orden`,count(`ordenes_de_compra`.`id_orden`) AS `Cantidad_de_ordenes` from `ordenes_de_compra` group by `ordenes_de_compra`.`estado_orden` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `compras_por_cliente`
--

/*!50001 DROP VIEW IF EXISTS `compras_por_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `compras_por_cliente` AS select concat(`clientes`.`nombre`,' ',`clientes`.`apellido`) AS `nombre_cliente`,`cli`.`total` AS `total` from (`clientes` join (select `ordenes_de_compra`.`fk_id_cliente` AS `fk_id_cliente`,sum((`ordenes_de_compra`.`cantidad` * `ordenes_de_compra`.`precio`)) AS `total` from `ordenes_de_compra` group by `ordenes_de_compra`.`fk_id_cliente`) `cli` on((`clientes`.`id_cliente` = `cli`.`fk_id_cliente`))) order by `cli`.`total` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `compras_por_prov`
--

/*!50001 DROP VIEW IF EXISTS `compras_por_prov`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `compras_por_prov` AS select `proveedores`.`nombre` AS `nombre`,`prov`.`total` AS `total` from (`proveedores` join (select `compras`.`fk_id_proveedor` AS `fk_id_proveedor`,sum((`compras`.`precio` * `compras`.`cantidad`)) AS `total` from `compras` group by `compras`.`fk_id_proveedor`) `prov` on((`proveedores`.`id_proveedor` = `prov`.`fk_id_proveedor`))) order by `prov`.`total` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `productos_por_categoria`
--

/*!50001 DROP VIEW IF EXISTS `productos_por_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `productos_por_categoria` AS select `categorias`.`nombre` AS `Categoria`,count(`productos`.`fk_id_categoria`) AS `Cantidad_Total` from (`productos` join `categorias` on((`categorias`.`id_categoria` = `productos`.`fk_id_categoria`))) group by `categorias`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `productos_por_orden`
--

/*!50001 DROP VIEW IF EXISTS `productos_por_orden`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `productos_por_orden` AS select `ordenes_de_compra`.`numero_orden` AS `numero_de_orden`,`productos`.`nombre` AS `producto_comprado`,`productos`.`precio` AS `precio` from (`ordenes_de_compra` left join `productos` on((`ordenes_de_compra`.`fk_id_producto` = `productos`.`id_producto`))) order by `ordenes_de_compra`.`numero_orden` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prom_por_estado_orden`
--

/*!50001 DROP VIEW IF EXISTS `prom_por_estado_orden`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prom_por_estado_orden` AS select avg((`ordenes_de_compra`.`precio` * `ordenes_de_compra`.`cantidad`)) AS `promedio_ventas`,`ordenes_de_compra`.`estado_orden` AS `estado_orden` from `ordenes_de_compra` group by `ordenes_de_compra`.`estado_orden` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-14 19:34:50
