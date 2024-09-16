{
Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).
}

program ejercicio1;
type
	venta = record
		codigoVenta:integer;
		codigoProducto: integer;
		cantidadUnidades: integer;
		precioUnitario:real;
	end;
	
	productoVendido = record
		codigo:integer;
		cantTotalUnidades:integer;
		montoTotal:real;
	end;
	
	arbol=^nodo;
	nodo = record
		dato:productoVendido;
		hi:arbol;
		hd:arbol;
	end;
	
procedure ModuloA(var a:arbol);
	
	procedure leerVenta(var v:venta);
		begin
			v.codigoVenta:=Random(200) - 1;
			if (v.codigoVenta <>-1) then begin
				v.codigoProducto:=Random(500);
				v.cantidadUnidades:=Random(20)+1;
				v.precioUnitario:=Random(2000)/(Random(10)+1);
			end;
	end;
	
	procedure agregar(var a:arbol; v:venta);
		var p: productoVendido;
		procedure ArmarProducto(var p:productoVEndido; v:venta);
			begin
				p.codigo:=v.codigoProducto;
				p.cantTotalUnidades:=v.cantidadUnidades;
				p.montoTotal:=v.cantidadUnidades*v.precioUnitario;
		end;
		
	begin
			if(a=nil) then begin
				new(a);
				ArmarProducto(p, v);
				a^.dato:=p;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else if (v.codigoProducto = a^.dato.codigo) then begin
				a^.dato.cantTotalUnidades:= a^.dato.cantTotalUnidades + v.cantidadUnidades;
				a^.dato.montoTotal:= a^.dato.montoTotal + (v.cantidadUnidades*v.precioUnitario);
			end
			else if (v.codigoProducto < a^.dato.codigo) then
				agregar(a^.hi, v)
			else
				agregar(a^.hd,v);
end;

var unaVenta:venta;
begin
	writeln;
	writeln('--inreso de ventaas y armado de arbol de prod--');
	writeln;
	a:=nil;
	leerVenta(unaVenta);
	while (unaVenta.codigoVenta<>-1) do begin
		agregar(a, unaVenta);
		leerVenta(unaVenta);
	end;
	writeln;
	writeln('--------------------------------');
end;

procedure ModuloB (a:arbol);
	procedure imprimirArbol(a:arbol);
	begin
		if(a<>nil) then begin
			if (a^.hi <> nil) then 
				imprimirArbol(a^.hi);
			writeln('Codigo producto :', a^.dato.codigo, ' Cantidad unidades: ', a^.dato.cantTotalUnidades, ' precio total: ', a^.dato.montoTotal:2:2);
			if (a^.hd <>nil) then
				imprimirArbol(a^.hd);
		end;
	end;
	
begin
	writeln;
	writeln('Impresion datos');
	writeln;
	if(a=nil) then
		writeln('arbol vacio')
	else
		imprimirArbol(a);
	writeln;
	writeln('---------------');
end;

var
	a:arbol;
begin
	Randomize;
	ModuloA(a);
	ModuloB(a);
end.
	
	
