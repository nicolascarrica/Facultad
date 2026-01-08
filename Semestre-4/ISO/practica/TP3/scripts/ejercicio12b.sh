

#Modificar el script creado en el inciso anterior para que los números sean recibidos
#como parámetros. El script debe controlar que los dos parámetros sean enviados
#!/bin/bash
function getMayor(){
    if [ $1 -gt $2 ]; then
        echo $1
    elif [ $2 -gt $1 ]; then
        echo $2
    else
        echo "Son iguales"
    fi
}

if [[ $# -ne 2 ]]; then
    echo "Se deben ingresar dos números como parámetros"
    exit 1
fi

echo "La suma es: $(($1 + $2))"
echo "La resta es: $(($1 - $2))"
echo "La multiplicación es: $(($1 * $2))"
echo "El mayor es: $(getMayor $@)"

exit 0
EOF


