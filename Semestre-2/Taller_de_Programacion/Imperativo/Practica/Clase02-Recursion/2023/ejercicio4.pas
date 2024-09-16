// 4.- Escribir un programa con:
// a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
// menores a 100.
// b. Un módulo recursivo que devuelva el máximo valor del vector.
// c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.

program ejercicio4;
const
  dimF = 20;
type
  vector = array [1..dimF] of integer;

procedure cargarVector(var v:vector; indice:integer);
var
  d:integer;
begin
  if (indice<=dimF) then begin
    d:= random(99) + 1;
    v[indice]:=d;
    indice:=indice + 1;
    cargarVector(v, indice);
  end;
end;

procedure imprimirVector (v:vector; indice:integer);
begin
  if(indice<= dimF) then begin
    writeln('-------');
    writeln(v[indice]);
    indice:=indice+1;
    imprimirVector(v, indice);
  end;
end;

procedure maximo (v:vector; var max:integer; indice:integer);
begin
  if(indice<=dimF) then begin
    if(v[indice] > max) then begin
      max:=v[indice];
    end;
    maximo(v,max,indice+1);
  end;
end;

procedure minimo (v:vector; var min: integer; indice: integer);
begin
  if(indice<=dimF) then begin
    if(v[indice]< min) then begin
      min:=v[indice];
    end;
    minimo(v, min, indice+1);
  end;
end;

function suma(v:vector; indice:integer):integer;
var
  total: integer;
begin
  total:=0;
  if(indice<=dimF) then begin
    total:= v[indice] + suma(v, indice+1);
    suma:=total;
  end
  else suma:=0;
end;



var
  v:vector;
  indice, max, min, total: integer;
begin
  max:=-1;
  min:=100;
  indice:=1;
  randomize;
  cargarVector(v, indice);
  imprimirVector(v, indice);
  maximo(v, max, indice);
  writeln('El maximo valor es: ', max);
  minimo(v, min, indice);
  writeln('El minimo valor es: ', min);
  total:=suma(v, indice);
  writeln('La suma total es ', total);
end.
