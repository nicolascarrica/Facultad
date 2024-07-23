{4. Dado los siguientes programas, explicar la diferencia.}

{primer programa}

program alcance4a;
var a,b: integer;
procedure uno;
begin
a := 1;
writeln(a);
end;
begin
a:= 1;
b:= 2;
uno;
writeln(b, a);
end.

{segundo programa}

program alcance4b;
procedure uno;
begin
a := 1;
writeln(a);
end;
var a,b: integer;
begin
a:= 1;
b:= 2;
uno;
writeln(b, a);
end.

{En el segundo programa las variables del programa estan declaradas en la linea 27, luego del proceso, mientras que en el primer programa se declaran en la linea 6, antes del proceso
como consecuencia, el segundo programa falla ya que Pascal lee linea por linea y es necesario declarar las variables previo a cualquier proceso, aunque este sea llamado luego de la
declaracion de las variables (linea 31)}