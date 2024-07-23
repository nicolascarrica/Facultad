program ejercicio4;
var
  x,y:real;
begin
  writeln ('Introduzca un numero: ');
  readln(x);
  // writeln ('Introduzca otro numero: ');
  // readln(y);
  while (y <> 2*x) do 
  begin
    writeln('Introduzca un nuevo numero: ');
    readln(y);
  end;
  writeln('Se ha encontrado un numero cuyo valor es exactamente el doble de X.');
end.

