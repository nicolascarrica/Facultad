program ejercicio5;
var
  x,y:real;
  aux:integer;
begin
  writeln('Introduzca un numero: ');
  readln(x);
  aux:=0;
  while (aux < 10) do
  begin
    writeln('ingrese otro numero: ');
    readln(y);
    aux:=aux+1;
    if (y=2*x) then
    begin
      writeln('Se ha encontrado un numero cuyo valor es exactamente el doble de X.');
      exit
    end;
  end;
  writeln('Agotaste los 10 intentos');
end.