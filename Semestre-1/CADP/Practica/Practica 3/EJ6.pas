program procesadores;
type
  procesador = record
  marca: string;
  linea: string;
  cores: integer;
  velocidad: real;
  transistores: integer;
  end;

procedure leer(var proces: procesador);
begin
  writeln('Introduzca la marca del procesador: ');
  readln(proces.marca);
  writeln('Introduzca la linea del procesador: ');
  readln(proces.linea);
  writeln('Introduzca la cantidad de cores del procesador: ');
  readln(proces.cores);
  if (proces.cores<>0) then 
    begin
      writeln('Introduzca la velocidad del procesador: ');
      readln(proces.velocidad);
      writeln('Introduzca la cantidad de transistores del procesador: ');
      readln(proces.transistores);
    end;
  writeln('-----------------------------------');
end;

procedure dosCores (var proces: procesador);
begin
  if (proces.cores>2) and (proces.transistores<=22) then
    writeln('El procesador de la marca ',proces.marca,' y de la linea ',proces.linea,' tiene mas de 2 cores y al menos 22nm de transistores');
end;

procedure transistores14 (cantidad: integer; marca: string; var marca1, marca2: string; var maxi1, maxi2: integer);
begin
  if (cantidad>maxi1) then
    begin
      maxi2:=maxi1;
      marca2:=marca1;
      maxi1:=cantidad;
      marca1:=marca;
    end
  else if (cantidad>maxi2) then
    begin
      maxi2:=cantidad;
      marca2:=marca;
    end;
end;

function cantidadMulticores (proces: procesador): integer;
var 
  cantidad: integer;
begin 
  cantidad:=0;
  if ((proces.cores>1) and ((proces.marca='Intel') or (proces.marca='AMD'))) and (proces.velocidad>=2) then
    begin
      cantidad:= cantidad+1;
    end;
  cantidadMulticores:= cantidad;
end;

var
  proces: procesador;
  marcaActual,marca1, marca2: string;
  maxi1, maxi2: integer;
  cantidad14, multicores: integer;

begin
  maxi1:=0;
  maxi2:=0;
  marca1:='';
  marca2:='';
  multicores:=0;
  leer(proces);
  while (proces.cores<>0) do
    begin
      marcaActual:=proces.marca;
      cantidad14:=0;
      while(proces.marca=marcaActual) and (proces.cores<>0) do
        begin
          dosCores(proces);
          if (proces.transistores=14) then
            cantidad14:= cantidad14+1;
          multicores:= multicores+ cantidadMulticores(proces);
          leer(proces);
        end;
      transistores14(cantidad14, marcaActual, marca1, marca2, maxi1, maxi2);
    end;
  writeln('La marca con mas procesadores es: ', marca1, ' y tiene ', maxi1, ' procesadores con transistores de mas de 14nm');
  writeln('La marca con mas procesadores es: ', marca2 , ' y tiene ', maxi2, ' procesadores con transistores de mas de 14nm');
  writeln('La cantidad de procesadores multicore es: ', multicores);
end.


  