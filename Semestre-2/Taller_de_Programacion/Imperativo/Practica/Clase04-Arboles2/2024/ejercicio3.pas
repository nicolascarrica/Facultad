{
Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.}

program libreria;

type
	venta = record
		codigoV: integer;
		codigoP:integer;
		unidadesVendidas:integer;
		precioUnitario: real;
	end;
	
	productos = record
		codigo:integer;
		cantidad:integer;
		montoTotal:real;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: productos;
		hi:arbol;
		hd:arbol;
	end;
	
procedure ModuloA(var a:arbol);

	procedure LeerVenta(var v: venta);
	begin
		v.codigoV:=random(1000) - 1;
		if (v.codigoV <> -1) then begin
			v.codigoP:= random(1000)+1;
			v.unidadesVendidas:=random(25) + 1;
			v.precioUnitario:= random (1000) + 1;
		end;
	end;
	
	procedure armarArbol(var a:arbol; v:venta);
	begin
		if (a=nil) then begin
			new(a);
			a^.dato.codigo:=v.codigoP;
			a^.dato.cantidad:=v.unidadesVendidas;
			a^.dato.montoTotal:=v.precioUnitario*v.unidadesVendidas;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if(v.codigoP = a^.dato.codigo) then begin
				a^.dato.cantidad:= a^.dato.cantidad + v.unidadesVendidas;
				a^.dato.montoTotal:= a^.dato.montoTotal + v.precioUnitario*v.unidadesVendidas;
			end
		else if (v.codigoP < a^.dato.codigo) then
			armarArbol(a^.hi, v)
		else
			armarArbol(a^.hd,v);
	end;

var 
		unaVenta:venta;
begin
	writeln('Generando Arbol de productos');
	writeln;
	LeerVenta(unaVenta);
	while (unaVenta.codigoV <> -1) do begin
		armarArbol(a, unaVenta);
		LeerVenta(unaVenta);
	end;
end;

procedure ImprimirArbol (a:arbol);
begin
	if (a<>nil) then begin
		ImprimirArbol(a^.hi);
		writeln(
			'codigo Producto: ', a^.dato.codigo, 
			' Cantidad Vendida: ', a^.dato.cantidad,
			' Monto total: ', a^.dato.montoTotal:2:2
		);
		ImprimirArbol(a^.hd);
	end;
end;

procedure ModuloC(a:arbol);
	procedure Maximo(a:arbol; var codMax: integer; var maxUnidades: integer);
	begin
		if (a<>nil) then begin
			if (a^.dato.cantidad > maxUnidades) then begin
				maxUnidades:=a^.dato.cantidad;
				codMax:= a^.dato.codigo;
			end;
			Maximo(a^.hi, codMax, maxUnidades);
			Maximo(a^.hd, codMax, maxUnidades);
		end;
	end;
var
	codigoMax: integer;
	unidadesMax:integer;
begin
	unidadesMax:=-1;
	Maximo(a, codigoMax, unidadesMax);
	writeln;
	writeln;
	writeln('el producto que vendio mas es: ', codigoMax);
end;

procedure ModuloD (a:arbol);
	function cantidad(a:arbol; numero:integer): integer;
	begin
		if(a= nil) then
			cantidad:=0
		else if (numero > a^.dato.codigo) then
			cantidad:= 1+ cantidad(a^.hi, numero) + cantidad(a^.hd, numero)
		else
			cantidad:=cantidad(a^.hi, numero)+cantidad(a^.hd, numero);
	end;
var
	n,menores:integer;
begin
	
	writeln;
	writeln('ingrese un valor: '); readln(n);
	menores:=cantidad(a, n);
	writeln('La cantidad de productos menores a ese valor es: ', menores);
	
end;

procedure ModuloE (a:arbol);
	function cantidad (a:arbol; cod1, cod2: integer):real;
	begin
		if(a=nil) then
			cantidad:=0
		else if(a^.dato.codigo > cod1) and (a^.dato.codigo<cod2) then
			cantidad:= a^.dato.montoTotal + cantidad(a^.hi, cod1, cod2) + cantidad	(a^.hd, cod1, cod2)
		else if (a^.dato.codigo <= cod1) then
			cantidad:=cantidad(a^.hd, cod1, cod2)
		else 
			cantidad:=cantidad(a^.hi, cod1, cod2);
	end;
var
	cod1, cod2:integer;
	monto:real;
begin
	writeln;
	writeln('ingrese valor cod1: '); readln(cod1);
	writeln;
	writeln('ingrese valor cod2: '); readln(cod2);
	monto:=cantidad(a, cod1, cod2);
	
	writeln('el monto total de esos productos es: ', monto:2:2);
end;
	

var
	a:arbol;
begin
	randomize;
	ModuloA(a);
	ImprimirArbol(a); //inciso b
	ModuloC(a);
	ModuloD(a);
	ModuloE(a);
end.	
		
