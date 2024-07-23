{5. Dado el siguiente programa, indicar cuál es el error.}

program alcance4;
function cuatro: integer;
begin
cuatro:= 4;
end;
var a: integer;
begin
cuatro;
writeln(a);
end.

{Aunque el programa funciona, la funcion cuatro no se usa para nada en el proceso, tampoco algun proceso, por lo que es lo mismo que simplemente declarar una variable llamda "cuatro"
es decir, la funcion sobra. Y a la variable "a" nunca se le da ni modifica el valor por lo que siempre sera 0}