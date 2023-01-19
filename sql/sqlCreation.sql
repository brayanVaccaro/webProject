-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 19, 2023 alle 15:23
-- Versione del server: 10.4.24-MariaDB
-- Versione PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `astra`
--

CREATE SCHEMA IF NOT EXISTS `astra` DEFAULT CHARACTER SET utf8 ;
USE astra ; 
-- --------------------------------------------------------

--
-- Struttura della tabella `prenotazione`
--

CREATE TABLE `prenotazione` (
  `idPrenotazione` int(11) NOT NULL,
  `dataInizioPrenotazione` date NOT NULL,
  `dataFinePrenotazione` date NOT NULL,
  `idUtente` int(11) NOT NULL,
  `idStanza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `recensione`
--

CREATE TABLE `recensione` (
  `idRecensione` int(11) NOT NULL,
  `dataRecensione` date NOT NULL,
  `idUtente` int(11) NOT NULL,
  `votoPulizia` enum('5stellina.png','4stellina.png','3stellina.png','2stellina.png','1stellina.png') COLLATE latin1_general_ci NOT NULL,
  `votoRistorazione` enum('5stellina.png','4stellina.png','3stellina.png','2stellina.png','1stellina.png') COLLATE latin1_general_ci NOT NULL,
  `votoAccoglienza` enum('5stellina.png','4stellina.png','3stellina.png','2stellina.png','1stellina.png') COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `recensione`
--

INSERT INTO `recensione` (`idRecensione`, `dataRecensione`, `idUtente`, `votoPulizia`, `votoRistorazione`, `votoAccoglienza`) VALUES
(1, '2023-01-17', 3, '3stellina.png', '4stellina.png', '5stellina.png'),
(16, '2023-01-18', 3, '3stellina.png', '4stellina.png', '1stellina.png');

-- --------------------------------------------------------

--
-- Struttura della tabella `stanza`
--

CREATE TABLE `stanza` (
  `idStanza` int(11) NOT NULL,
  `prezzoAnotte` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `imgStanza` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `tagliaStanza` enum('singola','doppia','tripla','quadrupla') COLLATE latin1_general_ci NOT NULL,
  `tipologiaStanza` enum('matrimoniale','suite','vistaMare') COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `stanza`
--

INSERT INTO `stanza` (`idStanza`, `prezzoAnotte`, `imgStanza`, `tagliaStanza`, `tipologiaStanza`) VALUES
(1, '56€', 'Bedroom2.png', 'singola', 'suite'),
(2, '45€', 'Bedroom.png', 'doppia', 'matrimoniale'),
(3, '56€', 'Bedroom2.png', 'tripla', 'suite'),
(4, '56€', 'Bedroom2.png', 'quadrupla', 'suite'),
(5, '56€', 'Bedroom2.png', 'singola', 'suite'),
(6, '56€', 'Bedroom2.png', 'doppia', 'suite'),
(7, '56€', 'Bedroom2.png', 'tripla', 'suite'),
(8, '56€', 'Bedroom2.png', 'quadrupla', 'suite'),
(9, '56€', 'Bedroom2.png', 'singola', 'suite'),
(10, '56€', 'Bedroom2.png', 'doppia', 'suite');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `idUtente` int(11) NOT NULL,
  `imgProfilo` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `nome` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `cognome` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `dataNascita` date NOT NULL,
  `email` varchar(155) COLLATE latin1_general_ci NOT NULL,
  `password` varchar(512) COLLATE latin1_general_ci NOT NULL,
  `ruolo` enum('gestore','cliente') COLLATE latin1_general_ci NOT NULL DEFAULT 'cliente'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`idUtente`, `imgProfilo`, `nome`, `cognome`, `dataNascita`, `email`, `password`, `ruolo`) VALUES
(3, 'profile-2.jpg', 'M', 'd', '2023-01-05', 'm@d', '$2b$10$I6ik4Bu5CQy/a6uNhq6HaORkRzOTYv7du3hCpE3eUqtzmBkmOZYSG', 'cliente'),
(5, 'profile-1.jpg', 'Marawan', 'Emad', '2002-04-09', 'marawan@emad', '$2b$10$ap2rHUSFHyCXfLCMHeWL2egF/CAI8mcHKvQNb4bHioOOZEhspbUda', 'gestore'),
(6, 'profile-3.jpg', 'Brayan', 'Vaccaro', '2000-05-28', 'brayan@vaccaro', '$2b$10$j0b6QDj5tm/owQCSoqzlCuMMooNjwse9/yWboxlFn0.iHjvP6pRp.', 'gestore');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD PRIMARY KEY (`idPrenotazione`),
  ADD UNIQUE KEY `dataInizioPrenotazione` (`dataInizioPrenotazione`,`idUtente`) USING BTREE,
  ADD KEY `idStanza` (`idStanza`),
  ADD KEY `idUtente` (`idUtente`);

--
-- Indici per le tabelle `recensione`
--
ALTER TABLE `recensione`
  ADD PRIMARY KEY (`idRecensione`),
  ADD UNIQUE KEY `dataRecensione` (`dataRecensione`,`idUtente`),
  ADD KEY `nUtente` (`idUtente`);

--
-- Indici per le tabelle `stanza`
--
ALTER TABLE `stanza`
  ADD PRIMARY KEY (`idStanza`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`idUtente`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `prenotazione`
--
ALTER TABLE `prenotazione`
  MODIFY `idPrenotazione` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `recensione`
--
ALTER TABLE `recensione`
  MODIFY `idRecensione` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `stanza`
--
ALTER TABLE `stanza`
  MODIFY `idStanza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `idUtente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD CONSTRAINT `idStanza` FOREIGN KEY (`idStanza`) REFERENCES `stanza` (`idStanza`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idUtente` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`idUtente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `recensione`
--
ALTER TABLE `recensione`
  ADD CONSTRAINT `nUtente` FOREIGN KEY (`idUtente`) REFERENCES `utenti` (`idUtente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
