program ejercicio7;
var
  codigo:integer;
  precio,precioN,aumento:real;
begin
  while(codigo <> 32767) do
  begin
  writeln ('Introduzca el codigo del producto: ');
  readln(codigo);
    writeln('Introduzca el precio actual: ');
    readln(precio);
    writeln('Introdizca el nuevo precio: ');
    readln(precioN);
    aumento:=((precioN*100)/precio)-100;
    if (aumento>10) then
    writeln('El precio actual del producto ',codigo,' es ',precio:0:2,' pesos y el nuevo precio sera ',precioN:0:2,' tendra un aumento mayor al 10%')
    else
    writeln('El precio actual del producto ',codigo,' es ',precio:0:2,' pesos y el nuevo precio sera ',precioN:0:2,' tendra un aumento menor al 10%');
  end;
end.

