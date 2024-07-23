// Program ocho;
// var
//   i, ventas_dia: integer;
//   total_mes, monto: real;

// begin
//   total_mes := 0;
//   for i := 1 to 5 do //puse 5 para que sea mas corto;
//   begin
//     ventas_dia := 0;
//     writeln('Ingrese las ventas del dia ', i);
//     readln(monto);
//     total_mes:= total_mes + monto;
//     while(monto<>0) do
//     begin
//       readln(monto);
//       total_mes:= total_mes + monto;
//       ventas_dia:= ventas_dia + 1;
//     end;
//     writeln('El dia ', i, ' tuvo ', ventas_dia, ' ventas');
//   end;
//   writeln('Monto total acumulado en ventas de todo el mes es $', total_mes:0:2);
// end.

Program ocho_a;
var
  i, ventas_dia, dia_mas_ventas: integer;
  total_mes, monto: real;

begin
  total_mes := 0;
  dia_mas_ventas := 0;
  for i := 1 to 5 do //puse 5 para que sea mas corto;
  begin
    ventas_dia := 0;
    writeln('Ingrese las ventas del dia ', i);
    readln(monto);
    total_mes:= total_mes + monto;
    while(monto<>0) do
    begin
      readln(monto);
      total_mes:= total_mes + monto;
      ventas_dia:= ventas_dia + 1;
      if (ventas_dia > dia_mas_ventas) then
        dia_mas_ventas := i;
    end;
    writeln('El dia ', i, ' tuvo ', ventas_dia, ' ventas');
  end;
  writeln('Monto total acumulado en ventas de todo el mes es $', total_mes:0:2);
  writeln('El dia con mas ventas es el dia', dia_mas_ventas);
end.