<?php
require_once '../../../../../bootstrap.php'; // Assume che tutte le dipendenze siano definite qui.

header('Content-Type: application/json');

// Blocca la richiesta se l'utente non ha effettuato il login
$utente = decodificaUtente();
requireLogin($utente);

// Cancella la sessione contenente l'access token
rimuoviUtente();

echo json_encode(['message' => 'Logout effettuato con successo', 'user' => $utente]);
