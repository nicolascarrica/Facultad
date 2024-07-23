program once;
procedure A(caracter: char; var longitud: integer; var cumpleA: boolean);
begin
  readln(caracter);
  while (caracter<>'$') and (caracter<> '%') do
  begin
    readln(caracter);
    longitud:=longitud+1;
    if (caracter = '%') then
      begin
        cumpleA:=true;
        writeln('Secuencia A Terminada.');
      end;
  end;
end;

procedure B(caracter: char; var longitud: integer; var cumpleB: boolean);
var 
  arrobas: integer;
  contador: integer;
begin
  arrobas:=0;
  contador:=0;
  readln(caracter);
  while (arrobas<3) and (contador<longitud) and (caracter<>'*') do
  begin
    readln(caracter);
    contador := contador + 1;
    if (caracter = '@') then
      arrobas := arrobas + 1;
    if (caracter = '*') then
    begin
      cumpleB:=true;
      writeln('Secuencia B Terminada.');
    end;
  end;
end;

var
  caracter: char;
  cumpleA: boolean;
  cumpleB: boolean;
  longitud: integer;
begin
  cumpleA:=false;
  cumpleB:=false;
  longitud:=0;
  A(caracter,longitud,cumpleA);
  if cumpleA=true then
  begin
    B(caracter,longitud,cumpleB);
    if cumpleB=true then
      writeln('Programa Terminado')
    else writeln('Secuencia B incompleta')
  end
  else writeln('Secuencia A incompleta');
end.
