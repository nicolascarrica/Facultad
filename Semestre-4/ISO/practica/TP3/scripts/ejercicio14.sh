#Renombrando Archivos: haga un script que renombre solo archivos de un directorio pasado
#como parametro agregandole una CADENA, contemplando las opciones:
#“-a CADENA”: renombra el fichero concatenando CADENA al final del nombre del
#archivo
#“-b CADENA”: renombra el fichero concantenado CADENA al principio del nombre
#del archivo
#Ejemplo:
#Si tengo los siguientes archivos: /tmp/a /tmp/b
#Al ejecutar: ./renombra /tmp/ -a EJ
#Obtendré como resultado: /tmp/aEJ /tmp/bEJ
#Y si ejecuto: ./renombra /tmp/ -b EJ
#El resultado será: /tmp/EJa /tmp/EJb



#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Cantidad de parametros invalida"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "$1 no es un directorio"
    exit 2
fi

cd "$1"

if [ "$2" = "-a" ]; then
    for i in *; do  #Lista todos los archivos y directorios en el directorio actual. 
        if [ -f "$i" ]; then #Verifica si el elemento es un archivo regular.
            mv "$i" "$i$3" #Renombra el archivo agregando la cadena al final del nombre.
        fi
    done
elif [ "$2" = "-b" ]; then
    for i in *; do
        if [ -f "$i" ]; then
            mv "$i" "$3$i"
        fi
    done
else
    echo "Operacion incorrecta"
    exit 3
fi

exit 0