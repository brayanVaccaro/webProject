<?php
class Utente {
    public $idUtente;
    public $imgProfilo;
    public $nome;
    public $cognome;
    public $dataNascita;
    public $email;
    public $ruolo;

    public function __construct($data) {
        $this->idUtente = $data['idUtente'] ?? null;
        $this->imgProfilo = $data['imgProfilo'] ?? null;
        $this->nome = $data['nome'] ?? null;
        $this->cognome = $data['cognome'] ?? null;
        $this->dataNascita = $data['dataNascita'] ?? null;
        $this->email = $data['email'] ?? null;
        $this->ruolo = $data['ruolo'] ?? null;
    }
}
