{1. Realizar un programa que lea 10 números enteros e informe la suma total de los números leídos.}

Program ejercicio1;
var
  num,i,total:integer;
begin
  total := 0;
  writeln ('Introduzca los numeros');
  for i:= 1 to 10 do
     begin
         read (num);
         total:= total + num;
     end; 
  write ('La suma de los numeros introducidos es: ',total);
end.

{a. Modifique el ejercicio 1 para que además informe la cantidad de números mayores a 5}

Program ejercicio1;
var
  num,i,total,aux:integer;
begin
  total := 0;
  aux:=0;
  writeln ('Introduzca los numeros');
  for i:= 1 to 10 do
     begin
         read (num);
         total:= total + num;
         if (num>5) then
         begin
         aux:=aux+1;
         end
     end; 
  write ('La suma de los numeros introducidos es: ',total);
  writeln();
  write ('Hay ',aux,' numeros mayores a 5');
end.