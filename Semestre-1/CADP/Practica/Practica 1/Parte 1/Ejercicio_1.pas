program ejercicio1;
var
 x,y:integer;
begin
    writeln('Introduzca un primer numero: ');
    readln(x);
    writeln('Introduzca un segundo numero: ');
    readln(y);
    if (x > y) then
        writeln('El primer numero: ',x,' es mayor al segundo numero ',y)
    else 
        if (x < y) then
            writeln('El segundo numero: ',y,' es mayor al primer numero ',x)
        else
            writeln('El primer numero: ',x,' es igual al segundo numero ',y);
end.