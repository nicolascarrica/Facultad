program doce;
const 
  dimF = 5;
type
  rango = 1..dimF;
  tipoGalaxia = 1..4;
  galaxia = record
    nombre: string;
    tipo: tipoGalaxia;
    masa: real;
    distancia: real;
  end;

  vector = array [1..dimf] of galaxia;
  vectorContador = array [1..4] of integer;


procedure leerGalaxia(var g: galaxia);
begin
  writeln('ingrese nombre');
  readln(g.nombre);
  writeln('ingrese tipo');
  readln(g.tipo);
  writeln('ingrese masa');
  readln(g.masa);
  writeln('ingrese distancia');
  readln(g.distancia);
end;

procedure inicializarVector(var v: vectorContador);
var
  i: integer;
begin
  for i:=1 to 4 do
    v[i] := 0;
end;

procedure cargarVector(var v: vector);
var
  i: integer;
  g: galaxia;
begin
  for i:=1 to dimF do
    begin
      leerGalaxia(g);
      v[i] := g;
    end;
end;

procedure informarContador(v: vectorContador);
var
  i: integer;
begin
  for i:=1 to 4 do
    writeln('la cantidad de galaxias de tipo ', i, ' es ', v[i]);
end;

procedure maximos (masa: real; nombre: string; var max1, max2: real; var nombre1, nombre2: string);
begin
  if (masa > max1) then
    begin
      max2:=max1;
      max1:=masa;
      nombre2:=nombre1;
      nombre1:=nombre;
    end
  else
    if (masa > max2) then
      begin
        max2:=masa;
        nombre2:=nombre;
      end;
end;

var
  v: vector;
  vc: vectorContador;
  max1, max2: real;
  nombre1, nombre2: string;
  i: integer;
  tipo: integer;
  porcentaje: real;
  masa_total: real;
  cant_galaxias: integer;
begin
  max1:=-1;
  max2:=-1;
  cant_galaxias:=0;
  masa_total:=0;
  cargarVector(v);
  inicializarVector(vc);
  for i:=1 to dimF do
    begin
      tipo:=v[i].tipo;
      vc[tipo] := vc[tipo] + 1;

      if ((v[i].nombre='Andromeda') or (v[i].nombre='Via Lactea') or (v[i].nombre='Triangulo')) then
        masa_total:=masa_total + v[i].masa;
      
      if (v[i].tipo <>4) and (v[i].distancia>1000) then
        cant_galaxias:=cant_galaxias+1;

      maximos(v[i].masa, v[i].nombre, max1, max2, nombre1, nombre2);
    end;
  porcentaje:=(cant_galaxias/dimF)*100;
  informarContador(vc);
  writeln('la masa de las galaxias es ', masa_total:2:2, ' y el porcentaje respoecto al total es ', porcentaje:2:2);
  writeln('el nombre de la galaxia mas grande es ', nombre1, ' y ', nombre2);
  writeln ('la cantidad de no regulares es ', cant_galaxias);
end.