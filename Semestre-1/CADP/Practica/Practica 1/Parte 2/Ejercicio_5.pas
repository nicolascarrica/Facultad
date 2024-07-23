Program cinco;
var
    numero,suma,maximo, minimo: integer;
begin
    suma:=0;
    minimo:=MaxInt;
    maximo:=-MaxInt;
    write ('Introduzca los numeros: ');
    repeat 
        read (numero);
        suma:=suma+numero;
        if (numero>maximo) then
            maximo:=numero;
        if (numero<minimo) then
            minimo:=numero;
    until (numero=100);
    writeln();
    writeln ('La suma de todos los numeros es: ',suma);
    writeln ('El maximo es: ',maximo);
    writeln ('El minimo es: ',minimo);
end.