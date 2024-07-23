{6. 

a. Realice un módulo que lea de teclado números enteros hasta que llegue un valor negativo. Al finalizar la
lectura el módulo debe imprimir en pantalla cuál fue el número par más alto.

b. Implemente un programa que invoque al módulo del inciso a.}

program ejercicio6;
var
    num,numMax:integer;
procedure maximo;
{a}
begin
    writeln('Introduzca numeros: ');
    read(num);
    numMax:=num;
    while (num>=0) do begin
        read(num);
        if (num>numMax) then
            numMax:=num;
    end;
    writeln('El numero más alto es: ',numMax);
end;
{b}
begin
    maximo;
end.

