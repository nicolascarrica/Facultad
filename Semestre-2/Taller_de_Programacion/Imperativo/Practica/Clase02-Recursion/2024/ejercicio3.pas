{
3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).
. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}
program ejercicio3cl2;
const
	dimF=20;
	max=1550;
	min=300;

type
	vector = array [1..dimF] of integer;
	
procedure CargarVector (var v:vector);
	
	procedure CargarVectorRecursivo(var v:vector; i:integer);
	var
		valor:integer;
	begin
		valor:= min + Random(max-min+1);
		if(i <= dimF) then begin
			v[i]:=valor;
			CargarVectorRecursivo(v, i+1);
		end;
	end;

var
	i:integer;
begin
	i:=1;
	CargarVectorRecursivo(v,i);
end;

procedure Imprimirvector (v:vector);
var i:integer;
begin
	for i:=1 to dimF do begin
		write(v[i], ' | ');
	end;
end;

procedure ordenarVector(var v:vector);
var
	i,j, pos:integer;
begin
	for i:=1 to dimF-1 do begin
		for j:=i+1 to dimF do begin
			if(v[j]<v[i]) then begin
				pos:=v[i];
				v[i]:=v[j];
				v[j]:=pos;
			end;
		end;
	end;
end;

procedure busquedaDicotomica (v:vector; ini, fin, dato:integer; var pos: integer);
var
	medio:integer;
begin
end;

var
	v:vector;
begin
	CargarVector(v);
	writeln('vecto normal');
	Imprimirvector(v);
	writeln;
	writeln;
	ordenarVector(v);
	writeln('Vector Ordenado');
	Imprimirvector(v);
	
end.


