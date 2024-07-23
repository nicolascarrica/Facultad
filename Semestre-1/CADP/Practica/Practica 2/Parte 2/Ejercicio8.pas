program ocho;
procedure paresImpares(num: integer; var sumaPares: integer; var cantImpares: integer);
var digito: integer;
begin
  sumaPares:=0;
  cantImpares:=0;
  while num <> 0 do
  begin
    digito:=num MOD 10;
    if digito MOD 2=0 then
      sumaPares:=sumaPares+digito
    else
      cantImpares:=cantImpares+1;
    num:=num DIV 10
  end;
end;
var
  num, sumaPares, cantImpares:integer;
begin
  writeln('Introduzca numeros enteros: ');
  readln(num);
  while (num <> 123) do begin
    paresImpares(num,sumaPares,cantImpares);
    writeln('El resultado de la suma de los digitos pares ',num,' es ',sumaPares,' y su cantidad de imapres es ',cantImpares);
    writeln;
    writeln('Introduzca numeros enteros: ');
    readln(num);
  end;
end.
