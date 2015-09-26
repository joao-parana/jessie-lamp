#!/bin/bash
set -e

echo ". . . . Contêiner JessieLAMP . . . ."
if [ "$1" = 'modules' ]; then
    echo "Veja abaixo a lista de Módulos PHP instalados"
    find /usr/src/php/ext -mindepth 2 -maxdepth 2 -type f -name 'config.m4' | cut -d/ -f6 | sort
    echo "Você invocou com os seguintes parâmetros: "
    echo "$@"
fi

if [ "$1" = '--help' ]; then
    echo "Voce pode invocar este Contêiner das seguintes formas:"
    echo "docker run -i-t NOME-IMAGEM --help"
    echo "docker run -i-t NOME-IMAGEM modules"
    echo "$@"
fi
echo ". . . . . . . . . . . . . . . . . . ."
exec "$@"
