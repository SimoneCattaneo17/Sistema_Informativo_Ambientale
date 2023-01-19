-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 19, 2023 alle 20:24
-- Versione del server: 10.4.27-MariaDB
-- Versione PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `parchi`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `animale`
--

CREATE TABLE `animale` (
  `id` int(11) NOT NULL,
  `stato_salute` varchar(255) NOT NULL,
  `data_nascita` date NOT NULL,
  `sesso` tinyint(1) NOT NULL,
  `specie` varchar(255) NOT NULL,
  `parco` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `animale`
--

INSERT INTO `animale` (`id`, `stato_salute`, `data_nascita`, `sesso`, `specie`, `parco`) VALUES
(1, 'ottimo', '2023-01-12', 1, 'Scoiattolo', 'Parco Nazionale dello Stelvio'),
(2, 'ottimo', '2013-01-17', 0, 'Scoiattolo', 'Parco Nazionale dello Stelvio'),
(3, 'ottimo', '2016-01-06', 0, 'Scoiattolo', 'Parco Nazionale dello Stelvio'),
(4, 'pessimo', '2003-01-01', 0, 'Scoiattolo', 'Parco Nazionale dello Stelvio'),
(5, 'mezzo morto', '2016-01-30', 1, 'Scoiattolo', 'Gargano'),
(6, 'ottimo', '2019-05-23', 1, 'Orango tango', 'Gargano'),
(7, 'ottimo', '2020-03-13', 0, 'Lupo', 'Parco Nazionale dello Stelvio'),
(8, 'ottimo', '2022-02-07', 1, 'Serpente a sonagli', 'Gargano'),
(9, 'ottimo', '2023-01-03', 1, 'Moscerino della frutta', 'Natura viva'),
(10, 'ottimo', '2015-07-22', 0, 'Lupo', 'Ravenna'),
(11, 'ottimo', '2022-11-15', 0, 'Piccioni', 'Pombia'),
(12, 'buono', '2004-08-17', 1, 'Orango tango', 'Gargano');

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE `ordine` (
  `nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordine`
--

INSERT INTO `ordine` (`nome`) VALUES
('Aves'),
('Canis Lupus'),
('Diptero'),
('Gnatostomi'),
('Mammiferi'),
('Primati'),
('Rettile');

-- --------------------------------------------------------

--
-- Struttura della tabella `parco`
--

CREATE TABLE `parco` (
  `nome` varchar(255) NOT NULL,
  `Regione` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `parco`
--

INSERT INTO `parco` (`nome`, `Regione`) VALUES
('Gargano', 'Puglia'),
('Natura viva', 'Veneto'),
('Parco Nazionale dello Stelvio', 'Lombardia'),
('Pombia', 'Piemonte'),
('Ravenna', 'Emilia Romagna');

-- --------------------------------------------------------

--
-- Struttura della tabella `specie`
--

CREATE TABLE `specie` (
  `nome` varchar(255) NOT NULL,
  `ordine` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `specie`
--

INSERT INTO `specie` (`nome`, `ordine`) VALUES
('Falco Pellegrino', 'Aves'),
('Lupo', 'Canis Lupus'),
('Moscerino della frutta', 'Diptero'),
('Piccioni', 'Gnatostomi'),
('Scoiattolo', 'Mammiferi'),
('Orango tango', 'Primati'),
('Serpente a sonagli', 'Rettile');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `animale`
--
ALTER TABLE `animale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_specie` (`specie`),
  ADD KEY `idx_parco` (`parco`);

--
-- Indici per le tabelle `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`nome`);

--
-- Indici per le tabelle `parco`
--
ALTER TABLE `parco`
  ADD PRIMARY KEY (`nome`);

--
-- Indici per le tabelle `specie`
--
ALTER TABLE `specie`
  ADD PRIMARY KEY (`nome`),
  ADD KEY `idx_ordine` (`ordine`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `animale`
--
ALTER TABLE `animale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `animale`
--
ALTER TABLE `animale`
  ADD CONSTRAINT `parco` FOREIGN KEY (`parco`) REFERENCES `parco` (`nome`),
  ADD CONSTRAINT `specie` FOREIGN KEY (`specie`) REFERENCES `specie` (`nome`);

--
-- Limiti per la tabella `specie`
--
ALTER TABLE `specie`
  ADD CONSTRAINT `ordine` FOREIGN KEY (`ordine`) REFERENCES `ordine` (`nome`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
