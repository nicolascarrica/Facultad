// Program cuatro;
// var
//     numeros, min1, min2, i: integer;
// begin
//     min1:=MaxInt;
//     min2:=MaxInt;
//     writeln('Introduzca los numeros');
//     for i:= 1 to 10 do
//     begin
//         read(numeros);
//         if (numeros<min1) then
//         begin
//             min2:=min1;
//             min1:=numeros;
//         end
//         else if (numeros<min2) then
//             min2:=numeros;
//     end;
//     writeln('El primer minimo es: ',min1);
//     writeln('El segundo minimo es: ',min2);
// end.

// Program cuatro_a;
// var
//     numero, min1, min2 : integer;
// begin
//     min1:=MaxInt;
//     min2:=MaxInt;
//     writeln('Introduzca los numeros');
//     repeat
//         read(numero);
//         if (numero<min1) then
//         begin
//             min2:=min1;
//             min1:=numero;
//         end
//         else if (numero<min2) then
//             min2:=numero;
//     until (numero=0);
//     writeln('El primer minimo es: ',min1);
//     writeln('El segundo minimo es: ',min2);
// end.

Program cuatro_b;
var
    numero, min1, min2 : integer;
begin
    min1:=MaxInt;
    min2:=MaxInt;
    writeln('Introduzca los numeros');
    read(numero);
    while (numero<>0) do
    begin
        read(numero);
        if (numero<min1) then
        begin
            min2:=min1;
            min1:=numero;
        end
        else if (numero<min2) then
            min2:=numero;
    end;
    writeln('El primer minimo es: ',min1);
    writeln('El segundo minimo es: ',min2);
end.