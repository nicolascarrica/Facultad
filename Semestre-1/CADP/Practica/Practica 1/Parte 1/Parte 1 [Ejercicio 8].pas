program ejercicio8;
var
 x,y,z:char;
const
 vocales: set of char = ['a', 'e', 'i', 'o', 'u'];
begin
 writeln('Introduzca un caracteres alfabetico: ');
 readln(x);
 writeln('Introduzca un caracteres alfabetico: ');
 readln(y);
 writeln('Introduzca un caracteres alfabetico: ');
 readln(z);
 if ((x in vocales) and (y in vocales) and (z in vocales)) then
        writeln('Todos son vocales')
    else
        if ((x in vocales) or (y in vocales) or (z in vocales)) then
            writeln('Hay al menos uno que no es vocal')
    else
        writeln('Ninguno es un caracter valido');
end.

{Sin usar una lista [es otra version del mismo enunciado]}
program ejercicio8;
var
 x:char;
 m,k,l: integer;
const
 a='a';
 e='e';
 i='i';
 o='o';
 u='u';
begin
    m:=0;
    k:=0;
 
    while (m<3) do
    begin
        m:=m+1;
        writeln('Introduzca un caracter alfabetico: ');
        readln(x);
        if ((x=a)or(x=e)or(x=i)or(x=o)or(x=u)) then
        begin
            k:=k+1;
        end
    end;
     
    if (k=3) then
    begin
        writeln('Todos los caracteres son vocales');
    end
    else
    begin
        writeln('Al menos un caracter no es vocal');
    end;
end.