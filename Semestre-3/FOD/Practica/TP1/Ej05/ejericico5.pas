{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares deben contener: código de celular, nombre,
descripción, marca, precio, stock mínimo y stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas. En la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}

program ejercicio5;
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

//------imprimir registro------------
procedure imprimirRegistro(c:celular);
begin
	writeln('Codigo: ', c.codigo, ', Nombre: ', c.nombre, ', Descr: ', c.descripcion,
			', marca: ', c.marca, ', precio: ', c.precio, ', StockMin: ', c.stockMin,
			', Stock: ', c.stock);
end;

//----------------Inciso A--------------------
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
	close(data);
	close(arch);	
end;

//--------------Inciso B---------------------
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

//---------------Inciso C-----------------
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

//-------------Inciso D-------------------
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

//------------------------Menu--------------------------
procedure menuPrincipal(var arch:archivo; var data: text);
var
	opcion:integer;
begin
	writeln('Menu principal');
	writeln('Opcion 1: Crear un archivo de registros no ordenados de celulares');
	writeln('Opcion 2: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
    writeln('Opcion 3: Listar en pantalla los celulares cuya descripcion contenga una cadena de caracteres proporcionada');
    writeln('Opcion 4: Exportar el archivo creado a un texto celulares.txt');
    writeln('Opcion 5: Salir del menu y terminar la ejecucion del programa');
    readln(opcion);
    while(opcion<>5) do begin
		case opcion of
			1: crearArchivo(arch, data);
			2: menorQueElMinimo(arch);
			3: mismaDescripcion(arch);
			4: exportarTexto(arch, data);
		else
			writeln('La opcion ingresada no corresponde a ninguna de las mostradas en el menu de opciones');
		end;
		writeln();
        writeln('MENU DE OPCIONES');
        writeln('Opcion 1: Crear un archivo de registros no ordenados de celulares');
		writeln('Opcion 2: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
        writeln('Opcion 3: Listar en pantalla los celulares cuya descripcion contenga una cadena de caracteres proporcionada');
        writeln('Opcion 4: Exportar el archivo creado a un texto celulares.txt');
        writeln('Opcion 5: Salir del menu y terminar la ejecucion del programa');
        readln(opcion);
    end;
end;

var
	arch:archivo;
	data: text;
begin
	assign(data, 'celulares.txt');
	menuPrincipal(arch, data);
end.

// black point 18 ,brillo 15,contraste 29  exposure -43
