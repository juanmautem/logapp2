-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-06-2022 a las 18:09:16
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dblogin_2`
--
CREATE DATABASE IF NOT EXISTS `dblogin_2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dblogin_2`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `proAddNwUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proAddNwUser` (IN `nombre` VARCHAR(30), IN `apellidos` VARCHAR(70), IN `rfc` VARCHAR(15), IN `idT` INT, IN `NickName` VARCHAR(21), IN `Psw` VARCHAR(50))  BEGIN
INSERT INTO catpersonas(txtNombre, txtApellidos, txtRFC) 
VALUES (nombre, apellidos, rfc);
SELECT MAX(nIdPersona) INTO @idP FROM catpersonas;
  
INSERT INTO relusuario
	(fk_eIdPersona, fk_eIdTipoP, txtNombreCorto, txtPassword) 
	VALUES (@idP,idT,NickName,MD5(Psw));

	END$$

DROP PROCEDURE IF EXISTS `proAddPerson`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proAddPerson` (IN `nombre` VARCHAR(30), IN `apellidos` VARCHAR(70), IN `rfc` VARCHAR(18))  BEGIN 
    	INSERT INTO `catpersonas`(`txtNombre`, `txtApellidos`, `txtRFC`) VALUES (nombre, apellidos, rfc);
    END$$

DROP PROCEDURE IF EXISTS `proAddUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proAddUser` (IN `idP` INT, IN `idT` INT, IN `NickName` VARCHAR(21), IN `Psw` VARCHAR(50))  BEGIN 
	INSERT INTO `relusuario`
	(`fk_eIdPersona`, `fk_eIdTipoP`, `txtNombreCorto`, `txtPassword`) 
	VALUES (idP,idT,NickName,MD5(Psw));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `alltypes`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `alltypes`;
CREATE TABLE IF NOT EXISTS `alltypes` (
`ID` int(11)
,`Type` varchar(30)
,`Description` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catpersonas`
--

DROP TABLE IF EXISTS `catpersonas`;
CREATE TABLE IF NOT EXISTS `catpersonas` (
  `nIdPersona` int(11) NOT NULL AUTO_INCREMENT,
  `txtNombre` varchar(30) NOT NULL,
  `txtApellidos` varchar(70) DEFAULT NULL,
  `txtRFC` varchar(15) DEFAULT NULL,
  `bActivo` bit(1) DEFAULT b'0',
  `fhCreacion` datetime DEFAULT current_timestamp(),
  `fhActualizacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`nIdPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Truncar tablas antes de insertar `catpersonas`
--

TRUNCATE TABLE `catpersonas`;
--
-- Volcado de datos para la tabla `catpersonas`
--

INSERT INTO `catpersonas` (`nIdPersona`, `txtNombre`, `txtApellidos`, `txtRFC`, `bActivo`, `fhCreacion`, `fhActualizacion`) VALUES
(2, 'Supper', 'Admin', 'ADMI290921', b'1', '2022-05-26 11:36:10', '2022-05-26 11:36:10'),
(3, 'Juan', 'Fernandez', 'FEAJ850930GV1', b'1', '2022-06-01 10:16:25', '2022-06-01 10:16:25'),
(4, 'Manuel', 'Alvarez', 'FEAJ850930GV2', b'0', '2022-06-01 10:21:55', '2022-06-01 10:21:55');

--
-- Disparadores `catpersonas`
--
DROP TRIGGER IF EXISTS `dsDelPersonas`;
DELIMITER $$
CREATE TRIGGER `dsDelPersonas` AFTER INSERT ON `catpersonas` FOR EACH ROW BEGIN
         
        INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'INSERT','ALL',
               NULL,NULL,'catpersonas');
           
   END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `dsInsPersonas`;
DELIMITER $$
CREATE TRIGGER `dsInsPersonas` AFTER INSERT ON `catpersonas` FOR EACH ROW BEGIN
         
        INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'INSERT','ALL',
               NULL,NULL,'catpersonas');
           
   END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `dsUpdPersonas`;
DELIMITER $$
CREATE TRIGGER `dsUpdPersonas` BEFORE UPDATE ON `catpersonas` FOR EACH ROW BEGIN
            IF  NEW.bActivo != OLD.bActivo 
            THEN
                INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'UPDATE','bActivo',
                OLD.bActivo,NEW.bActivo,'catpersonas');
            END IF ;
            IF  NEW.txtNombre != OLD.txtNombre 
            THEN
                INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'UPDATE','txtNombre',
                OLD.txtNombre,NEW.txtNombre,'catpersonas');
            END IF ;
            IF  NEW.txtApellidos != OLD.txtApellidos 
            THEN
                INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'UPDATE','bActivo',
                OLD.txtApellidos,NEW.txtApellidos,'catpersonas');
            END IF ;
            IF  NEW.txtRFC != OLD.txtRFC 
            THEN
                INSERT INTO `repcambios`(`user`, `txtAccion`, `txtCampo`,
                                    `txtAnterior`, `txtNuevo`, `txtTabla`) 
                VALUES (CURRENT_USER(),'UPDATE','bActivo',
                OLD.txtRFC,NEW.txtRFC,'catpersonas');
            END IF ;
   END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cattipopersona`
--

DROP TABLE IF EXISTS `cattipopersona`;
CREATE TABLE IF NOT EXISTS `cattipopersona` (
  `nIdTipoP` int(11) NOT NULL AUTO_INCREMENT,
  `txtTipo` varchar(30) NOT NULL,
  `txtDescripcion` varchar(150) DEFAULT NULL,
  `bActivo` bit(1) DEFAULT b'0',
  `fhCreacion` datetime DEFAULT current_timestamp(),
  `fhActualizacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`nIdTipoP`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Truncar tablas antes de insertar `cattipopersona`
--

TRUNCATE TABLE `cattipopersona`;
--
-- Volcado de datos para la tabla `cattipopersona`
--

INSERT INTO `cattipopersona` (`nIdTipoP`, `txtTipo`, `txtDescripcion`, `bActivo`, `fhCreacion`, `fhActualizacion`) VALUES
(1, 'Super Administrador', 'Administra todas las BD\'s del Servidor', b'1', '2022-05-27 08:15:37', '2022-05-27 08:15:37'),
(2, 'Administrador', 'Administra la BD a la que tiene acceso', b'1', '2022-05-27 08:15:37', '2022-05-27 08:15:37'),
(3, 'Empleado', 'Tiene acceso limitado a procedimientos y vistas', b'1', '2022-05-27 08:15:37', '2022-05-27 08:15:37'),
(4, 'Clientes', 'Tiene acceso limitado a procedimientos y vistas', b'1', '2022-05-27 08:15:37', '2022-05-27 08:15:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relusuario`
--

DROP TABLE IF EXISTS `relusuario`;
CREATE TABLE IF NOT EXISTS `relusuario` (
  `nIdRPT` int(11) NOT NULL AUTO_INCREMENT,
  `fk_eIdPersona` int(11) NOT NULL,
  `fk_eIdTipoP` int(11) NOT NULL,
  `txtNombreCorto` varchar(20) NOT NULL,
  `txtPassword` varchar(50) NOT NULL,
  `bActivo` bit(1) DEFAULT b'0',
  `fhCreacion` datetime DEFAULT current_timestamp(),
  `fhActualizacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`nIdRPT`),
  KEY `fk_eIdPersona` (`fk_eIdPersona`),
  KEY `fk_eIdTipoP` (`fk_eIdTipoP`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Truncar tablas antes de insertar `relusuario`
--

TRUNCATE TABLE `relusuario`;
--
-- Volcado de datos para la tabla `relusuario`
--

INSERT INTO `relusuario` (`nIdRPT`, `fk_eIdPersona`, `fk_eIdTipoP`, `txtNombreCorto`, `txtPassword`, `bActivo`, `fhCreacion`, `fhActualizacion`) VALUES
(1, 2, 1, 'superAdmin', '0192023a7bbd73250516f069df18b500', b'1', '2022-05-27 08:16:52', '2022-05-27 08:16:52'),
(2, 3, 1, '101', 'f5b5fa09b1173e948ddf896c8263df8b', b'1', '2022-06-01 10:16:25', '2022-06-01 10:16:25'),
(3, 4, 2, 'adminSisututem', '0129a2f62c0cfce2634dcf4520ccc0c1', b'1', '2022-06-01 10:21:55', '2022-06-01 10:21:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repcambios`
--

DROP TABLE IF EXISTS `repcambios`;
CREATE TABLE IF NOT EXISTS `repcambios` (
  `idMod` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(30) NOT NULL,
  `txtAccion` varchar(15) NOT NULL,
  `txtCampo` varchar(30) DEFAULT 'ALL',
  `txtAnterior` varchar(255) DEFAULT NULL,
  `txtNuevo` varchar(255) DEFAULT NULL,
  `txtTabla` varchar(50) NOT NULL,
  `fhUpdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idMod`),
  KEY `fk_iduser` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

--
-- Truncar tablas antes de insertar `repcambios`
--

TRUNCATE TABLE `repcambios`;
--
-- Volcado de datos para la tabla `repcambios`
--

INSERT INTO `repcambios` (`idMod`, `user`, `txtAccion`, `txtCampo`, `txtAnterior`, `txtNuevo`, `txtTabla`, `fhUpdate`) VALUES
(1, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-05-26 11:36:10'),
(2, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-05-26 11:36:10'),
(3, 'root@localhost', 'UPDATE', 'bActivo', '1', '0', 'catpersonas', '2022-05-26 11:37:39'),
(4, 'root@localhost', 'UPDATE', 'txtNombre', 'Admin', 'Supper', 'catpersonas', '2022-05-26 11:37:59'),
(5, 'root@localhost', 'UPDATE', 'bActivo', 'Super', 'Admin', 'catpersonas', '2022-05-26 11:38:08'),
(6, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:16:25'),
(7, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:16:25'),
(8, 'root@localhost', 'UPDATE', 'bActivo', '0', '1', 'catpersonas', '2022-06-01 10:17:11'),
(9, 'root@localhost', 'UPDATE', 'bActivo', '0', '1', 'catpersonas', '2022-06-01 10:17:15'),
(10, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:21:55'),
(11, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:21:55'),
(12, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:22:15'),
(13, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:22:15'),
(14, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:22:29'),
(15, 'root@localhost', 'INSERT', 'ALL', NULL, NULL, 'catpersonas', '2022-06-01 10:22:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
CREATE TABLE IF NOT EXISTS `sesiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idSesion` varchar(20) DEFAULT NULL,
  `fhInicio` datetime DEFAULT current_timestamp(),
  `fhFin` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncar tablas antes de insertar `sesiones`
--

TRUNCATE TABLE `sesiones`;
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwlogin`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vwlogin`;
CREATE TABLE IF NOT EXISTS `vwlogin` (
`UserID` int(11)
,`PersonID` int(11)
,`NickName` varchar(20)
,`Pass` varchar(50)
,`Activo` bit(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwusersdata`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vwusersdata`;
CREATE TABLE IF NOT EXISTS `vwusersdata` (
`UserID` int(11)
,`nIdPersona` int(11)
,`txtNombre` varchar(30)
,`txtApellidos` varchar(70)
,`txtRFC` varchar(15)
,`txtNombreCorto` varchar(20)
,`txtPassword` varchar(50)
,`bActivo` bit(1)
,`txtTipo` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `alltypes`
--
DROP TABLE IF EXISTS `alltypes`;

DROP VIEW IF EXISTS `alltypes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alltypes`  AS  select `cattipopersona`.`nIdTipoP` AS `ID`,`cattipopersona`.`txtTipo` AS `Type`,`cattipopersona`.`txtDescripcion` AS `Description` from `cattipopersona` where `cattipopersona`.`bActivo` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwlogin`
--
DROP TABLE IF EXISTS `vwlogin`;

DROP VIEW IF EXISTS `vwlogin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwlogin`  AS  select `relusuario`.`nIdRPT` AS `UserID`,`relusuario`.`fk_eIdPersona` AS `PersonID`,`relusuario`.`txtNombreCorto` AS `NickName`,`relusuario`.`txtPassword` AS `Pass`,`relusuario`.`bActivo` AS `Activo` from `relusuario` where `relusuario`.`bActivo` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwusersdata`
--
DROP TABLE IF EXISTS `vwusersdata`;

DROP VIEW IF EXISTS `vwusersdata`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwusersdata`  AS  select `b`.`nIdRPT` AS `UserID`,`a`.`nIdPersona` AS `nIdPersona`,`a`.`txtNombre` AS `txtNombre`,`a`.`txtApellidos` AS `txtApellidos`,`a`.`txtRFC` AS `txtRFC`,`b`.`txtNombreCorto` AS `txtNombreCorto`,`b`.`txtPassword` AS `txtPassword`,`b`.`bActivo` AS `bActivo`,`c`.`txtTipo` AS `txtTipo` from ((`catpersonas` `a` join `relusuario` `b` on(`a`.`nIdPersona` = `b`.`fk_eIdPersona`)) left join `cattipopersona` `c` on(`b`.`fk_eIdTipoP` = `c`.`nIdTipoP`)) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `relusuario`
--
ALTER TABLE `relusuario`
  ADD CONSTRAINT `relusuario_ibfk_1` FOREIGN KEY (`fk_eIdTipoP`) REFERENCES `cattipopersona` (`nIdTipoP`),
  ADD CONSTRAINT `relusuario_ibfk_2` FOREIGN KEY (`fk_eIdPersona`) REFERENCES `catpersonas` (`nIdPersona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
