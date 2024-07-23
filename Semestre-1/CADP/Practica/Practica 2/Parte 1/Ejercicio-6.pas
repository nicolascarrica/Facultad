program ejercicio6;

procedure maximo (num: integer; var maximo: integer);
begin
  read(num);
  while (num>0) do begin
    if (num>maximo) then
      maximo:=num;
    read(num);
  end;
  writeln('El numero más alto es: ',maximo);
end;
var numero, numeroMaximo: integer;
begin
  numeroMaximo:=0;
  maximo(numero,numeroMaximo);
end.
