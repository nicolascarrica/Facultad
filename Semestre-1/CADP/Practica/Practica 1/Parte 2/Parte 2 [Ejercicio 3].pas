{Realizar un programa que lea desde teclado la información de alumnos ingresantes a la carrera
Analista en TIC. De cada alumno se lee nombre y nota obtenida en el módulo EPA (la nota es un
número entre 1 y 10). La lectura finaliza cuando se lee el nombre “Zidane Zinedine“, que debe
procesarse. Al finalizar la lectura informar:
- La cantidad de alumnos aprobados (nota 8 o mayor) y
- la cantidad de alumnos que obtuvieron un 7 como nota}

Program ejercicio3;
var
 alum:string;
 aprob,aux,nota:integer;
begin
    aprob:=0;
    aux:=0;
    repeat
    write ('Nombre del alumno: ');
    readln(alum);
    write ('Nota obtenida en EPA: ');
    readln(nota);
    if ((nota<1)or(nota>10)) then
    repeat
        write ('Ingrese una nota valida: ');
        readln(nota);
    until ((nota>=1)and(nota<=10));
    if (nota >= 8) then
        aprob:=aprob+1;
    if (nota = 7) then
        aux:=aux+1;
    until (alum='Zidane Zinedine');
    writeln();
    writeln ('Cantidad de alumnos aprobados con 8 a más: ',aprob);
    writeln ('Cantidad de alumnos que obtuvieron 7: ',aux);
end.