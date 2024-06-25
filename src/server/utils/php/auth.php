<?php
require_once "C:/xampp/htdocs/webProject/bootstrap.php";
use \Firebase\JWT\JWT;

const JWT_SECRET = 'jfiowfwfwffjrf3rf3rfg'; // Chiave segreta
const SESSION_KEY = 'access_token'; // Chiave della sessione dove memorizziamo il JWT

function codificaUtente($user) // Inserisce il token JWT nella sessione
{
    $accessToken = JWT::encode($user, JWT_SECRET, 'HS256');
    $_SESSION[SESSION_KEY] = $accessToken;
}

function decodificaUtente()
{
    if (!isset($_SESSION[SESSION_KEY])) {
        return null;
    } else {
        try {
            $decoded = JWT::decode($_SESSION[SESSION_KEY], new \Firebase\JWT\Key(JWT_SECRET, 'HS256'));
            $user = new Utente((array) $decoded);
            return $user;
        } catch (Exception $e) {
            error_log($e->getMessage(), 3, './query.log'); // Log dell'errore per analisi
            unset($_SESSION[SESSION_KEY]); // Se il token è invalido, rimuovilo
            return null;
        }
    }
}

function rimuoviUtente() // Rimuove il token JWT dalla sessione
{
    unset($_SESSION[SESSION_KEY]);
}

function requireLogin($utente)
{
    if ($utente == null) {
        header('HTTP/1.1 403 Forbidden');
        echo json_encode(['message' => 'Questa azione richiede il login']);
        exit;
    }
}

function requireLogout($utente)
{
    if ($utente != null) {
        header('HTTP/1.1 403 Forbidden');
        echo json_encode(['message' => 'Questa azione richiede il logout']);
        exit;
    }
}
