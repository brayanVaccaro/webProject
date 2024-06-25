<?php
require_once '../../../../../bootstrap.php';

header('Content-Type: application/json');

// Prevenire il login se l'utente è già loggato
$utente = decodificaUtente();
requireLogout($utente);

// email e password via POST
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

$db = new Database();
$query = 'SELECT * FROM utenti WHERE email = :email';
$db->query($query);
$db->bind(':email', $email);

$user = $db->single();

if ($user === false) {
    http_response_code(400);
    echo json_encode(['message' => 'Credenziali errate']);
    exit;
}

// Verifica della password
if (!password_verify($password, $user['password'])) {
    http_response_code(400);
    echo json_encode(['message' => 'Credenziali errate']);
    exit;
}

// Rimuovere la password prima di codificarla nel JWT
unset($user['password']);

// Codifica l'utente nel JWT
codificaUtente($user);

echo json_encode(['message' => 'Login effettuato con successo', 'user' => $user]);
