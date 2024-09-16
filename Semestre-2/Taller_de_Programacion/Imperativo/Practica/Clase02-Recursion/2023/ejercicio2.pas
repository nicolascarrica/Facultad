// 2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
// leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
// recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
// imprimir 2 5 6

program ejercicio2;

function descomponer(numero: integer):integer;
var
  digito:integer;
begin
  if (numero<>0) then begin
    digito:=numero mod 10;
    numero:=numero div 10;
    descomponer(numero);
    write(digito, ' ');
  end;
end;


var
  numero: integer;
begin
  repeat
    write('Ingrese un numero (0 para finalizar): ');
    readln(numero);
    if numero <> 0 then begin
      descomponer(numero);
      writeln; 
    end;
  until numero = 0;
end.