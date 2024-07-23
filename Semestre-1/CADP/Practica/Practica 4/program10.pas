program diez;
const dimF = 300;
type
  rango = 0..dimF;
  vector = array [rango] of real;

procedure cargarVector (var v: vector; var dimL: rango);
var
  num: real;
begin
  dimL := 0;
  writeln ('ingrese un numero');
  readln (num);
  while (num <> 0) and (dimL < dimF) do
    begin
      dimL := dimL + 1;
      v [dimL] := num;
      writeln ('ingrese un numero');
      readln (num);
    end;
end;

procedure aumento(aumento:real; dimL:rango; var v:vector);
var
  i: rango;
begin
  for i:=1 to dimL do
    v[i] := v[i]*aumento;
  writeln ('los elementos del vector aumentaron en ', aumento, ' el valor');
end;

procedure promedio (dimL:rango; v:vector);
var
  i: rango;
  suma: real;
begin
  suma := 0;
  for i:=1 to dimL do
    suma := suma + v[i];
  writeln ('el promedio de los elementos del vector es ', suma/dimL:2:2);
end;


var
  v: vector;
  dimL: rango;
  x: real;
begin
  cargarVector (v, dimL);
  writeln ('ingrese un aumento');
  readln (x);
  aumento(x, dimL, v);
  promedio(dimL, v);
end.

