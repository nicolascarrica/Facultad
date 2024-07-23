// Program Ejercicio2;
// var
//     i, num, aux:integer;
// begin
//     aux:=-13; //menor numero de la secuencia
//     writeln('Introduzca los numeros');
//     for i:= 1 to 10 do
//     begin
//         read(num);
//         if (num>aux) then
//         begin
//             aux:=num;
//         end
//     end;
//     write('El mayor numero leido es: ',aux);
// end.

Program Ejercicio2_a;
var
    i, numero, maximo, posicion:integer;
begin
    maximo:=-13;
    posicion:=0;
    writeln('Introduzca los numeros');
    for i:= 1 to 10 do
    begin
        read(numero);
        if (numero>maximo) then
        begin
            maximo:=numero;
            posicion:=i;
        end
    end;
    write('El mayor numero leido es: ',maximo,' y se encuentra en la posicion: ',posicion);
end.