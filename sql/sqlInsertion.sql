INSERT INTO `utenti` (`idUtenti`, `username`, `password`, `nome`, `cognome`, `dataDiNascita`) VALUES
(1, 'Hitman', 'Bond007!', 'James', 'Bond', '11/11/1920'),
(2, 'SpiderMan', 'Spidey123!', 'Peter', 'Parker', '27/08/1993');

ALTER TABLE `utenti`
  MODIFY `idUtenti` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

INSERT INTO `stanze`(`idStanze`, `numeroStanza`, `prezzoStanzaAnotte`, `imgStanza`, `utenti`) VALUES
(1, '015', '85€', 'Bedroom.png', 1),
(2, '065', '95€', 'Bedroom2.png', 2);

ALTER TABLE `stanze`
  MODIFY `idStanze` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 3;

INSERT INTO `prenotazione`(`idPrenotazione`, `dataInizioPrenotazione`, `dataFinePrenotazione`, `numeroStanza`, `noteSullaStanza`, `utenti`) VALUES
(1, '18/12/2022', '25/12/2022', '015', 'Stanza singola con letto matrimonio, finestra e balconata e bagno', 1),
(2, '18/1/2023', '25/2/2023', '065', 'Stanza singola con letto singolo e balconata sul mare', 2);

ALTER TABLE `prenotazione`
  MODIFY `idPrenotazione` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 3;
