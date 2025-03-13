{6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular}

program ejercicio6;
type
	celular = record
		codigo:integer;
		nombre: string[20];
		descripcion: string;
		marca: string[20];
		precio: real;
		stockMin:integer;
		stock:integer;
	end;
	archivo = file of celular;
//------------leer un celular--------
procedure leerCelular(var c:celular);
begin
	writeln('Ingrese el codigo de celular: ');
	readln(c.codigo);
	if (c.codigo <> 0) then begin
		writeln('ingrese nombre celular');
		readln(c.nombre);
		writeln('Ingrese la descripcion del celular'); //Dejar un espacio para que se guarde bien el celular agregado
		readln(c.descripcion);
		writeln('Ingrese la marca del celular');
        readln(c.marca);
        writeln('Ingrese el precio del celular');
        readln(c.precio);
        writeln('Ingrese el stock minimo del celular');
        readln(c.stockMin);
        writeln('Ingrese el stock del celular');
        readln(c.stock);
    end;	
end;

//------imprimir registro------------
procedure imprimirRegistro(c:celular);
begin
	writeln('Codigo: ', c.codigo, ', Nombre: ', c.nombre, ', Descr: ', c.descripcion,
			', marca: ', c.marca, ', precio: ', c.precio, ', StockMin: ', c.stockMin,
			', Stock: ', c.stock);
end;

//------crear archivo--------------
procedure crearArchivo(var arch:archivo; var data: text);
var
	c:celular;
	nombre:string;
begin
	writeln('Ingrese nombre del archivo que se va a crear: ');
	readln(nombre);
	assign(arch, nombre);
	reset(data);
	rewrite(arch);
	while(not eof(data)) do begin
		readln(data, c.codigo, c.precio, c.marca);
		readln(data, c.stock, c.stockMin, c.descripcion);
		readln(data, c.nombre);
		write(arch, c);
	end;
	writeln('Archivo binario cargado');
	close(arch);
	close(data);	
end;

//------------informa celulares stock menor al minimo---
procedure menorQueElMinimo(var arch: archivo);
var
	c:celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch, c);
		if(c.stock < c.stockMin) then
			imprimirRegistro(c);
	end;
	close(arch);
end;

//--------imprimir con descripcion ingresada---------
procedure mismaDescripcion(var arch: archivo);
var
	c:celular;
	descripcion: string;
	posicion: integer;
begin
	reset(arch);
	writeln('Ingrese descripcion: ');
	readln(descripcion);
	while(not eof(arch)) do begin
		read(arch, c);
		posicion:=Pos(descripcion, c.descripcion);
		if(posicion>0) then
			imprimirRegistro(c);
	end;
	close(arch);		
end;

//-------Exportar a txt-------------------
procedure exportarTexto(var arch:archivo; var data:text);
var
	c:celular;
begin
	reset(arch);
	rewrite(data);
	while(not eof(arch)) do begin
		read(arch, c);
		writeln(data, c.codigo, ' ', c.precio:0:2, ' ', c.marca);
		writeln(data, c.stock, ' ', c.stockMin, ' ', c.descripcion);
		writeln(data, c.nombre);
	end;
	writeln('exportado correctamente');
	close(data);
	close(arch);
end;

//----- agregar celular-----------
procedure agregarCelulares(var arch: archivo);
var
	c:celular;
begin
	reset(arch);
	leerCelular(c);
	seek(arch, filesize(arch));
	while(c.codigo<>0) do begin
		write(arch, c);
		leerCelular(c);
	end;
	close(arch);
end;

//--------modificar stock---------
procedure modificarStock(var arch: archivo);
var
	c:celular;
	codigo:integer;
	ok:boolean;
	stock:integer;
begin
	reset(arch);
	writeln('Ingrese el codigo del celular a modificar stock');
	readln(codigo);
	ok:=false;
	while(not eof(arch)) and (not ok) do begin
		read(arch, c);
		if(c.codigo = codigo) then begin
			ok:=true;
			writeln('Ingrese nuevo stock: ');
			readln(stock);
			seek(arch, filepos(arch)-1);
			c.stock:=stock;
			write(arch, c);
			writeln('stock modificado');
		end;
	end;
	close(arch);
	if(not ok) then
		writeln('No se encontro el codigo buscado');
end;

//--------exportar productos sin stock---------
procedure exportarSinStock(var arch:archivo);
var
	sinStock:text;
	c:celular;
begin
	assign(sinStock, 'SinStock.txt');
	reset(arch);
	rewrite(sinStock);
	while(not eof(arch)) do begin
		read(arch, c);
		if(c.stock = 0) then begin
			writeln(sinStock, c.codigo, ' ', c.precio:0:2, ' ', c.marca);
			writeln(sinStock, c.stock, ' ', c.stockMin, ' ', c.descripcion);
			writeln(sinStock, c.nombre);
		end;
	end;
	close(arch);
	close(sinStock);
end;

//-----------Menu PPal---------------------
procedure menuPrincipal(var arch:archivo);
var
	data: text;
	opcion:integer;
begin
	assign(data, 'celulares.txt');
	writeln('Menu principal');
	writeln('Opcion 1: Crear un archivo de registros no ordenados de celulares');
	writeln('Opcion 2: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
    writeln('Opcion 3: Listar en pantalla los celulares cuya descripcion contenga una cadena de caracteres proporcionada');
    writeln('Opcion 4: Exportar el archivo creado a un texto celulares.txt');
    writeln('Opcion 5: Agregar un celular al final');
    writeln('Opcion 6: Modificar Stock');
    writeln('Opcion 7: Exportar lista sin stock');
    writeln('Opcion 8: Salir del menu y terminar la ejecucion del programa');
    readln(opcion);
    while(opcion<>8) do begin
		case opcion of
			1: crearArchivo(arch, data);
			2: menorQueElMinimo(arch);
			3: mismaDescripcion(arch);
			4: exportarTexto(arch, data);
			5: agregarCelulares(arch);
			6: modificarStock(arch);
			7: exportarSinStock(arch);
		else
			writeln('La opcion ingresada no corresponde a ninguna de las mostradas en el menu de opciones');
		end;
		writeln();
        writeln('MENU DE OPCIONES');
        writeln('Opcion 1: Crear un archivo de registros no ordenados de celulares');
		writeln('Opcion 2: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
        writeln('Opcion 3: Listar en pantalla los celulares cuya descripcion contenga una cadena de caracteres proporcionada');
        writeln('Opcion 4: Exportar el archivo creado a un texto celulares.txt');
        writeln('Opcion 5: Agregar un celular al final');
		writeln('Opcion 6: Modificar Stock');
		writeln('Opcion 7: Exportar lista sin stock');
		writeln('Opcion 8: Salir del menu y terminar la ejecucion del programa');
        readln(opcion);
    end;
end;

var
	arch: archivo;
begin
	menuPrincipal(arch);
end.
