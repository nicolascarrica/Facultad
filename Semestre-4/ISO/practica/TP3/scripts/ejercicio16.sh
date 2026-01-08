#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Error de parametros"
    exit 1
fi

> reporte.txt
ext=$1

usuarios=$(cut -d: -f1,6 /etc/passwd)

for linea in $usuarios; do
    user=$(echo "$linea" | cut -d: -f1)
    home=$(echo "$linea" | cut -d: -f2)

    if [ -d "$home" ]; then
        cantidad=$(find "$home" -type f -name "*.$ext" 2>/dev/null | wc -l)
        echo "Usuario: $user | cantidad archivos $cantidad" >> reporte.txt
    fi
done
     