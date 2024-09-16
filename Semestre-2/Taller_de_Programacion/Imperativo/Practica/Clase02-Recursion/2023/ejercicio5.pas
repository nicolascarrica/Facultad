// 5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el
// siguiente encabezado:
// Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
// Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
// en el vector.

program ejercicio5;
const
  dimF=20;
type
  vector = array [1..dimF] of integer;

procedure cargarVector (var v:vector; i:integer);
var
  d:integer;
begin
  if (i<=dimF) then begin
    d:=random(99)+1;
    v[i]:=d;
    cargarVector(v, i+1);
  end;
end;

procedure ordenarVector (var v:vector);
var
  i,j, actual:integer;
begin
  for i:=1 to dimF-1 do begin
    for j:=i+1 to dimF do begin
      if (v[j]<v[i]) then begin
        actual:=v[i];
        v[i]:=v[j];
        v[j]:=actual;
      end;
    end;
  end;
end;

procedure imprimirVector (v:vector; i:integer);
begin
  if(i<=dimF) then begin
    writeln('------');
    writeln(v[i]);
    imprimirVector(v, i+1);
  end;
end;

procedure busquedaDicotomica (v:vector; ini, fin, dato:integer; var pos: integer);
var
  medio: integer;
begin
  if(ini>fin) then begin
    pos:=-1;
    writeln('Elemento no encontrado');
  end
  else
    begin
      medio:=(ini+fin) div 2;
      if(v[medio]= dato) then begin
        pos:=medio;
        writeln('Elemento encontrado en la pos: ', pos);
      end
      else if (v[medio]>dato) then
        busquedaDicotomica(v, ini, medio-1, dato, pos)
      else
        busquedaDicotomica(v, medio+1, fin, dato, pos);
    end;
end;
var
  v:vector;
  indice, ini, dato, pos: integer;
begin
  randomize;
  indice:=1;
  ini:=1;
  cargarVector(v, indice);
  ordenarVector(v);
  imprimirVector(v, indice);
  writeln('-------------');
  writeln('ingrese el dato a buscar');
  readln(dato);
  busquedaDicotomica(v, ini, dimF, dato, pos)
end.