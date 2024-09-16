{
El administrador de un edificio de oficinas tiene la información del pago de las expensas
de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación 0.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.}

program oficinas;
const dimF = 300;

type
	oficina = record
		codigo:integer;
		dni:integer;
		expensa: real;
	end;
	
	vector = array [1..dimF] of oficina;
	
procedure leerOficina(var o:oficina);
begin
	o.codigo:= Random(301);
	if (o.codigo<>0) then begin
		o.dni:= Random (maxInt) + 1;
		o.expensa:= Random (1000) + 1500;
	end;
end;

procedure cargarVector(var v:vector; var dimL:integer);
var o:oficina;
begin
	dimL:=0;
	leerOficina(o);
	while(o.codigo <> 0) and (dimL<dimF) do begin
		dimL:=dimL+1;
		v[dimL]:= o;
		leerOficina(o);
	end;
end;

procedure imprimirVector(v:vector; dimL:integer);
var i:integer;
begin
	for i:=1 to dimL do begin
		writeln('oficina ',i, ':', ' Codigo ', v[i].codigo, ', dni ', v[i].dni, ', monto expensa $', v[i].expensa:2:2);
	end;
end;

procedure ordenar(var v: vector; dimL: integer);
var
    i, j, pos: integer;
    item: oficina;
begin
    for i := 1 to dimL - 1 do 
    begin
        pos := i; // Inicializamos la posición del mínimo en i
        for j := i + 1 to dimL do 
        begin
            if v[j].codigo < v[pos].codigo then
                pos := j; // Actualizamos la posición del mínimo
        end;
        // Intercambiamos el elemento mínimo con el elemento en la posición i
        item := v[pos];
        v[pos] := v[i];
        v[i] := item;
    end;
end;

procedure BusquedaDicotomica (v:vector; dimL:integer);
	procedure busquedaRecursiva (v:vector; pri, ult, dato:integer; var pos:integer);
	begin
		pos:= (pri+ult)div 2;
		if (dato=v[pos].codigo) or (pri>ult) then begin
			if (dato = v[pos].codigo) then
				writeln('Dato: ', v[pos].codigo)
			else 
				begin
					pos:=0;
				end
		end
		else
			if (dato < v[pos].codigo) then begin
				ult:=pos-1;
				busquedaRecursiva(v, pri, ult, dato, pos);
			end
			
		else
			begin
				pri:=pos+1;
				busquedaRecursiva(v, pri, ult, dato, pos);
			end;
	end;
	
var
	pri, ult, pos, dato:integer;
begin
	pri:=1;
	ult:=dimL;
	writeln('Ingrese codigo de oficina: '); readln(dato);
	busquedaRecursiva(v, pri, ult, dato, pos); 
	if pos=0 then 
		writeln('Dato no encontrado')
	else
		writeln('el dni del propietario es: ', v[pos].dni);
end;

function SumaRecursiva(v:vector; dimL:integer):real;
begin
	if (dimL>0) then
		SumaRecursiva:= v[dimL].expensa + SumaRecursiva(v, dimL-1)
	else
		SumaRecursiva:=0;
end;

function SumaNormal(v:vector; dimL:integer): real;
var suma: real;
	i:integer;
begin
	suma:=0;
	for i:=1 to dimL do begin
		suma:=suma+v[i].expensa;
	end;
	SumaNormal:=suma;
end;


var v: vector;
	dimL:integer;
	totalExpensas:real;
	totalNormal:real;
begin
	randomize;
	cargarVector(v, dimL);
	imprimirVector(v,dimL);
	ordenar(v, dimL);
	writeln;
	writeln('<--------ordenado---------->');
	imprimirVector(v, dimL);
	BusquedaDicotomica(v,dimL);
	totalExpensas:=SumaRecursiva(v,dimL);
	writeln;
	writeln('el monto total Recursivo es: ', totalExpensas:2:2);
	totalNormal:=SumaNormal(v,dimL);
	writeln;
	writeln('El monto comun es: ', totalNormal:2:2);
end.











