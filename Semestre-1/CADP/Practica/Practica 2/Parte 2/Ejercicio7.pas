program seis;
procedure descomponer(num: integer; var cantDigitos: integer; var sumaDigitos: integer);
  var
    digito: integer;
  begin
    cantDigitos := 0;
    sumaDigitos := 0;
    while (num <> 0) do
      begin
        digito := num MOD 10;
        cantDigitos := cantDigitos + 1;
        sumaDigitos := sumaDigitos + digito;
        num := num DIV 10;
      end;
end;

var
  num, sumaDigitos, cantDigitos, digitosLeidos: integer;
begin
  digitosLeidos := 0;
  repeat
    writeln('Introduzca un numero: ');
    readln(num);
    descomponer(num, cantDigitos, sumaDigitos);
    writeln('La suma de los digitos es: ', sumaDigitos);
    writeln('La cantidad de digitos es: ', cantDigitos);
    digitosLeidos := digitosLeidos + cantDigitos;
  until (sumaDigitos =10);
  writeln('La cantidad total de digitos leidos es: ', digitosLeidos);
end.