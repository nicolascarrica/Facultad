{
Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.
c. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.
}

program ejercicio2;
type
	r_dia=1..31;
	r_mes=1..12;
	r_anio=2010..2023;
	
	fecha =record
		dia:r_dia;
		mes:r_mes;
		anio:r_anio;
	end;
	
	venta = record
		codigo: integer;
		fecha_venta: fecha;
		cantidad: integer;
	end;
	
	vendidos = record
		codigo:integer;
		totalVendido:integer;
	end;
	
	lista =^nodito;
	nodito = record
		dato: venta;
		sig: lista;
	end;
	
	ventasListado = record
		codigo: integer;
		ventasHechas:lista;
	end;
	
	arbol1 = ^nodo1;
	nodo1 = record
		dato:venta;
		hi:arbol1;
		hd:arbol1;
	end;
	
	arbol2 = ^nodo2;
	nodo2 = record
		dato: vendidos;
		hi: arbol2;
		hd:arbol2;
	end;
	
	arbol3 = ^nodo3;
	nodo3 = record
		dato: ventasListado;
		hi: arbol3;
		hd:arbol3;
	end;


procedure agregarAdelante(var l:lista; v:venta);
var 
	nue:lista;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=l;
	l:=nue;
end;

procedure ImprimirLista(l:lista);
begin
	while (l<>nil) do begin
		writeln(' Fecha: ', l^.dato.fecha_venta.dia, '/', l^.dato.fecha_venta.mes, '/', l^.dato.fecha_venta.anio, ' Cantidad: ', l^.dato.cantidad);
		l:=l^.sig;
	end;
end;

procedure LeerFechaTeclado(var f: fecha);
begin
    writeln('Ingrese el día (1-31): ');
    readln(f.dia);
    writeln('Ingrese el mes (1-12): ');
    readln(f.mes);
    writeln('Ingrese el año (2010-2023): ');
    readln(f.anio);
end;

procedure leerFecha(var f:fecha);
begin
	f.dia:=random(31)+1;
	f.mes:=random(12)+1;
	f.anio:=random(2023 - 2010) + 2010;
end;
	
procedure leerVenta(var v:venta);
begin
	v.codigo:=random(1500);
	if (v.codigo <> 0) then begin
		leerFecha(v.fecha_venta);
		v.cantidad:= random(100)+1;
	end;
end;
	
Procedure InsertarArbol1 (var a1: arbol1; v:venta);
Begin
	if (a1 = nil) then begin
		new(a1);
		a1^.dato:= v; 
		a1^.HI:= nil; 
		a1^.HD:= nil;
	end
	else if (v.codigo < a1^.dato.codigo) then 
		InsertarArbol1(a1^.hi, v)
	else 
		InsertarArbol1(a1^.hd, v);
end;

procedure InsertarArbol2(var a2: arbol2; v:venta);
begin
	if(a2=nil) then begin
		new(a2);
		a2^.dato.codigo:=v.codigo;
		a2^.dato.totalVendido:=v.cantidad;
		a2^.hi:=nil;
		a2^.hd:=nil;
	end
	else if (v.codigo < a2^.dato.codigo) then
		InsertarArbol2(a2^.hi, v)
	else if (v.codigo = a2^.dato.codigo) then
		a2^.dato.totalVendido:= a2^.dato.totalVendido + v.cantidad
	else 
		InsertarArbol2(a2^.hd, v);
end;

procedure InsertarArbol3(var a3:arbol3; v:venta);
begin
	if (a3=nil) then begin
		new(a3);
		a3^.dato.codigo:=v.codigo;
		a3^.dato.ventasHechas:=nil;
		AgregarAdelante(a3^.dato.ventasHechas, v);
		a3^.hi :=nil;
		a3^.hd := nil;
	end
	else if (v.codigo < a3^.dato.codigo) then
    InsertarArbol3(a3^.hi, v)
  else if (v.codigo = a3^.dato.codigo) then
    AgregarAdelante(a3^.dato.ventasHechas, v)
  else
    InsertarArbol3(a3^.hd, v);
end;

procedure GenerarArboles(var a1:arbol1; var a2:arbol2; var a3:arbol3);
var
	unaVenta: venta;
begin
		writeln('<---------Generando Arboles--------->');
		a1:=nil;
		a2:=nil;
		a3:=nil;
		leerVenta(unaVenta);
		while (unaVenta.codigo<>0) do begin
			InsertarArbol1(a1, unaVenta);
			InsertarArbol2(a2, unaVenta);
			InsertarArbol3(a3, unaVenta);
			leerVenta(unaVenta);
		end;
		writeln('///////////////////////////////////');
end;

procedure imprimirArbol1(a1:arbol1);
begin
	if(a1<>nil) then begin
		imprimirArbol1(a1^.hi);
		writeln('codigo: ', a1^.dato.codigo, ' fecha: ', a1^.dato.fecha_venta.dia,'/',a1^.dato.fecha_venta.mes,'/',a1^.dato.fecha_venta.anio,' cantidad: ', a1^.dato.cantidad);
		imprimirArbol1(a1^.hd);
	end;
end;

procedure imprimirArbol2(a2:arbol2);
begin
	if(a2<>nil) then begin
		imprimirArbol2(a2^.hi);
		writeln('codigo: ', a2^.dato.codigo, ' Total vendido: ', a2^.dato.totalVendido);
		imprimirArbol2(a2^.hd);
	end;
end;

procedure imprimirArbol3(a3:arbol3);
var
	l:lista;
BEGIN
	if(a3<> nil) then begin
		imprimirArbol3(a3^.hi);
		writeln ('codigo: ', a3^.dato.codigo);
		l:= a3^.dato.ventasHechas;
		ImprimirLista(l);
		imprimirArbol3(a3^.hd);
	end;
end;

function cantidadxFecha (a1:arbol1; f:fecha):integer;
begin
	if(a1=nil) then
		cantidadxFecha:=0
	else if 
		(a1^.dato.fecha_venta.dia = f.dia) and
		(a1^.dato.fecha_venta.mes = f.mes) and
		(a1^.dato.fecha_venta.anio = f.anio) then
			cantidadxFecha:= a1^.dato.cantidad + cantidadxFecha(a1^.hi,f) + cantidadxFecha(a1^.hd,f)
	else
     cantidadxFecha := cantidadxFecha(a1^.hi, f) + cantidadxFecha(a1^.hd, f);
end;

procedure CodigoMasUnidades(a2:arbol2);
	procedure actualizarMaximo (a2:arbol2; var maximo:integer; var codigoMax:integer);
	begin
	if (a2<>nil) then begin
		if(a2^.dato.totalVendido > maximo) then begin
			maximo:= a2^.dato.totalVendido;
			codigoMax:=a2^.dato.codigo
		end;
		actualizarMaximo (a2^.hi,maximo,codigoMax);
		actualizarMaximo (a2^.hd,maximo,codigoMax);
	end;
	end;
var 
	codigoMax:integer;
	maximo:integer;
begin
	maximo:=-1;
	actualizarMaximo(a2, maximo, codigoMax);
	writeln('El producto con mas unidades vendidas es: ', codigoMax);
end;

procedure CodigoMasCantidadVentas(a3:arbol3);
	function ContarNodos(l:lista):integer;
	begin
		if(l<>nil) then
			ContarNodos:= 1 + ContarNodos(l^.sig)
		else
			ContarNodos:=0;
	end;
	
	procedure ActualizarMaximo(a3:arbol3;var cantidadMax:integer; var codMax:integer);
	var
		ventasContadas:integer;
	begin
		if(a3<>nil)then begin
			ventasContadas:=ContarNodos(a3^.dato.ventasHechas);
			
			if(ventasContadas > cantidadMax) then begin
				cantidadMax:= ventasContadas;
				codMax:= a3^.dato.codigo;
			end;
			ActualizarMaximo(a3^.hi,cantidadMax, codMax);
			ActualizarMaximo(a3^.hd,cantidadMax, codMax);
		end;
	end;
	
var
	cantidadMax:integer;
	codMax:integer;
begin
	cantidadMax:=-1;
	ActualizarMaximo(a3, cantidadMax, codMax);
	writeln('El producto con mas cantidad vendidas es: ', codMax);
end;
var
	arboli:arbol1;
	arbolii:arbol2;
	arboliii:arbol3;
	totalXFecha:integer;
	f:fecha;
begin
	randomize;
	GenerarArboles(arboli,arbolii,arboliii);
	writeln('-------arbol 1--------');
	writeln;
	imprimirArbol1(arboli);
	writeln('-------arbol 2--------');
	writeln;
	imprimirArbol2(arbolii);
	writeln('-------arbol 3--------');
	writeln;
	imprimirArbol3(arboliii);
	writeln;
	writeln('--------------------');
	writeln('Ingrese fecha: ');
	LeerFechaTeclado(f);
	writeln;
	totalXFecha:= cantidadxFecha(arboli, f);
	writeln('la cantidad para esa fecha fue: ', totalXFecha);
	writeln;
	CodigoMasUnidades(arbolii);
	writeln;
	CodigoMasCantidadVentas(arboliii);
	
end.
		

			
	
	
	
	
	
