-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 14, 2023 alle 21:42
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
USE `astra` ;

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

--
-- Dump dei dati per la tabella `prenotazione`
--

INSERT INTO `prenotazione` (`idPrenotazione`, `dataInizioPrenotazione`, `dataFinePrenotazione`, `idUtente`, `idStanza`) VALUES
(1, '2023-01-02', '2023-01-19', 1, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `recensione`
--

CREATE TABLE `recensione` (
  `idRecensione` int(11) NOT NULL,
  `dataRecensione` date NOT NULL,
  `testoRecensione` varchar(625) COLLATE latin1_general_ci NOT NULL,
  `idUtente` int(11) NOT NULL,
  `votoRecensione` enum('1stellina','2stellina','3stellina','4stellina','5stellina') COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `recensione`
--

INSERT INTO `recensione` (`idRecensione`, `dataRecensione`, `testoRecensione`, `idUtente`, `votoRecensione`) VALUES
(1, '2023-01-17', 'Stanza bella grande e pulita. nvwkfwwjwnjwj rhjriugrnrgtògjker gerògrgjgògnenggrgirnogerngioengegne gejgneognreg\r\ngqgirngàrigerg\r\nergrnigrengrg', 3, '3stellina'),
(2, '2023-01-24', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe evenie', 3, '4stellina');

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
(1, '', 'Gino', 'Pino', '2023-01-10', 'gino@pino', 'gino', 'cliente'),
(3, '', 'M', 'd', '2023-01-05', 'm@d', '$2b$10$I6ik4Bu5CQy/a6uNhq6HaORkRzOTYv7du3hCpE3eUqtzmBkmOZYSG', 'cliente');

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
  MODIFY `idRecensione` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `stanza`
--
ALTER TABLE `stanza`
  MODIFY `idStanza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `idUtente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
