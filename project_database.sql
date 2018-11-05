-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 05 nov 2018 om 20:56
-- Serverversie: 5.7.21
-- PHP-versie: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_database`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `agenda`
--

DROP TABLE IF EXISTS `agenda`;
CREATE TABLE IF NOT EXISTS `agenda` (
  `agenda_id` int(11) NOT NULL AUTO_INCREMENT,
  `artiest_id` int(11) NOT NULL,
  `omschrijvingAgenda` varchar(100) NOT NULL,
  `begintijd` datetime NOT NULL,
  `eindtijd` datetime NOT NULL,
  `zaal` varchar(100) NOT NULL,
  `prijs` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`agenda_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='None';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `artiest`
--

DROP TABLE IF EXISTS `artiest`;
CREATE TABLE IF NOT EXISTS `artiest` (
  `artiest_id` int(11) NOT NULL AUTO_INCREMENT,
  `artiestNaam` varchar(150) NOT NULL,
  `omschrijving` varchar(250) NOT NULL,
  `artiestWebsite` varchar(60) NOT NULL,
  PRIMARY KEY (`artiest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='None';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `artiestagenda`
--

DROP TABLE IF EXISTS `artiestagenda`;
CREATE TABLE IF NOT EXISTS `artiestagenda` (
  `agenda_id` int(11) NOT NULL,
  `artiest_id` int(11) NOT NULL,
  PRIMARY KEY (`agenda_id`,`artiest_id`),
  KEY `artiest_id` (`artiest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `prijsex` int(11) NOT NULL,
  `btw` int(11) NOT NULL,
  `klant_id` int(11) NOT NULL,
  `zaal_id` int(11) NOT NULL,
  `datum` datetime NOT NULL,
  `agenda_id` int(11) NOT NULL,
  `status` enum('Verwerken','Ligt klaar','Opgehaald') NOT NULL,
  PRIMARY KEY (`klant_id`,`zaal_id`,`agenda_id`),
  KEY `zaal_id` (`zaal_id`),
  KEY `agenda_id` (`agenda_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `klant_id` int(11) NOT NULL AUTO_INCREMENT,
  `voornaam` varchar(100) NOT NULL,
  `tussenvoegsel` varchar(20) NOT NULL,
  `achternaam` varchar(100) NOT NULL,
  `gebruikersnaam` varchar(50) NOT NULL,
  `wachtwoord` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `adres` varchar(200) NOT NULL,
  `toevoeging` varchar(50) NOT NULL,
  `woonplaats` varchar(150) NOT NULL,
  `postcode` varchar(6) NOT NULL,
  `land` varchar(100) NOT NULL,
  `role` enum('gebruiker','zaalbeheer','admin') NOT NULL,
  PRIMARY KEY (`klant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='None';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `zaal`
--

DROP TABLE IF EXISTS `zaal`;
CREATE TABLE IF NOT EXISTS `zaal` (
  `Zaal_id` int(11) NOT NULL AUTO_INCREMENT,
  `zaalNaam` varchar(250) NOT NULL,
  `plaatsenVrij` int(11) NOT NULL,
  PRIMARY KEY (`Zaal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='None';

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `artiestagenda`
--
ALTER TABLE `artiestagenda`
  ADD CONSTRAINT `artiestagenda_ibfk_1` FOREIGN KEY (`artiest_id`) REFERENCES `artiest` (`artiest_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `artiestagenda_ibfk_2` FOREIGN KEY (`agenda_id`) REFERENCES `agenda` (`agenda_id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`zaal_id`) REFERENCES `zaal` (`Zaal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`klant_id`) REFERENCES `users` (`klant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`agenda_id`) REFERENCES `artiestagenda` (`agenda_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
