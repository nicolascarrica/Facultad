program ejercicio8;
  var
    i,ventadia:integer;
    totalmes,monto:real;
begin
  totalmes:=0;
  for i := 0 to 30 do begin
    ventadia:=0;
    writeln();
    writeln('Estamos en el dia ',i);
    writeln();
    writeln ('ingrese monto del dia: ');
    readln (monto);
    totalmes:=totalmes+monto;
    while (monto <> 0 ) do begin
      readln (monto);
      totalmes:=totalmes+monto;
      ventadia:=ventadia + 1;
    end;
    writeln();
    writeln('El dia ',i,' tuvo ',ventadia,' ventas');
  end;
   writeln();
   writeln ('monto total acumulado en ventas de todo el mes :',totalmes:0:2);
end.