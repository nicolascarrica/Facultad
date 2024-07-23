program seis;
var
  legajo, alumnos_leidos, alumnos_mas_65, alumnos_destacados: integer;
  promedio: real;
begin
  alumnos_leidos := 0;
  alumnos_mas_65 := 0;
  alumnos_destacados := 0;
  writeln('ingresar un numero de legajo: ');
  readln(legajo);
  while (legajo <> -1) do
  begin
    writeln('ingresar un promedio: ');
    readln(promedio);
    alumnos_leidos := alumnos_leidos + 1;
    if (promedio > 6.5) then
      alumnos_mas_65 := alumnos_mas_65 + 1;
    if (promedio > 8.5) and (legajo < 2500) then
      alumnos_destacados := alumnos_destacados + 1;
    writeln('ingresar un numero de legajo: ');
    readln(legajo);
  end;

  writeln('alumnos leidos: ', alumnos_leidos);
  writeln('alumnos con promedio mayor a 6.5: ', alumnos_mas_65);
  writeln('porcentaje de alumnos destacados: ',
    alumnos_destacados / alumnos_leidos * 100: 0: 2, '%');
end.