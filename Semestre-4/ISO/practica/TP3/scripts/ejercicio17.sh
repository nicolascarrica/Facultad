#!/bin/bash
archivos=$(ls)
echo "antes del cambio $archivos"

echo "despues del cambio"
for i in $archivos; do
    echo $(echo $i | tr -d 'Aa' | tr 'b-zB-Z' 'B-Zb-z')
done


