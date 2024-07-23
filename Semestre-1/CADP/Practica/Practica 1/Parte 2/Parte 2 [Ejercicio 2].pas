{Realice un programa que lea 10 números e informe cuál fue el mayor número leído.}

Program ejercicio2;
var
    i:integer;
    num,aux:real;
begin
    aux:=0;
    writeln('Introduzca los numeros');
    for i:= 1 to 10 do
    begin
        read(num);
        if (num>aux) then
        begin
            aux:=num;
        end
    end;
    write('El mayor numero leido es: ',aux:0:2);
end.

{a. Modifique el programa anterior para que, además de informar el mayor número leído, se
informe el número de orden, dentro de la secuencia, en el que fue leído.}

Program ejercicio2a;
var
    i,pos:integer;
    num,aux:real;
begin
    aux:=0;
    pos:=0;
    writeln('Introduzca los numeros');
    for i:= 1 to 10 do
    begin
        read(num);
        if (num>aux) then
        begin
            aux:=num;
            pos:=i;
        end
    end;
    writeln();
    write('El mayor numero leido es: ',aux:0:2, ' en la posicion ',pos);
end.