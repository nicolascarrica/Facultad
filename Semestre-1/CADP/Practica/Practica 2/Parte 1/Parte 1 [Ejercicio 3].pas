{3.Dado el siguiente programa, indicar cuál es el error y su causa.}

program alcance3;
var a: integer;
procedure uno;
var b: integer;
begin
b:= 2;
writeln(b);
end;
begin
a:= 1;
uno;
writeln(a, b);
end..

{Linea 4, no se declaro b y por lo tanto aunque este localmente en el proceso, el programa en la linea 14 no sabe de la existencia de b ya que su existencia es local en el proceso
Linea 15, hay un "." adicional y da error de compilacion}