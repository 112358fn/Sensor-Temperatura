-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 31 Octobre 2014 à 13:33
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `proyecto`
--

-- --------------------------------------------------------

--
-- Structure de la table `sensores`
--

CREATE TABLE IF NOT EXISTS `sensores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `sensores`
--

INSERT INTO `sensores` (`id`, `id_servidor`, `nombre`) VALUES
(1, 1, 'Sensor 1'),
(2, 1, 'Sensor 2'),
(3, 1, 'Sensor 3'),
(4, 2, 'Sensor 1'),
(5, 2, 'Sensor 2'),
(6, 2, 'Sensor 3'),
(7, 3, 'Sensor 1'),
(8, 3, 'Sensor 2'),
(9, 3, 'Sensor 3'),
(10, 4, 'Sensor 1'),
(11, 4, 'Sensor 2'),
(12, 4, 'Sensor 3');

-- --------------------------------------------------------

--
-- Structure de la table `servidores`
--

CREATE TABLE IF NOT EXISTS `servidores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `servidores`
--

INSERT INTO `servidores` (`id`, `nombre`) VALUES
(1, 'Servidor 1'),
(2, 'Servidor 2'),
(3, 'Servidor 3'),
(4, 'Servidor 4');

-- --------------------------------------------------------

--
-- Structure de la table `temperaturas`
--

CREATE TABLE IF NOT EXISTS `temperaturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sensor` int(11) NOT NULL,
  `fecha` timestamp NOT NULL,
  `temp` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

--
-- Contenu de la table `temperaturas`
--

INSERT INTO `temperaturas` (`id`, `id_sensor`, `fecha`, `temp`) VALUES
(1, 1, '2014-10-28 18:17:45', 15.5),
(2, 2, '2014-10-28 18:17:45', 15.7),
(3, 3, '2014-10-28 18:17:45', 15.4),
(4, 4, '2014-10-28 18:17:45', 16),
(5, 5, '2014-10-28 18:17:45', 16.1),
(6, 6, '2014-10-28 18:17:45', 15.9),
(7, 7, '2014-10-28 18:17:45', 14.5),
(8, 8, '2014-10-28 18:17:45', 14.6),
(9, 9, '2014-10-28 18:17:45', 15),
(10, 10, '2014-10-28 18:17:45', 15),
(11, 11, '2014-10-28 18:17:45', 15.2),
(12, 12, '2014-10-28 18:17:45', 15.6),
(13, 1, '2014-10-28 18:21:40', 16),
(14, 2, '2014-10-28 18:21:40', 15.6),
(15, 3, '2014-10-28 18:21:40', 16.1),
(16, 4, '2014-10-28 18:21:40', 17),
(17, 5, '2014-10-28 18:21:40', 16.3),
(18, 6, '2014-10-28 18:21:41', 16),
(19, 7, '2014-10-28 18:21:41', 15.9),
(20, 8, '2014-10-28 18:21:41', 16.5),
(21, 9, '2014-10-28 18:21:41', 16.8),
(22, 10, '2014-10-28 18:21:41', 14.9),
(23, 11, '2014-10-28 18:21:41', 15.4),
(24, 12, '2014-10-28 18:21:41', 15.7),
(25, 1, '2014-10-28 18:23:43', 16.6),
(26, 2, '2014-10-28 18:23:43', 16.1),
(27, 3, '2014-10-28 18:23:43', 15.8),
(28, 4, '2014-10-28 18:23:43', 16.7),
(29, 5, '2014-10-28 18:23:43', 16.1),
(30, 6, '2014-10-28 18:23:43', 16.1),
(31, 7, '2014-10-28 18:23:43', 15.4),
(32, 8, '2014-10-28 18:23:43', 16.2),
(33, 9, '2014-10-28 18:23:43', 16.6),
(34, 10, '2014-10-28 18:23:43', 14.5),
(35, 11, '2014-10-28 18:23:43', 15.8),
(36, 12, '2014-10-28 18:23:43', 15),
(37, 1, '2014-10-28 18:25:03', 20),
(38, 2, '2014-10-28 18:25:03', 20.4),
(39, 3, '2014-10-28 18:25:03', 20.1),
(40, 4, '2014-10-28 18:25:03', 20.2),
(41, 5, '2014-10-28 18:25:03', 20.4),
(42, 6, '2014-10-28 18:25:03', 20.6),
(43, 7, '2014-10-28 18:25:03', 20.8),
(44, 8, '2014-10-28 18:25:03', 20.3),
(45, 9, '2014-10-28 18:25:03', 20),
(46, 10, '2014-10-28 18:25:03', 20.1),
(47, 11, '2014-10-28 18:25:03', 20.3),
(48, 12, '2014-10-28 18:25:03', 20.5),
(49, 1, '2014-10-28 18:26:05', 20.5),
(50, 2, '2014-10-28 18:26:05', 20.8),
(51, 3, '2014-10-28 18:26:05', 20.6),
(52, 4, '2014-10-28 18:26:05', 20.5),
(53, 5, '2014-10-28 18:26:05', 20.7),
(54, 6, '2014-10-28 18:26:05', 20.8),
(55, 7, '2014-10-28 18:26:05', 20.9),
(56, 8, '2014-10-28 18:26:05', 20.7),
(57, 9, '2014-10-28 18:26:05', 20.3),
(58, 10, '2014-10-28 18:26:05', 20.5),
(59, 11, '2014-10-28 18:26:05', 20.5),
(60, 12, '2014-10-28 18:26:05', 20.6),
(61, 1, '2014-10-28 18:26:33', 19),
(62, 2, '2014-10-28 18:26:33', 19.8),
(63, 3, '2014-10-28 18:26:33', 19.6),
(64, 4, '2014-10-28 18:26:33', 19.3),
(65, 5, '2014-10-28 18:26:33', 19.4),
(66, 6, '2014-10-28 18:26:34', 19.1),
(67, 7, '2014-10-28 18:26:34', 19.5),
(68, 8, '2014-10-28 18:26:34', 19),
(69, 9, '2014-10-28 18:26:34', 18.4),
(70, 10, '2014-10-28 18:26:34', 18.9),
(71, 11, '2014-10-28 18:26:34', 18.7),
(72, 12, '2014-10-28 18:26:34', 19);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
