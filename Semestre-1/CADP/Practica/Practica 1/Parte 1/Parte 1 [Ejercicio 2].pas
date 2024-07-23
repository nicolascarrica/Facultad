program ejercicio1;
var
 x:real;
begin
    writeln('Dime un numero: ');
    readln(x);
    if (x<0) then
        writeln('Como ',x:0:2,' es negativo entonces el valor absoluto se representa: |',(x*(-1)):0:2,'| = ',x:0:2)
    else
        writeln('Como ',x:0:2,' es positivo entonces el valor absoluto se representa: |',x:0:2,'| = ',x:0:2);
end.