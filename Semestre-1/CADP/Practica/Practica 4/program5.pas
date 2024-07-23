program cinco;
const 
  dimF = 100;
type 
  rango = 0..dimF;
  vector = array [1..dimF] of integer;


procedure cargarVector (var v: vector; var dimL: rango);
var
  num: integer;
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


procedure maximo (v: vector; dimL: rango; var max: integer; var posMax: rango);
var
  i: rango;
begin
  for i := 1 to dimL do
  begin
    if v [i] > max then
      begin
        max := v [i];
        posMax := i;
      end;
  end;
end;

procedure minimo (v: vector; dimL: rango; var min: integer; var posMin: rango);
var
  i: rango;
begin
  for i := 1 to dimL do
  begin
    if v [i] < min then
      begin
        min := v [i];
        posMin := i;
      end;
  end;
end;

procedure intercambio (var v: vector; x: rango; y: rango);
var
  aux: integer;
begin
  aux := v [x];
  v [x] := v [y];
  v [y] := aux;
end;

var 
  v: vector;
  dimL: rango;
  max, min: integer;
  posMax, posMin: rango;

begin
  max := -1;
  min := 9999;
  cargarVector (v, dimL);
  maximo (v, dimL, max, posMax);
  minimo(v, dimL, min, posMin);
  intercambio (v, posMax, posMin);
  writeln('EL elemento maximo ', max, ' que se encontraba en la posicion ', posMax, ' fue intercambiado con el elemento minimo ', min, ' que se encontraba en la posicion ', posMin, '.');
end.
