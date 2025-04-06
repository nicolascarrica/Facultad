{
Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto}

program ejercicio5;

const
	val_alto = 999;
	DF = 3; // es 30 en el ejercicio;

type
	subrango = 1..DF;
	producto = record
		codigo: integer;
		nombre: string;
		descripcion: string;
		stockDisp: integer;
		stockMin: integer;
		precio: real;
	end;
	
	infoDetalle = record
		codigo: integer;
		cantVendida:  integer;
	end;
	
	maestro = file of producto;
	detalle = file of infoDetalle;
	vectorDetalle = array (subrango] of detalle;
	vectorRegistros = array [subrango] of registro;

procedure leer(var det: detalle; var infoDet: infoDetalle);
begin
	if(not eof(det)) then
		read(det, infoDet)
	else
		infoDet.codigo:= val_alto;
end;

procedure minimo(var vecDet: vectorDetalle; var vecReg: vectorRegistros; var min: infoDetalle);
var i, pos: integer;
begin
	min.codigo:=val_alto;
	for i:=1 to DF do 
		if(vecReg[i].codigo < min.codigo) then begin
			min:= vecReg[i];
			pos:=i;
		end;
		if(min.codigo <> val_alto) then
			leer(vecDet[pos], vecReg[pos]);
end;


procedure reporte (var mae:maestro):
var
	p:producto;
	txt: text;
begin
	reset(mae)
procedure actualizarMaestro(var mae: maestro; var vecDet: vectorDetalle);
var
	min:infoDetalle;
	infoMae: producto;
	vecReg: vectorRegistros;
	i:subrango;
	actual, cant:integer;
begin
	reset(mae);
	for i:=1 to DF do begin
		reset(vecDet[i]);
		leer(vecDet[i]; vecReg[i]);
	end;
	minimo(vecDet, vecReg, min);
	while(min.codigo <> val_alto) do begin
		actual:= min.codigo;
		cant:=0;
		while(min.codigo<>val_alto) and (min.codigo = actual) do begin
			cant:= cant + min.cant;
			minimo(vec, vecReg, min);
		end;
		read(mae, infoMae);
		while(infoMae.codigo <> aux) do
			read(mae, infoMae);
		seek(mae, filepos(mae)-1);
		infoMae.stockDisp:= infoMae.stockDisp - cant;
		write(mae, infoMae);
	end;
	close(mae);
	for i:=1 to DF do
		close(vec[i]);
end;

