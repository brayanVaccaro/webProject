<?php

require_once '../../../../../bootstrap.php';

header('Content-Type: application/json');
$user = decodificaUtente();

if ($user) {
    $name = $user->nome;
    echo json_encode(['message' => "Utente $name è autenticato", 'user' => $user]);
} else {
    echo json_encode(['message' => 'Nessun utente autenticato', 'user' => $user]);
}
