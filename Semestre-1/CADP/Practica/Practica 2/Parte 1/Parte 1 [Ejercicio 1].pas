{1. Dado el siguiente programa, indicar qué imprime.}

program alcance1;
var a,b: integer;
procedure uno;
    var b: integer;
    begin
    b := 3;
    writeln(b);
end;
begin
    a:= 1;
    b:= 2;
    uno;
    writeln(b, a);
end.

{Imprimira el valor de b en el procedure ya que en la linea 8 se le asigna valor 3, y aunque en la linea 13 se reasigne el valor de b, en la linea 14 se llama al proceso Uno
donde b esta definido como 3, siendo una variable local este valor asignado dentro del proceso sera el que imprima la linea 9. La linea 15 imprimira los valores asignados en
el programa en las lineas 12 y 13. Primero el valor de b y luego el de a. Imprimiendolos como string ya que no es una operacion aritmetica.}