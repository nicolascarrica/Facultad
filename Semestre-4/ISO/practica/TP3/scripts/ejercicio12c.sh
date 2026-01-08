

#Realizar una calculadora que ejecute las 4 operaciones básicas: +, - ,*, %. 
#Esta calculadora debe funcionar recibiendo la operación y los números como parámetros

#!/bin/bash
if [[ $# -ne 3 ]]; then
    echo "se deben ingresar 3 parametros"
    exit 1
fi

case $2 in
    "+") echo "la suma es $(($1 + $3))";;
    "-") echo "la resta es $(($1 + $3))";;
    "*") echo "el producto es $(($1 + $3));;
    "/")
        if [ "$3" -eq 0]; then
            echo "Error: division por cero"
        else
            echo "la division es $(($1 / $3))
        fi
        ;;
    *) echo "no valido";;
esac

exit 0

EOF




