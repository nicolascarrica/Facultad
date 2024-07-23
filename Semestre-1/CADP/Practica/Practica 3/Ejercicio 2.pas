{El registro civil de La Plata ha solicitado un programa para analizar la distribución de casamientos durante el año
2019. Para ello, cuenta con información de las fechas de todos los casamientos realizados durante ese año.

a) Analizar y definir un tipo de dato adecuado para almacenar la información de la fecha de cada casamiento.

b) Implementar un módulo que lea una fecha desde teclado y la retorne en un parámetro cuyo tipo es el definido
en el inciso a).

c) Implementar un programa que lea la fecha de todos los casamientos realizados en 2019. La lectura finaliza al
ingresar el año 2020, que no debe procesarse, e informe la cantidad de casamientos realizados durante los
meses de verano (enero, febrero y marzo) y la cantidad de casamientos realizados en los primeros 10 días de
cada mes. Nota: utilizar el módulo realizado en b) para la lectura de fecha.}


program ejercicio2;
type
    fecha = record
        dia,mes:integer;
    end;
procedure leer(var f:fecha;var anno:integer);
begin
    writeln('Introduzca el dia, mes y año del casamiento');
    readln(f.dia);
    if (f.dia<1) or (f.dia>31) then begin
        repeat
        writeln('Fecha invalida, introduzca un dia valido');
        readln(f.dia);
        until (f.dia>=1) and (f.dia<=31);
    end;
    
    readln(f.mes);
    if (f.mes<1) or (f.mes>12) then begin
        repeat
        writeln('Fecha invalida, introduzca un mes valido');
        readln(f.mes);
        until (f.mes>=1) and (f.mes<=12);
    end;
    
    readln(anno);
    if (anno<2019) or (anno>2020) then begin
        repeat
            writeln('Fecha invalida, introduzca un año valido');
            readln(anno);
        until (anno=2019) or (anno=2020);
    end;
    writeln('la fecha es ',f.dia,'/',f.mes,'/',anno);
    
end;
procedure verano(f:fecha;var aux,aux2:integer);
begin
    if (f.mes>=1) and (f.mes<=3) then
        aux:=aux+1;
    if (f.dia>=1) and (f.dia<=10) then
        aux2:=aux2+1;
end;
var
f:fecha;
anno,aux,aux2:integer;
begin
    aux:=0;
    aux2:=0;
    while (anno<>2020) do begin
        leer(f,anno);
        verano(f,aux,aux2);
    end;
    writeln;
    writeln('En verano de 2019 hubo ',aux,' casamientos en La Plata');
    writeln('Durante los primeros 10 dias de cada mes del año 2019 hubo ',aux2,' casamientos en La Plata');
end.

