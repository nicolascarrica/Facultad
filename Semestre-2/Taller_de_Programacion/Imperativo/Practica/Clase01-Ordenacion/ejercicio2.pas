// El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
// las expensas de dichas oficinas.
// Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
// a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
// se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
// finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
// b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
// oficina.
// c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.

program ejercicio2;
const dimF=300;
type
  oficina = record
    codigo: integer;
    dni_prop: integer;
    costo_expensa: real;
  end;

  vector_of = array [1..dimF] of oficina;

procedure LeerOficina (var ofi:oficina);
begin
  Randomize;
  writeln('Ingrese el codigo de identificacion');
  readln(ofi.codigo);
  if (ofi.codigo<>-1) then begin
    writeln('Ingrese el dni del propietario');
    readln(ofi.dni_prop);
    writeln('Ingrese el valor de la expensa');
    ofi.costo_expensa := Random(10000) + 1;
  end;
end;


procedure CargarVector (var v:vector_of; var dimL:integer);
var
  ofi: oficina;
begin
  dimL:=0;
  LeerOficina (ofi);
  while (ofi.codigo <> -1) and (dimL < dimF) do
  begin
    dimL:=dimL+1;
    v[dimL]:=ofi;
    LeerOficina (ofi);
  end;
end;

procedure ImprimirVector (var v:vector_of; dimL:integer);
var
  i: integer;
begin
  for i:=1 to dimL do begin
    writeln('El codigo de identificacion es: ', v[i].codigo);
    writeln('El dni del propietario es: ', v[i].dni_prop);
    writeln(' El valor de la expensa es: ', v[i].costo_expensa:0:2);
    writeln('-------------------');
  end;
end;

procedure OrdenarInsersion (var v:vector_of; dimL:integer);
var
  i,j:integer;
  aux: oficina;
begin
  for i:=2 to dimL do begin
    aux:= v[i];
    j:=i-1;
    while (j>0) and (v[i].codigo > aux.codigo) do begin
      v[j+1]:=v[j];
      j:=j-1;
    end;
    v[j+1]:=aux;
  end;
end;

procedure OrdenarSeleccion (var v:vector_of; dimL:integer);
var
  i,j,pos: integer;
  item: oficina;
begin
  for i:=1 to dimL-1 do begin
    pos:= i;
    for j:=i+1 to dimL do
      if v[j].codigo < v[pos].codigo then pos:=j;
    item := v[pos];
    v[pos] := v[i];
    v[i] := item;
  end;
end;

var
  v: vector_of;
  dimL: integer;

begin
  CargarVector(v, dimL);
  writeln('---vector sin orden---');
  ImprimirVector(v, dimL);
  
  OrdenarSeleccion(v, dimL);
  writeln('---vector ordenado por seleccion---');
  ImprimirVector(v, dimL);
  
  OrdenarInsersion(v, dimL);
  writeln('---vector ordenado por insersion---');
  ImprimirVector(v, dimL);
  
end.

