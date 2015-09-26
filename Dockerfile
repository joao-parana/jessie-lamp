FROM php:5.6-apache
#
# php:5.6-apache usa a versão 8 do Debian de codinome Jessie
# 
MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

# Habilitando o módulo mod_rewrite que permite usar 
# as regras RewriteRule do Apache 
RUN a2enmod rewrite

# instalando as extensões PHP que precisaremos
RUN apt-get update \
  && apt-get install -y libpng12-dev libjpeg-dev \
  && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd

# instalando a extensão PHP para acesso a MySQL
RUN docker-php-ext-install mysqli

# Removendo /var/www/html/wp-content 
# Usaremos um Volume externo provido pelo 
# Host do Docker como repositório para os 
# Fontes PHP, HTML, JavaScript, CSS, etc. 
RUN rm -rf /var/www/html/wp-content

# Usaremos uma shell específica no Entrypoint
COPY ./docker-entrypoint.sh /
RUN chmod a+rx /docker-entrypoint.sh 
ENTRYPOINT ["/docker-entrypoint.sh"]

# Flag Default fornecida via comando CMD
CMD ["--help"]

# Módulos PHP instalados em instalações típicas:
#
# find /usr/src/php/ext -mindepth 2 -maxdepth 2 -type f \
#      -name 'config.m4' | cut -d/ -f6 | sort
# 
# bcmath, bz2, calendar, ctype, curl, dba, dom, enchant, exif, fileinfo, 
# filter, ftp, gd, gettext, gmp, hash, iconv, imap, interbase, intl, json, 
# ldap, mbstring, mcrypt, mssql, mysql, mysqli, oci8, odbc, opcache, pcntl, 
# pdo, pdo_dblib, pdo_firebird, pdo_mysql, pdo_oci, pdo_odbc, pdo_pgsql, 
# pdo_sqlite, pgsql, phar, posix, pspell, readline, recode, reflection, 
# session, shmop, simplexml, snmp, soap, sockets, spl, standard, sybase_ct, 
# sysvmsg, sysvsem, sysvshm, tidy, tokenizer, wddx, xml, xmlreader, xmlrpc, 
# xmlwriter, xsl, zip
#