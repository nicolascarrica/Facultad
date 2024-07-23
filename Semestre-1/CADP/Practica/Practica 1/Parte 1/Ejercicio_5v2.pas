program ejercicio5v2;
var
  x,y:real;
  aux:integer;
  encontro: boolean;
begin
  writeln('Introduzca un numero: ');
  readln(x);
  aux:=0;
  encontro := false;
  while ((aux < 10) and (encontro = false)) do
  begin
    writeln('ingrese otro numero: ');
    readln(y);
    aux:=aux+1;
    if (y=2*x) then
      encontro := true;
  end;
  if (encontro = true) then
    writeln('Se ha encontrado un numero cuyo valor es exactamente el doble de X.')
  else
    writeln('Agotaste los 10 intentos');
end.