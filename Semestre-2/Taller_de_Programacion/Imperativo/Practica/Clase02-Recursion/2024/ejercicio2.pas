{
2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}

program ejercicio2cl2;
const
	min=100;
	max=200;
type
	lista=^nodo;
	nodo =record
		dato:integer;
		sig:lista;
	end;
procedure agregarAdelante (var l:lista; numero:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=numero;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista (var l:lista); //a
var 
	valor:integer;
begin
	valor:= min + random(max-min + 1);
	if( valor <> 100) then begin
		cargarLista(l);
		agregarAdelante(l, valor);
	end
	else l:=nil;
end;


procedure imprimirLista(l:lista); // b
begin
	if (l<>nil) then begin
		write(' ', l^.dato);
		imprimirLista(l^.sig);
	end;
end;
		
procedure imprimirListaInvertida(l:lista); //c
begin
	if(l<>nil) then begin
		imprimirListaInvertida(l^.sig);
		write(' ', l^.dato);
	end;
end;

function obtenerMinimo(l:lista):integer; //D
	function minimoRecursivo(l:lista; minimo: integer):integer;
	begin
		if(l = nil) then
			minimoRecursivo:= minimo
		else begin
			if (l^.dato<minimo) then
				minimo:=l^.dato;
			minimoRecursivo:=minimoRecursivo(l^.sig, minimo);
		end;
	end;
var
	minimo:integer;
begin
	minimo:= max + 1;
	obtenerMinimo:=minimoRecursivo(l,minimo);
end;

function buscarValor(l:lista; valor:integer): boolean;
begin
	if (l<>nil) then begin
		if(l^.dato = valor) then
			buscarValor:= true
		else
			buscarValor:=buscarValor(l^.sig, valor);
	end
	else 
		buscarValor:=false;
end;


var
	l:lista;
	minimo, valor: integer;
	existe: boolean;
begin
	randomize;
	l:=nil;
	cargarLista(l);
	writeln('Orden normal: ');
	writeln;
	imprimirLista(l);
	writeln;
	writeln;
	writeln('Orden Inverso: ');
	writeln;
	imprimirListaInvertida(l);
	writeln;
	writeln;
	minimo:=obtenerMinimo(l);
	writeln('el minimo valor de la lista es: ', minimo);
	writeln;
	writeln;
	write ('Ingrese un valor a buscar: ');
	read(valor);
	existe:= buscarValor(l, valor);
	writeln;
  writeln;
	if (existe) then
		writeln('el ', valor, ' esta en la lista')
	else
		writeln('el ', valor, ' no esta en la lista');
	
	
	
	
end.
	
