{El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs. As,
con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO para el año
2015 (1 docente cada 23,435 alumnos). Para ello, se cuenta con información de: CUE (código único de
establecimiento), nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad. Se pide
implementar un programa que procese la información y determine:

● Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO.

● CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.

El programa debe utilizar:

a) Un módulo para la lectura de la información de la escuela.

b) Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la cantidad
de alumnos y la cantidad de docentes).}


program ejercicio3;
const
    unesco=23435/1;
type
    escuela=record
        nombre,localidad:string;
        docentes,alumnos,cue:integer;
    end;
procedure leer(var e:escuela);
begin
    writeln('Introduzca los datos de la escuela; CUE, nombre, localidad');
    readln(e.cue);
    readln(e.nombre);
    readln(e.localidad);
    writeln('Escuela encontrada, ahora introduzca su cantidad de docentes y alumnos');
    readln(e.docentes);
    readln(e.alumnos);
    writeln;
end;
function relacion(docentes,alumnos:integer):real;
var
    cociente:real;
begin
    cociente:=alumnos/docentes;
    relacion:=cociente;
end;
procedure mejores(e:escuela;a:real;var a1,a2:real; var cue1,cue2:integer; var nombre1,nombre2:string);
begin
    if (a>a1) or (a1=0) then begin
        a2:=a1;
        a1:=a;
        cue2:=cue1;
        cue1:=e.cue;
        nombre2:=nombre1;
        nombre1:=e.nombre;
    end
    else if (a>a2) or (a2=0) then begin
        a2:=a;
        cue2:=e.cue;
        nombre2:=e.nombre;
    end;
end;
procedure laPlata(e:escuela;a:real;unesco:real;var aux:integer);
begin
    if (a>unesco) and (e.localidad='la plata') then
        aux:=aux+1;
end;    
var
e:escuela;
a,a1,a2:real;
cue1,cue2,i,aux:integer;
nombre1,nombre2:string;
begin
    for i:=1 to 2 do begin
        leer(e);
        a:=relacion(e.docentes,e.alumnos);
        mejores(e,a,a1,a2,cue1,cue2,nombre1,nombre2);
        laPlata(e,a,unesco,aux);
        writeln('La escuela ',e.nombre,' tiene ',e.docentes,' docentes y ',e.alumnos,' alumnos. CUE ',e.cue,' y está localizada en ',e.localidad);
        writeln('En promedio hay ',a:0:2,' alumnos por docentes en esta escuela');
        writeln;
    end;
    writeln('Las escuelas con mas docentes por alumno son: ',nombre1,' con CUE ',cue1,' y ',nombre2,' con CUE ',cue2);
    writeln;
    writeln('En La Plata hay ',aux,' escuelas que superan el promedio sugerido por la UNESCO');
end.

