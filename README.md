# jessie-lamp

> Imagem Docker para **Stack LAMP** usando Debian Jessie (version 8),
> Apache WebServer, o MySQL 5.6.26 e o PHP versão 5.6 (A versão 7 ainda 
> não foi liberada)

Este projeto foi testado com a **versão 1.8.2** do Docker

Usado no curso [http://joao-parana.com.br/blog/curso-docker/](http://joao-parana.com.br/blog/curso-docker/) criado para a Escola Linux.

Neste repositório temos dois Releases deste projeto.

1. A versão 1.0.* está apenas com o LAMP (sem o SSH Server)
2. A versão 2.0.* está com LAMP e SSH Server como mostrado na imagem abaixo.

Veja no Diagrama abaixo o contêiner, o Volume, e as portas do Apache e do SSH

![https://raw.githubusercontent.com/joao-parana/jessie-lamp/master/docs/img/jessie-lamp.png](https://raw.githubusercontent.com/joao-parana/jessie-lamp/master/docs/img/jessie-lamp.png)

Criando a imagem

    docker build -t HUB-USER-NAME/jessie-lamp  .

Substitua o token `HUB-USER-NAME` pelo seu login em [http://hub.docker.com](http://hub.docker.com)


Usaremos aqui o nome `web_jessie` para o Contêiner.
Caso exista algum conteiner com o mesmo nome rodando, 
podemos pará-lo assim:

    docker stop web_jessie

> Pode demorar alguns segundos para parar e isto é normal.

Em seguida podemos removê-lo

    docker rm web_jessie

Podemos Executar o Contêiner como Daemon assim:

    docker run -d --name web_jessie -p 8085:80 HUB-USER-NAME/jessie-lamp

Observe o mapeamento da porta 80 do Apache dentro do contêiner 
para uso externo em 8085. O valor 8085 pode ser alterado a seu critério.
Você pode inclusive usar a porta 80 se tiver direitos para isso e se 
não estiver ocupada.

Verificando o Log

    docker logs web_jessie

Após executar o sistema por um tempo, podemos parar o contêiner 
novamente para manutenção

    docker stop web_jessie

e depois iniciá-lo novamente e observar o log

    docker start web_jessie && sleep 10 && docker logs web_jessie

Observe que **o LOG é acumulativo** e que agora não é executado o 
processo de Inicialização do Database, criação de usuários no MySQL, 
criação do nosso database, ajustes do PHP.INI, do HTTPD.CONF, etc. 

Você poderá ver o conteúdo do diretório /tmp executando o comando abaixo:

    docker exec web_jessie ls -lat /tmp

Se você estiver usando o **MAC OSX** com Boot2Docker 
poderá executar o comando abaixo para abrir uma sessão como 
root no MySQL:

    open http://`boot2docker ip`:8081 

No Linux (Ubuntu por exemplo) use assim:

    open http://`boot2docker ip`:8081

A senha do MySQL para ser usada no programa PHP 
está Hard-coded no arquivo run.sh, mas apenas 
por motivos didáticos. 
Veja a variável `MYSQL_ROOT_PASSWORD` na shell run.sh

## Diretórios importantes:

    Documentos do site - /var/www/html
    PHP.INI            - /usr/local/etc/php e /usr/local/etc/php/conf.d
    Extensões PHP      - /usr/src/php/ext
    Logs do Apache     - /var/log/apache2
    Logs do MySQL      - /var/log/mysql
    Logs do PHP        - /var/log  (configurado em config/php.ini)

Exemplo de uso do comando `docker exec` para ver o Log do MySQL

    docker exec web_jessie cat /var/log/mysql/error.log

Da mesma forma, para verificar a configuração do PHP use:

    docker exec web_jessie cat /usr/local/etc/php/php.ini


## Testando o ambiente

Programa PHP usando o MySQL e o Apache.

Arquivos: 

Classe Database (class/mysql_crud.php) 

    https://raw.githubusercontent.com/rorystandley/MySQL-CRUD-PHP-OOP/master/class/mysql_crud.php

Função para Select (ajax/select.php)

    https://github.com/rorystandley/MySQL-CRUD-PHP-OOP/blob/master/ajax/select.php

Pagina WEB de teste:

    <!DOCTYPE html>
    <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
    <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
    <!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
    <!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
      <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <!-- script>
          $(function(){
            $.ajax({
              url:"ajax/select.php",
              dataType:"json",
              success:function(data){
                $.each(data, function(index){
                  $("#names").append("<li>"+data[index].name+"</li>")
                });
              }
            });
          });
        </script  -->
      </head>
      <body>
        <!--[if lt IE 7]>
          <p class="chromeframe">You are using an <strong>outdated</strong> browser. 
          Please <a href="http://browsehappy.com/">upgrade your browser</a> or 
          <a href="http://www.google.com/chromeframe/?redirect=true">
            activate Google Chrome Frame
          </a> to improve your experience.</p>
        <![endif]-->
        <ul id="names"></ul>
      </body>
    </html>


Mais detalhes sobre Docker no meu Blog: [http://joao-parana.com.br/blog/](http://joao-parana.com.br/blog/)

