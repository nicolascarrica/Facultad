program suma_producto_pares;

procedure leerDatos(var a,b:integer);
begin
  writeln('Introduzca el primer valor: ');
  readln(a);
  writeln('Introduzca el segundo valor: ');
  readln(b);
end;

procedure sumaYProductoEntreXY(x, y: integer);
var
  i, suma, producto: integer;
begin
  suma := 0;
  producto := 1;
  
  for i := x to y do
  begin
    suma := suma + i;
    producto := producto * i;
  end;
  
  writeln('La suma es ', suma);
  writeln('El producto es ', producto);
end;

var
  i, a, b: integer;
begin
  for i := 1 to 10 do
  begin
    leerDatos(a, b);
    sumaYProductoEntreXY(a, b);
  end;
end.