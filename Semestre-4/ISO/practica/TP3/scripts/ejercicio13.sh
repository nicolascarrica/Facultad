#a. Realizar un script que visualice por pantalla los números del 1 al 100 así como sus cuadrados. 

#!/bin/bash

for ((i=1; i<=5; i++)); do
    echo "$i ^ 2 = $(($i * $i))"
done

exit 0

# b. Crear un script que muestre 3 opciones al usuario: Listar, DondeEstoy y QuienEsta. Según la opción elegida se le debe mostrar: 
# ➢ Listar: lista el contenido del directorio actual. 
# ➢ DondeEstoy: muestra la ruta deldirectorio donde me encuentro ubicado. 
# ➢ QuienEsta: muestra los usuarios conectados al sistema. 

#!/bin/bash
select opcion in Listar DondeEstoy QuienEsta
do
    case $opcion in
        "Listar") echo "$(ls)";;
        "DondeEstoy") echo "$(pwd)";;
        "QuienEsta") echo "$(who)";;
        *) exit;;
    esac
done

EOF

#Crear un script que reciba como parámetro el nombre de un archivo e informe si el
#mismo existe o no, y en caso afirmativo indique si es un directorio o un archivo. En
#caso de que no exista el archivo/directorio cree un directorio con el nombre recibido
#como parámetro.

#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Se debe ingresar un parametro"
    exit 1
fi

if [ -e "$1" ]; then
    if [ -f "$1" ]; then
        echo "es un archivo"
    elif [ -d "$1" ]; then
        echo "Es un directorio"
    else
        echo "no es ni archivo ni directorio"
    fi
else
    mkdir "$1"
fi

exit