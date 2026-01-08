#!/bin/bash

#Realizar un script que le solicite al usuario 2 números, los lea de la entrada Standard
#e imprima la multiplicación, suma, resta y cual es el mayor de los números leídos.

function getMayor(){
    if [ $1 -gt $2 ]; then
        echo $1
    elif [ $2 -gt $1 ]; then
        echo $2
    else
        echo "Son iguales"
    fi
}

echo "Ingrese el primer número:"
read num1
echo "Ingrese el segundo número:"
read num2
echo "La suma es: $((num1 + num2))"
echo "La resta es: $((num1 - num2))"
echo "La multiplicación es: $((num1 * num2))"
echo "El mayor es: $(getMayor $num1 $num2)"

exit 0

