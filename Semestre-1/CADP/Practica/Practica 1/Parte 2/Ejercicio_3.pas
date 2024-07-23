Program ejercicio3;
var
    nombre: string;
    nota, masDeOcho, aproboConSiete: integer;
begin
    masDeOcho:=0;
    aproboConSiete:=0;
    repeat
        write ('Nombre del alumno: ');
        readln (nombre);
        write ('Nota obtenida en EPA: ');
        readln (nota);
        if ((nota<1)or(nota>10)) then
        repeat
            write ('Ingrese una nota valida: ');
            readln (nota);
        until ((nota>=1)and(nota<=10));
        if (nota >= 8) then
            masDeOcho:=masDeOcho+1;
        if (nota = 7) then
            aproboConSiete:=aproboConSiete+1;
        until (nombre='Zinedine Zidane');

    writeln ('La cantidad de alumnos aprobados (nota 8 o mayor): ',masDeOcho);
    writeln ('La cantidad de alumno que obtuvieron un 7 como nota: ',aproboConSiete);

end.
