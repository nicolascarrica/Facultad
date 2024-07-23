program diez;
function esVocal(c:char):boolean;
var
  vocal:boolean;
begin
  vocal:=false;
  if (c='a') or (c='e') or (c='i') or (c='o') or (c='u') then
    vocal:=true;
  esVocal:=vocal;
end;

procedure secuenciaA(letra: char; var cumpleA: boolean);
begin
  readln(letra);
  while esVocal(letra) and (letra <> '$') do
  begin
    readln(letra);
    if letra = '$' then
      begin
        cumpleA:=true;
        writeln('Secuencia A Terminada.');
      end;
  end;
  if not esVocal(letra) and (letra<> '$') then
    writeln('Secuencia invalida. Parte A debe ser vocal');
end;

procedure secuenciaB(letra: char; var cumpleB: boolean);
begin
  readln(letra);
  while not esVocal(letra) and (letra <> '#') do
  begin
    readln(letra);
    if letra = '#' then
    begin
      cumpleB:=true;
      writeln('Secuencia B Terminada.');
    end;
  end;
  if esVocal(letra) and (letra<> '#') then
    writeln('Secuencia invalida. Parte B debe ser consonante');
end;

var
  caracteres:char;
  cumpleA:boolean;
  cumpleB: boolean;
begin
  writeln('Introduzca una secuencia A de caracteres: ');
  secuenciaA(caracteres, cumpleA);
  if cumpleA then
  begin
    writeln('Introduzca una secuencia B de caracteres: ');
    secuenciaB(caracteres, cumpleB);
    if cumpleB then
      writeln('La secuencia cumple con el patrón A$B#')
  end;
  
end.
