program candidatos;
type
  candidato = record
    localidad: string;
    apellido: string;
    votos: integer;
    totalVotantes: integer;
  end;

procedure leer(var c: candidato);
begin
  writeln('Introduzca la localidad');
  readln(c.localidad);
  writeln('Introduzca el apellido');
  readln(c.apellido);
  writeln('Introduzca la cantidad de votos');
  readln(c.votos);
  writeln('Introduzca la cantidad de votantes');
  readln(c.totalVotantes);
  writeln('-----------------------------------');
end;
procedure masVotos(c: candidato; var max: integer; var maxApellido: string);
begin
  if (c.votos > max) then
  begin
    max := c.votos;
    maxApellido := c.apellido;
  end;
end;

procedure masPorcentaje(c: candidato; var max: real; var maxApellido: string);
var
  porcentaje: real;
begin
  porcentaje := (c.votos / c.totalVotantes) * 100;
  if (porcentaje > max) then
  begin
    max := porcentaje;
    maxApellido := c.apellido;
  end;
end;

var
  c: candidato;
  maxVotos: integer;
  maxPorcentaje: real;
  apellidoMasVotos: string;
  apelllidoMasPorcentaje: string;
begin
  maxVotos := 0;
  maxPorcentaje := 0;
  apellidoMasVotos := '';
  apelllidoMasPorcentaje := '';
  repeat
    leer(c);
    masVotos(c, maxVotos, apellidoMasVotos);
    masPorcentaje(c, maxPorcentaje, apelllidoMasPorcentaje);
  until (c.localidad = 'Zarate');

  writeln('El candidato con mas votos es ', apellidoMasVotos, ' con ', maxVotos, ' votos');
  writeln('El candidato con mas porcentaje es ', apelllidoMasPorcentaje, ' con ', maxPorcentaje:2:2, '% de votos');
end.