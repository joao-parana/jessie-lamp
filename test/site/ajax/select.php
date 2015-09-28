<?php
// header('content-type: application/json; charset=utf-8');
header('content-type: text/html; charset=utf-8');
echo '{ error: "Erro ao conectar ao database"}';
include('../class/mysql_crud.php');
$db = new Database();
$ret = $db->connect();
if ($ret) {
  $db->select('CRUDClass','name'); // Table name, Column Names, WHERE conditions, ORDER BY conditions
  $res = $db->getResult();
  echo json_encode($res);
} else {
  echo '{ error: "Erro ao conectar ao database"}';
}
