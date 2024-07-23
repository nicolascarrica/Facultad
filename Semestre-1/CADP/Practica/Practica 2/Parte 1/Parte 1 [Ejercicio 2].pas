{2. Dado el siguiente programa, indicar qué imprime.}

program alcance2;
var a,b: integer;
procedure uno;
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

{Imprimira el valor de b en el procedure ya que en la linea 7 se le asigna valor 3, y aunque en la linea 13 se reasigne el valor de b, en la linea 14 se llama al proceso Uno
donde b esta definido como 3, y ademas como dentro del proceso no se declaro ninguna variable local sino que se usa la global el valor no se va a sobre escribir en el programa principal
porque aunque en la linea 12 se le asigne a b el valor 2, al llamar al proceso en la 13 este valor se vuelve a re escribir con el valor asignado dentro del proceso, es decir, 3.
Finalmente la linea 14 imprimira b con el valor del proceso ya que el mismo no tiene variable local y a con el valor asignado en la linea 11.
}