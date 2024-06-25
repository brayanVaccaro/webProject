<?php
error_reporting(E_ALL ^ E_DEPRECATED ^ E_NOTICE ^ E_WARNING);
ini_set('display_errors', 'On');

// Avvia la sessione una volta in questo script, per gestire tutte le funzioni di autenticazione.
session_start();

// Include l'autoloader di Composer
require_once __DIR__ . '\\vendor\\autoload.php';
__FILE__;
// Include il file di configurazione del database
require_once __DIR__ . '\\src\\server\\utils\\php\\db.php';

// Include il file con le funzioni di autenticazione JWT
require_once __DIR__ . '\\src\\server\\utils\\php\\auth.php';

// Include la classe Utente
require_once __DIR__ . "\\src\\classes\\Utente.php";
