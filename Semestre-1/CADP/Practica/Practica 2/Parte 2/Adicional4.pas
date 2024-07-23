program Planetas;
const 
  DIAMETRO_TIERRA = 127;
  DIAMETRO_MARTE = 67;
  PERIMETRO_JUPITER = 439;
  PI: real = 3.1415;
procedure leerDatos(var nombre: string; var radio: integer; var distancia: integer);
begin
  writeln('Introduzca el nombre del planeta, su radio y la distancia del sol: ');
  readln(nombre);
  readln(radio);
  readln(distancia);
end;

procedure diametroYPerimetro(radio: integer; var diametro: integer; var perimetro: double);
begin
  diametro:=radio*2;
  perimetro:=2*PI*radio;
end;

var
  nombre: string;
  radio: integer;
  distancia: integer;
  diametro: integer;
  perimetro: real;
  planetaMayorJupiter: integer;

begin
  perimetro:=0;
  diametro:=0;
  planetaMayorJupiter:=0;
  leerDatos(nombre,radio,distancia);
  while (radio<>0) do
  begin
    diametroYPerimetro(radio,diametro,perimetro);
    if (perimetro>PERIMETRO_JUPITER) then
    begin
      planetaMayorJupiter:=planetaMayorJupiter+1;
    end
    else if (diametro<=DIAMETRO_TIERRA) and (diametro>=DIAMETRO_MARTE) then
    begin
      writeln(nombre);
      writeln(distancia);
    end;
    leerDatos(nombre,radio,distancia);
  end;
  writeln(planetaMayorJupiter);
end.
