#!/bin/bash
set -e

echo ". . . . Contêiner JessieLAMP . . . ."
echo "Você invocou com os seguintes parâmetros: $@"
if [ "$1" = 'modules' ]; then
    echo "Veja abaixo a lista de Módulos PHP instalados"
    find /usr/src/php/ext -mindepth 2 -maxdepth 2 -type f -name 'config.m4' | cut -d/ -f6 | sort
    exit 0
fi

if [ "$1" = 'start-apache' ]; then
    echo "Iniciando Apache Web Server"
    /start-apache
    exit 0
fi

if [ "$1" = 'start-apache-and-mysql' ]; then
    echo "Iniciando Apache e MySQL"
    /start-apache-and-mysql
    exit 0
fi

if [ "$1" = '--help' ]; then
    echo "Você pode invocar este Contêiner das seguintes formas:"
    echo "docker run -i-t NOME-IMAGEM --help"
    echo "docker run -i-t NOME-IMAGEM modules"
    echo "       Para ver a lista de módulos PHP disponíveis em runtime"
    echo "docker run -i-t NOME-IMAGEM start-apache"
    echo "docker run -i-t NOME-IMAGEM start-apache-and-mysql"
    echo "docker run -i-t NOME-IMAGEM /bin/bash"
    exit 0
fi
echo ". . . . . . . . . . . . . . . . . . ."
exec "$@"
