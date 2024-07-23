program ejercicio5;
var
  num,sumTotal,max,min:integer;
begin
  sumTotal:=0;
  min:=MaxInt;
  writeln ('Introduzca numeros enteros: ');
  while (num<>100) do begin
    read(num);
    sumTotal:=sumTotal+num;
    if (num>max) and (num>min) then begin
      max:=num;
    end
    else
    begin
      if (num<min) then
        min:=num;
    end;
   end;
   writeln(); 
   writeln('El numero maximo leido es: ',max);
   writeln('El numero minimo leido es: ',min);
   writeln('La suma de todos los nuneros leidos es: ',sumTotal);
end.

