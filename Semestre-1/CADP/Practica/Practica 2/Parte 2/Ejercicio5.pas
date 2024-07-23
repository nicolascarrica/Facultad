program cinco;
function esDoble(numA,numB:integer):boolean;
begin 
  if numB = 2*numA then
    esDoble := true
  else
    esDoble := false;
end;
var
  numA, numB, cantidadPares, cantidadDobles: integer;
begin
  cantidadPares := 0;
  cantidadDobles := 0;
  writeln('Introduzca los pares de números (0,0 para terminar): ');
  writeln ('numA');
  read(numA);
  writeln ('numB');
  read(numB);
  while (numA <> 0) and (numB <> 0) do
  begin
    cantidadPares:= cantidadPares + 1;
    if esDoble(numA, numB) then
      cantidadDobles:= cantidadDobles + 1;
    read(numA);
    read(numB);
  end;
  writeln('La cantidad de pares leidos es ', cantidadPares, ' y la cantidad de veces que numB es el doble de numA es: ', cantidadDobles);
end.
