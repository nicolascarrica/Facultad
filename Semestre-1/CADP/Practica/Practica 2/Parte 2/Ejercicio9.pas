program nueve;
procedure leerDatos(var nInscripcion:integer; var apellido,nombre:string);
begin
  writeln('Introduzca los datos del alumno; inscripción, apellido y nombre: ');
  readln(nInscripcion);
  readln(apellido);
  readln(nombre);
end;
procedure maximo (numero:integer; nombre: string; var max1, max2: integer; var maxNombre1, maxNombre2: string);
begin
  if (numero > max1) then
    begin
      max2:=max1;
      maxNombre2:=maxNombre1;
      max1:=numero;
      maxNombre1:=nombre;
    end
  else if (numero > max2) then
    begin
      max2:=numero;
      maxNombre2:=nombre;
    end;
end;
procedure minimo (numero:integer; apellido: string; var min1, min2: integer; var minApellido1, minApellido2: string);
begin
  if (numero < min1) then
    begin
      min2:=min1;
      minApellido2:=minApellido1;
      min1:=numero;
      minApellido1:=apellido;
    end
  else if (numero < min2) then
    begin
      min2:=numero;
      minApellido2:=apellido;
    end;
end;

function esPar(numero:integer):boolean;
begin
  if (numero mod 2 = 0) then
    esPar:=true
  else
    esPar:=false;
end;

var
  nInscripcion, max1, max2, min1, min2: integer;
  apellido, nombre, maxNombre1, maxNombre2, minApellido1, minApellido2: string;
  canitdadLeida, numeroPar: integer;
  porcentaje: real;
begin
  max1:=0;
  max2:=0;
  min1:=9999;
  min2:=9999;
  canitdadLeida:=0;
  numeroPar:=0;
  porcentaje:=0;
  repeat
    leerDatos(nInscripcion, apellido, nombre);
    minimo(nInscripcion, apellido, min1, min2, minApellido1, minApellido2);
    maximo(nInscripcion, nombre, max1, max2, maxNombre1, maxNombre2);
    canitdadLeida:=canitdadLeida+1;
    if esPar(nInscripcion) then
      numeroPar:=numeroPar+1;
  until (nInscripcion=1200);
  porcentaje:=(numeroPar/canitdadLeida)*100;
  writeln('El apellido de los dos alumnos con inscripcion mas baja son ',minApellido1,' y ',minApellido2);
  writeln('El nombre de los dos alumno con inscripcion mas alta son ',maxNombre1,' y ',maxNombre2);
  writeln('El porcentaje de alumno con inscripcion par es de ',porcentaje:0:2,' %');
end.