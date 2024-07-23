{La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa
Jóvenes y Memoria durante la convocatoria 2020. Cada proyecto posee un código único, un título, el docente
coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el nombre de la
escuela y la localidad a la que pertenecen. Cada escuela puede presentar más de un proyecto. La información se
ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. Realizar un programa que
lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse), e
informe:

● Cantidad total de escuelas que participan en la convocatoria 2018 y cantidad de escuelas por cada localidad.

● Nombres de las dos escuelas con mayor cantidad de alumnos participantes.

● Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.}


program ejercicio8;
type
    docente=record
        dni:integer;
        nombre,apellido:string;
        email:string[12];
    end;
    proyecto=record
        titulo:string;
        codigo,cantAlum:integer;
    end;
procedure leerD(var d:docente);
begin
    writeln('Introduzca los datos del docente coordinador del proyecto; DNI, nombre y apellido e email');
    readln(d.dni);
    readln(d.nombre);
    readln(d.apellido);
    readln(d.email);
    writeln;
end;
procedure leerP(var p:proyecto);
begin
    writeln;
    writeln('Introduzca; codigo, titulo y cantidad de alumnos del proyecto');
    readln(p.codigo);
    readln(p.titulo);
    readln(p.cantAlum);
end;
procedure esc(var escuela:string);
begin
    writeln('Introduzca la escuela');
    readln(escuela);
end;
procedure local(var localidad:string; var anno:integer);
begin
    writeln('Introduzca la localidad y año de la convocatoria');
    readln(localidad);
    readln(anno);
end;
procedure a2018(anno:integer; var aux:integer);
begin
    if (anno=2018) then
        aux:=aux+1;
end;
procedure l2018(anno:integer;localidad,localActual:string; var aux1:integer);
begin
    if (anno=2018) and (localActual=localidad) then
        aux1:=aux1+1;
end;
procedure masParticipantes(escuela:string; p:proyecto; var esc1,esc2:string; var cant1,cant2:integer);
begin
    if (p.cantAlum>cant1) or (cant1=0) then begin
        cant2:=cant1;
        cant1:=p.cantAlum;
        esc2:=esc1;
        esc1:=escuela;
    end
    else if (p.cantAlum>cant2) or (cant2=0) then begin
        cant2:=p.cantAlum;
        esc2:=escuela;
    end;
end;
procedure parImpar(localidad:string; p:proyecto);
var
    digito,par,impar:integer;
begin
    par:=0;
    impar:=0;
    if (localidad='daireaux') then begin
        while (p.codigo>0) do begin
            digito:= p.codigo MOD 10;
            if digito MOD 2 = 0 then
                par:=par+1
            else
                impar:=impar+1;
            p.codigo:= p.codigo DIV 10;
        end;
        if par=impar then begin
            writeln('El proyecto de titulo ',p.titulo,' posee en su codigo la misma cantidad de digitos pares e impares');
        end;
    end;    
end;
var
    p:proyecto;
    d:docente;
    escuela,localidad,localActual,escuelaActual,esc1,esc2:string;
    anno,annoActual,aux,aux1,cant1,cant2:integer;
begin
    local(localidad,anno);
    localActual:=localidad;
    annoActual:=anno;
    esc(escuela);
    escuelaActual:=escuela;
    p.codigo:=0;
    while (p.codigo<>-1) do begin
        while (localActual=localidad) and (annoActual=anno) do begin
            l2018(anno,localidad,localActual,aux1);
            while (escuelaActual=escuela) do begin
                a2018(anno,aux);
                leerP(p);
                if (p.codigo=-1) then
                    break;
                parImpar(localidad,p);
                leerD(d);
                esc(escuela);
                masParticipantes(escuela,p,esc1,esc2,cant1,cant2);
                if (escuelaActual<>escuela) then begin
                    writeln('En 2018 participaron ',aux,' proyectos de la escuela ',escuelaActual);
                    break;
                end;
            end;
            if (p.codigo=-1) then
                    break;
            escuelaActual:=escuela;
            local(localidad,anno);
            if (localActual<>localidad) or (annoActual<>anno) then begin
                writeln('En 2018 de la localidad ',localActual,' participaron ',aux1,' escuelas');
                break;
            end;
        end;
        localActual:=localidad;
        annoActual:=anno;
    end;
    writeln;
    writeln('Las escuelas ',esc1,' y ',esc2,' son las que tuvieron mas alumnos participantes por proyecto. ',cant1,' y ',cant2,' alumnos respectivamente');
end.