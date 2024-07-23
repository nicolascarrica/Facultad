program alcanceYFunciones;
var
suma, cant : integer;
prom : real;
function calcularPromedio : real;
begin
if (cant = 0) then
prom := -1
else
prom := suma / cant;
end;
begin { programa principal }
readln(suma);
readln(cant);
calcularPromedio;
if ( prom <> -1) then begin
cant := 0;
writeln('El promedio es: ' , prom)
end
else
writeln('Dividir por cero no parece ser una buena idea');
end.
