<?php

require_once "config.php";

class Database
{
    private $host = DB_HOST;
    private $user = DB_USER;
    private $pass = DB_PASS;
    private $dbname = DB_NAME;


    private $dbh;
    public $error;
    private $stmt;

    public function __construct(
        $host = null,
        $user = null,
        $pass = null,
        $dbname = null

    ) {
        if ($host !== null) {
            $this->host = $host;
        }

        if ($user !== null) {
            $this->user = $user;
        }

        if ($pass !== null) {
            $this->pass = $pass;
        }

        if ($dbname !== null) {
            $this->dbname = $dbname;
        }


        // Set DSN
        $dsn = 'mysql:host=' . $this->host . ';' . 'dbname=' . $this->dbname;

        // Set options
        $options = [
            PDO::ATTR_PERSISTENT => false,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ];

        // Create a new PDO instanace
        $this->dbh = new PDO($dsn, $this->user, $this->pass, $options);
        $this->dbh->exec("SET NAMES 'utf8'");
    }

    public function close()
    {
        $this->dbh = null;
        $this->stmt = null;
        return true;
    }

    public function bind($param, $value, $type = null)
    {
        if (is_null($type)) {
            switch (true) {
                case is_int($value):
                    $type = PDO::PARAM_INT;
                    break;
                case is_bool($value):
                    $type = PDO::PARAM_BOOL;
                    break;
                case is_null($value):
                    $type = PDO::PARAM_NULL;
                    break;
                default:
                    $type = PDO::PARAM_STR;
            }
        }
        $this->stmt->bindValue($param, $value, $type);
    }

    public function execute($nameValuePairArray = null)
    {
        $ret = false;
        try {
            if (
                is_array($nameValuePairArray) &&
                !empty($nameValuePairArray)
            ) {
                $ret = $this->stmt->execute($nameValuePairArray);
            } else {
                $ret = $this->stmt->execute();
            }
        } catch (PDOException $e) {
            $this->error = $e->getMessage();
        }

        return $ret;
    }

    public function fetch($FETCH_ASSOC = PDO::FETCH_ASSOC)
    {
        if (isset($FETCH_ASSOC) && $FETCH_ASSOC == PDO::FETCH_ASSOC) {
            $row = $this->stmt->fetch(PDO::FETCH_ASSOC);
            return $row;
        } else {
            $row = $this->stmt->fetch();
            return $row;
        }
    }

    public function single(
        $nameValuePairArray = null,
        $FETCH_ASSOC = PDO::FETCH_ASSOC
    ) {
        $this->execute($nameValuePairArray);
        if (isset($FETCH_ASSOC) && $FETCH_ASSOC == PDO::FETCH_ASSOC) {
            $row = $this->fetch();
            $this->stmt->closeCursor();
            return $row;
        } else {
            $row = $this->stmt->fetch();
            $this->stmt->closeCursor();
            return $row;
        }
    }

    public function query($query)
    {
        $this->stmt = $this->dbh->prepare($query);
    }

}