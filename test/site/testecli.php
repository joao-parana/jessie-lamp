<?php
print_r('Testando via CLI do php. Usando o coamndo: ' . PHP_EOL .
        'docker exec web_jessie php /var/www/html/testecli.php');
print_r(PHP_EOL);

$query = "select id, name, email from CRUDClass";
$sql = mysql_query($query)  or die(mysql_error());
while($linha = mysql_fetch_assoc($sql)){
  print_r($linha['name'] . PHP_EOL);;
}

return 0;

include('class/mysql_crud.php');
$db = new Database();
print_r($db);
$ret = $db->connect();
print_r($ret);
$db->select('CRUDClass'); // Table name
$res = $db->getResult();
print_r($res);
