{Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:

● Cantidad total de centros para cada universidad.

● Universidad con mayor cantidad de investigadores en sus centros.

● Los dos centros con menor cantidad de becarios.}


program ejercicio7;
type
  centros=record
    nombre, universidad: string;
    investigadores, becarios: integer;
  end;

procedure leerDatos(var c: centros);
begin
  writeln('Ingrese Universidad');
  readln(c.universidad);
  writeln('Ingrese cantidad de investigadores');
  readln(c.investigadores);
  if (c.investigadores <> 0) then 
  begin
    writeln('Ingrese nombre del centro');
    readln(c.nombre);
    writeln('Ingrese cantidad de becarios');
    readln(c.becarios);
  end;
  writeln('---------------------------------');
end;

procedure masInvestigadores(c: centros; var max: integer; var univMax: string);
begin 
  if (c.investigadores > max) then
  begin
    max := c.investigadores;
    univMax := c.universidad;
  end;
end;

procedure masBecarios(c: centros; var maxBec1, maxBec2: integer; var centroMax1, centroMax2: string);
begin
  if (c.becarios > maxBec1) then
  begin
    maxBec2 := maxBec1;
    maxBec1 := c.becarios;
    centroMax2 := centroMax1;
    centroMax1 := c.nombre;
  end
  else if (c.becarios > maxBec2) then
  begin
    maxBec2 := c.becarios;
    centroMax2 := c.nombre;
  end;
end;

var
  c:centros;
  max, maxBec1, maxBec2, cantidadCentros: integer;
  univMax, centroMax1, centroMax2, uniActual: string;
begin
  max := 0;
  maxBec1 := 0;
  maxBec2 := 0;
  leerDatos(c);
  while (c.investigadores <> 0) do begin
    uniActual := c.universidad;
    cantidadCentros := 0;
    while (uniActual = c.universidad) and (c.investigadores <> 0) do begin
      cantidadCentros := cantidadCentros + 1;
      masInvestigadores(c, max, univMax);
      masBecarios(c, maxBec1, maxBec2, centroMax1, centroMax2);
      leerDatos(c);
    end;
    writeln('La cantidad de centros de la universidad ', uniActual, ' es ', cantidadCentros);
  end;
    writeln('La universidad con mayor cantidad de investigadores es ', univMax);
    writeln('Los dos centros con menor cantidad de becarios son ', centroMax1, ' y ', centroMax2);
end.



