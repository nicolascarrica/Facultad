{3. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}

program ejercicio3;

const VALOR_ALTO = 999;

type 
	producto = record
		codigo:integer;
		nombre: string[20];
		precio: real;
		stockActual: integer;
		stockMinimo: integer;
	end;
	
	venta = record
		codigo:integer;
		cantidad: integer;
	end;
	
	maestro = file of producto;
	detalle = file of venta;

procedure leer(var det: detalle; var v:venta);
begin
	if (not(eof(det))) then
		read(det, v)
	else
		v.codigo:= VALOR_ALTO;
end;

procedure actualizarMaestro(var mae:maestro; var det:detalle);
var
	v:venta;
	p:producto;
	codigoActual:integer;
begin
	reset(mae);
	reset(det);
	leer(det, v);
	while(v.codigo <> VALOR_ALTO) do begin
		read(mae, p);
		while(p.codigo <> v.codigo) and (not eof(mae)) do 
			read(mae, p);
		if(p.codigo = v.codigo) then begin
			codigoActual:= p.codigo;
			while(v.codigo = codigoActual) do begin
				if(p.stockActual<=v.cantidad) then
					p.stockActual:=0
				else
					p.stockActual:= p.stockActual-v.cantidad;
				leer(det, v);
			end;
			seek(mae, filepos(mae)-1);
			write(mae, p);
		end;
	end;
	close(mae);
	close(det);
end;
			
procedure generarReporte(var mae:maestro);
var
	reporte:text;
	p:producto;
begin
	assign(reporte, 'stock_minimo.txt');
	rewrite(reporte);
	reset(mae);
	while(not eof(mae)) do begin
		read(mae, p);
		if(p.stockMinimo>p.stockActual) then
			writeln(reporte, 'Codigo: ', p.codigo, 'nombre: ', p.nombre, 'Stock Acttual:', p.stockActual, 'Stock min: ', p.stockMinimo);
	end;
	close(reporte);
	close(mae);
end;

procedure crearMaestro(var mae:maestro; var carga: text);
var
	nombre: string;
	p: producto;
begin
	writeln('Ingrese nombre del maestro: ');
	readln(nombre);
	assign(mae, nombre);
	rewrite(mae);
	
	assign(carga, 'maestro.txt');
	reset(carga);
	
	while (not eof(carga)) do begin
		readln(carga, p.codigo, p.precio, p.stockActual, p.stockMinimo, p.nombre);
		write(mae, p);
	end;
	
	writeln('Archivo binario maestro creado');
	close(carga);
	close(mae);
end;

procedure crearDetalle(var det:detalle; var carga:text);
var
	nombre: string;
	v: venta;
begin
	writeln('ingrese nombre del detalle: ');
	readln(nombre);
	assign(det, nombre);
	rewrite(det);
	
	assign(carga, 'detalle.txt');
	reset(carga);
	
	while (not eof(carga)) do begin
		readln(carga, v.codigo, v.cantidad);
		write(det, v);
	end;
	writeln('Archivo binario maestro creado');
	close(carga);
	close(det);
end;

var
	cargaDetalle, cargaMaestro: text;
	mae: maestro;
	det:detalle;
begin

	crearMaestro(mae, cargaMaestro);
	crearDetalle(det, cargaDetalle);
	

	ActualizarMaestro(mae, det);
	generarReporte(mae);

end.
	
