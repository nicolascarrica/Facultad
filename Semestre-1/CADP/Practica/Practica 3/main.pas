{Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
Informática de la UNLP en el año 2020. De cada alumno se lee: nro de inscripción, DNI, apellido, nombre y
año de nacimiento. Una vez leída y almacenada toda la información, calcular e informar:


a) El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.


b) Apellido y nombre de los dos alumnos de mayor edad.}
program ejercicio8;
const
    dimF=400;
type
    datos= array[1..dimF] of integer;
    alum=record
        insc,dni,nacimiento:integer;
        nombre,apellido:string;
    end;
procedure cargarVector[var d:datos; var a:alum; var dimL:integer];
var
    i:integer;
begin
    dimL:=0;
    writeln('Ingrese los datos del alumno (2020); numero de inscripcion, DNI, Apellido, Nombre y año de nacimiento');
    for i:= 1 to dimF do
        readln(a.insc);
        readln(a.dni);
        readln(a.apellido);
        readln(a.nombre);
        readln(a.nacimiento);
        dimL:=dimL+1;
    end;
    writeln;
    writeln('La dimension logica del vector es ',dimL);
    writeln;
end;
var
    
begin

end.