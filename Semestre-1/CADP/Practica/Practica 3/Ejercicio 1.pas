{Dado el siguiente programa:
program Registros;
type
str20 = string[20];
alumno = record
codigo : integer;
nombre : str20;
promedio : real;
end;
procedure leer(var alu : alumno);
begin
writeln(‘Ingrese el código del alumno’);
read(alu.codigo);
if (alu.codigo <> 0) then begin
writeln(‘Ingrese el nombre del alumno’); read(alu.nombre);
writeln(‘Ingrese el promedio del alumno’); read(alu.promedio);
end;
end;

declaración de variables del programa principal 

var
a : alumno;

cuerpo del programa principal 
 
begin
...
end.

a. Completar el programa principal para que lea información de alumnos (código, nombre, promedio) e informe
la cantidad de alumnos leídos. La lectura finaliza cuando ingresa un alumno con código 0, que no debe
procesarse. Nota: utilizar el módulo leer.
b. Modificar al programa anterior para que, al finalizar la lectura de todos los alumnos, se informe también el
nombre del alumno con mejor promedio.}


program ejercicio1;
type
    str20 = string[20];
    alumno = record
        codigo : integer;
        nombre : str20;
        promedio : real;
end;
procedure leer(var alu : alumno);
begin
    writeln('Ingrese el código del alumno');
    readln(alu.codigo);
    if (alu.codigo <> 0) then begin
        writeln('Ingrese el nombre del alumno: '); 
        readln(alu.nombre);
        writeln('Ingrese el promedio del alumno'); 
        readln(alu.promedio);
    end;
end;
procedure prom(alu:alumno; var prom1:real; var nombre1: string);
begin
    if (alu.promedio>prom1) or (prom1=0) then begin
        prom1:=alu.promedio;
        nombre1:=alu.nombre;
    end;
end;
var
a : alumno;
alum:integer;
prom1:real;
nombre1:str20;
begin
    leer(a);
    while (a.codigo<>0) do begin
        leer(a);
        alum:=alum+1;
        prom(a,prom1,nombre1);
    end;
    writeln('Se leyeron ',alum,' alumnos.');
    writeln;
    writeln('El alumno ', nombre1,' tiene el mayor promedio, que es: ',prom1:0:2);
end.

