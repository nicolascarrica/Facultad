Program Siete;

var
    i:integer;
    tiempo_carrera, tiempo_primero, tiempo_segundo, tiempo_ultimo, tiempo_anteultimo: real;
    nombre_piloto, nombre_primero, nombre_segundo, nombre_ultimo, nombre_anteultimo: string;

begin
    tiempo_primero:=MaxInt;
    tiempo_segundo:=MaxInt;
    tiempo_ultimo:=0;
    tiempo_anteultimo:=0;
    nombre_anteultimo:=' ';
    nombre_primero:=' ';
    nombre_segundo:=' ';
    nombre_ultimo:=' ';

    for i:= 0 to 4 do begin
        writeln('Ingrese el nombre del piloto');
        readln (nombre_piloto);
        writeln('Ingrese el tiempo del piloto');
        readln (tiempo_carrera);
        if (tiempo_carrera < tiempo_primero) then begin
            tiempo_segundo:=tiempo_primero;
            nombre_segundo:=nombre_primero;
            tiempo_primero:=tiempo_carrera;
            nombre_primero:=nombre_piloto;
        end
        else if (tiempo_carrera < tiempo_segundo) then begin
            tiempo_segundo:=tiempo_carrera;
            nombre_segundo:=nombre_piloto;
        end
        else if (tiempo_carrera > tiempo_ultimo) then begin
            tiempo_anteultimo:=tiempo_ultimo;
            nombre_anteultimo:=nombre_ultimo;
            tiempo_ultimo:=tiempo_carrera;
            nombre_ultimo:=nombre_piloto;
        end
        else if (tiempo_carrera > tiempo_anteultimo) then begin
            tiempo_anteultimo:=tiempo_carrera;
            nombre_anteultimo:=nombre_piloto;
        end
    end;
    writeln('El primero es ',nombre_primero,' con un tiempo de ',tiempo_primero:0:2);
    writeln('El segundo es ',nombre_segundo,' con un tiempo de ',tiempo_segundo:0:2);
    writeln('El ultimo es ',nombre_ultimo,' con un tiempo de ',tiempo_ultimo:0:2);
    writeln('El anteultimo es ',nombre_anteultimo,' con un tiempo de ',tiempo_anteultimo:0:2);
end.

