#!/bin/bash
usuarios=($(cut -d: -f1 /etc/passwd))

imprimir(){
    echo "Usuarios en el sistema:"
    echo "${usuarios[@]}"
    for usuario in ${usuarios[@]}; do
        echo $usuario
    done
}

existe(){
    if [ $# -ne 1 ]; then
        echo "Debe pasar un nombre de usuario como parámetro"
        return 52
    fi

    for usuario in ${usuarios[@]}; do
        if [ "$usuario" = "$1" ]; then
            echo "El usuario $1 existe en el sistema"
            return 0
        fi
    done

    return 1
}