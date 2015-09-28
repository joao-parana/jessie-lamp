<?php
print_r('Testando via CLI do php. Usando o coamndo: ' . PHP_EOL .
        'docker exec web_jessie php /var/www/html/testecli.php');
print_r(PHP_EOL);
include('class/mysql_crud.php');
$db = new Database();
print_r($db);
$ret = $db->connect();
print_r($ret);
$db->select('CRUDClass'); // Table name
$res = $db->getResult();
print_r($res);
