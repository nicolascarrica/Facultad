program ejercicio6;
var
    legajo,alumnos,notaBaja,destacados:integer;
    promedio,porcentaje:real;
begin
    alumnos:=0;
    notabaja:=0;
    porcentaje:=0;
    writeln('ingresar un numero de legajo: ');
    readln(legajo);
    while (legajo<>-1) do begin
        writeln();
        writeln('ingresar un promedio: ');
        readln(promedio);
        alumnos:=alumnos+1;
        if (promedio>8.5) and (legajo<2500)then
        begin
        destacados:=destacados+1;
        end
        else
        begin
        if (promedio>6.5) then
        notaBaja:=notaBaja+1;
        end;
        writeln();
        writeln('ingresar un numero de legajo: ');
        readln(legajo);
    end;
    writeln();
    writeln('cantidad de alumnos es: ',alumnos);
    writeln();
    writeln('la cantidad de alumnos con promedio mayor a 6.5 es: ',notaBaja);
    writeln();
    porcentaje:=(destacados*100)/alumnos;
    writeln('el porcentaje de alumnos destacados es de: ',porcentaje:0:2,'%');
end.