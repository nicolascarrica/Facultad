program ejercicio8;
var
 operador:char;
 resultado: integer;
const
 num: array[0..3] of integer = (5,27,-32,0);
begin
    writeln('Ingrese "+" para sumar o "-" para restar: ');
    readln(operador);
    if (operador = '+') then
        begin
        resultado:=num[0]+num[1]+num[2]+num[3];
        writeln(resultado,' ','(5+27+(-32)+0)');
        end
    else
        if (operador = '-') then
            begin
            resultado:=num[0]-num[1]-num[2]-num[3];
            writeln(resultado,' ','(5-27-(-32)-0)');
            end
    else
        writeln('Error: Caracter invalido');
end.
