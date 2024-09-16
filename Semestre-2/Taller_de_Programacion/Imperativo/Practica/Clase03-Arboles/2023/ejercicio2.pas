{
Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}

program ejercicio2;
type
	r_mes = 1..12;
	r_dia = 1..31;
	
	fecha=record
		dia:r_dia;
		mes:r_mes;
		anio:integer;
	end;
	
	venta = record
		codigo:integer;
		fecha_venta:fecha;
		cantidad:integer;
	end;
	
	arbol=^nodo;
	nodo = record
		dato: venta;
		HI: arbol;
		HD: arbol;
	end;
	
procedure leerFecha(var f:fecha);
begin
	writeln('ingresa dia: ');
	readln(f.dia);
	writeln('ingresa mes: ');
	readln(f.mes);
	writeln('ingresa anio: ');
	readln(f.anio);
end;
	
procedure leerVenta (var v:venta);
begin
	writeln('LECTRUA DE VENTAS');
	writeln('Ingrese codigo de venta: ');
	readln(v.codigo);
	if(v.codigo<>0) then begin
		writeln('ingrese fecha de veta: ');
		leerFecha(v.fecha_venta);
		writeln('ingrese cantidad vendida: ');
		readln(v.cantidad);
	end;
end;

procedure agregar (var a:arbol; v:venta);
begin
	if (a=nil) then begin
		new(a);
		a^.dato:=v;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if (v.codigo <= a^.dato.codigo) then // <= permite varias ventas con el mismo codigo
		agregar(a^.HI,v)
	else
		agregar(a^.HD,v);
end;

procedure agregarCantidad (var a:arbol; v:venta);
begin
	if(a=nil) then begin
		new(a);
		a^.dato.codigo:=v.codigo;
		a^.dato.cantidad:=v.cantidad;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if (v.codigo = a^.dato.codigo) then
		a^.dato.cantidad:= a^.dato.cantidad + v.cantidad
	else if (v.codigo < a^.dato.codigo) then
		agregarCantidad(a^.HI,v)
	else
		agregarCantidad(a^.HD,v);
end;

procedure armarArbol (var a, av:arbol);
var
	v:venta;
begin
	leerVenta(v);
	if(v.codigo<>0) then begin
		armarArbol(a, av);
		agregar(a,v);
		agregarCantidad(av,v)
	end
	else
		a:=nil;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.HI);
		writeln('codigo de venta: ', a^.dato.codigo);
		writeln('fecha deventa: ', a^.dato.fecha_venta.dia,'/', a^.dato.fecha_venta.mes,'/', a^.dato.fecha_venta.anio);
		writeln('cantidad vendida: ', a^.dato.cantidad);
		imprimirArbol(a^.HD);
	end
end;

procedure imprimirArbolVendidos(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbolVendidos(a^.HI);
		writeln('codigo de venta: ', a^.dato.codigo);
		writeln('cantidad vendida: ', a^.dato.cantidad);
		imprimirArbolVendidos(a^.HD);
	end
end;

function buscarCantidad(a: arbol; codigo: integer): integer;
begin
    if a = nil then // preguntar como se hace la funcion//
        buscarCantidad := 0
    else if codigo < a^.dato.codigo then
        buscarCantidad := buscarCantidad(a^.HI, codigo)
    else if codigo > a^.dato.codigo then
        buscarCantidad := buscarCantidad(a^.HD, codigo)
    else
        buscarCantidad := a^.dato.cantidad + buscarCantidad(a^.HI, codigo) + buscarCantidad(a^.HD, codigo);
end;

function buscarCantidad2(a:arbol; codigo:integer):integer;
begin
    if a = nil then 
        buscarCantidad2 := 0
    else if (a^.dato.codigo = codigo) then
		buscarCantidad2:= a^.dato.cantidad
    else if codigo > a^.dato.codigo then
        buscarCantidad2 := buscarCantidad2(a^.HD, codigo)
    else 
        buscarCantidad2 := buscarCantidad2(a^.HI, codigo);
end;


		
var
	a,av:arbol;
	cantidadProducto, cantidadProducto2: integer;
	codigo:integer;
begin
	a:=nil;
	av:=nil;
	cantidadProducto:=0;
	cantidadProducto2:=0;
	//inciso a
	armarArbol(a,av);
	writeln('--ARBOL VENTAS--');
	imprimirArbol(a);
	writeln('--ARBOL PRODUCTOS VENDIDOS--');
	imprimirArbolVendidos(av);
	//inciso b
	writeln('Ingrese codigo de producto: ');
	readln(codigo);
	cantidadProducto:=buscarCantidad(a, codigo);
	writeln('La cantidad del poducto ', codigo,' es ', cantidadProducto);
	// inciso c
	cantidadProducto2:=buscarCantidad2(av, codigo);
	
end.
		
