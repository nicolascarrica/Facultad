program ocho;
const dimF=4;
type 
  rango = 1..dimF;
  alumno = record
    legajo: integer;
    dni: integer;
    apellido: string;
    nombre: string;
    anio: integer;
  end;

  vector = array [rango] of alumno;

  procedure leerAlumno(var a:alumno);
  begin
    writeln('ingrese legajo');
    readln(a.legajo);
    writeln('ingrese dni');
    readln(a.dni);
    writeln('ingrese apellido');
    readln(a.apellido);
    writeln('ingrese nombre');
    readln(a.nombre);
    writeln('ingrese anio');
    readln(a.anio);
  end;

  procedure cargarVector (var v: vector);
  var
    i: rango;
    a: alumno;
  begin
    for i:=1 to dimF do
      begin
        leerAlumno(a);
        v[i]:=a;
      end;
  end;

  procedure maximaEdad (a:alumno; var max1, max2: integer; var nombre1, nombre2, apellido1, apellido2: string);
  begin
    if (a.anio > max1) then
      begin
        max2:=max1;
        max1:=a.anio;
        nombre2:=nombre1;
        nombre1:=a.nombre;
        apellido2:=apellido1;
        apellido1:=a.apellido;
      end
    else
      if (a.anio > max2) then
        begin
          max2:=a.anio;
          nombre2:=a.nombre;
          apellido2:=a.apellido;
        end;
  end;

  function esPar (dni:integer):boolean;
  begin
    if (dni mod 2 = 0) then
      esPar:=true
    else
      esPar:=false;
  end;

  procedure recorrerVector (v:vector; var max1, max2: integer; var nombre1, nombre2, apellido1, apellido2: string; var cantAlumnos: integer);
  var
    i: rango;
  begin
    for i:=1 to dimF do
      begin
        maximaEdad(v[i], max1, max2, nombre1, nombre2, apellido1, apellido2);
        if (esPar(v[i].dni)) then
          cantAlumnos:=cantAlumnos+1;
      end;
  end;

  var
    v: vector;
    max1, max2: integer;
    nombre1, nombre2, apellido1, apellido2: string;
    cantAlumnos: integer;
    porcentaje: real;

begin
  max1:=-1;
  max2:=-1;
  cantAlumnos:=0;
  cargarVector(v);
  recorrerVector(v, max1, max2, nombre1, nombre2, apellido1, apellido2, cantAlumnos);
  if (cantAlumnos = 0) then
    porcentaje:=0
  else
    porcentaje:=(cantAlumnos/dimF)*100;

  writeln('el porcentaje de alumnos con dni par es de ', porcentaje:2:2, '%');
  writeln('los alumnos mas grandes son ', nombre1, ' ', apellido1, ' y ', nombre2, ' ', apellido2);

end.


