{4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
un número de empleado ya registrado (control de unicidad).
b. Modificar la edad de un empleado dado.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado..}

program ejercicio3;
type
    empleado = record
        numero: integer;
        apellido: string[20];
        nombre: string[20];
        edad: integer;
        dni: integer;
    end;
    archivo = file of empleado;

procedure imprimirUnEmpleado(e: empleado);
begin
    writeln('Numero: ', e.numero, ', Apellido: ', e.apellido, ', Nombre: ', e.nombre, ', Edad: ', e.edad, ', DNI: ', e.dni);
end;
//---------------A-----------------
procedure leerEmpleado(var e: empleado);
begin
    writeln('Ingrese el apellido del empleado');
    readln(e.apellido);
    if(e.apellido<> 'fin') then
        begin
            writeln('Ingrese el nombre del empleado');
            readln(e.nombre);
            writeln('Ingrese el numero del empleado');
            readln(e.numero);
            writeln('Ingrese edad del empleado');
            readln(e.edad);
            writeln('Ingrese el DNI del empleado');
            readln(e.dni);
        end;
end;

procedure cargarEmpleados(var arch: archivo);
var
    e:empleado;
begin
	rewrite(arch);
    leerEmpleado(e);
    while(e.apellido <> 'fin') do begin
        write(arch, e);
        leerEmpleado(e);
    end;
    close(arch);
end;
//----------------------B-------------------------
function cumple(nombre, apellido, dato:string): boolean;
begin
    cumple:= ((nombre = dato) or (apellido = dato));
end;
procedure empleadosX(var arch: archivo);
var
    dato: string[20];
    e:empleado;
begin
    reset(arch);
    writeln('Ingrese nombre o apellido de empleado');
    readln(dato);
    writeln('Emleados que tienen nombre o apellido iguales a ', dato,': ');
    while(not EOF(arch)) do begin
        read(arch, e);
        if(cumple(e.nombre, e.apellido, dato)) then
            imprimirUnEmpleado(e);
    end;
    close(arch);
end;

procedure imprimirEmpleados(var arch: archivo);
var
    e:empleado;
begin
    reset(arch);
    writeln('Listado de empleados: ');
    while(not EOF(arch)) do begin
        read(arch, e);
        imprimirUnEmpleado(e);
    end;
    close(arch);
end;

//--------------mayores 70 --------------

procedure mayores70(var arch: archivo);
var
    e:empleado;
begin
    reset(arch);
    writeln('Lista de empleados mayores a 70 de anios, prontos a jubilarse: ');
    while(not EOF(arch)) do begin
        read(arch, e);
        if(e.edad > 70) then
            imprimirUnEmpleado(e);
    end;
    close(arch);
end;
//------------------Aregar Empleados al final-----
function controlUnicidad(var arch: archivo; numero:integer):boolean;
var
	e:empleado;
	repetido:boolean;
begin
	seek(arch, 0); //puntero al inicio
	repetido:= false;
	while(not EOF(arch)) and (not repetido) do begin
		read(arch, e);
		if(e.numero = numero) then
			repetido:=true;
	end;
	controlUnicidad:= repetido;
end;

procedure agregarEmpleado(var arch:archivo);
var
	e:empleado;
begin
	reset(arch);
	leerEmpleado(e);
	while(e.apellido<>'fin') do begin
		if(not(controlUnicidad(arch, e.numero))) then begin
			seek(arch, fileSize(arch));
			write(arch, e);
			writeln('Empleado agregado.');
		end
		else
			writeln('ERROR: El empleado con número ', e.numero, ' ya existe.');
		leerEmpleado(e);
		reset(arch);
	end;
	close(arch);
end;
//------------------Modificar Edad----------------
procedure modificarEdad(var arch:archivo);
var
	numero, edad: integer;
	e:empleado;
	encontre:boolean;
begin
	reset(arch);
	writeln('Ingrese numero de empleado');
	readln(numero);
	encontre:=false;
	while(not EOF(arch)) and (not encontre) do begin
		read(arch, e);
		if(e.numero = numero) then begin
			encontre:=true;
			writeln('Ingrese nueva edad: ');
			readln(edad);
			e.edad:=edad;
			seek(arch, filePos(arch)-1);
			write(arch, e);
		end;
	end;
	if(encontre) then
		writeln('Se modifico la edad del empleado con numero ', numero)
	else writeln('No se encontro el empleado ', numero);
	close(arch);
end;
//------------Exportar Texto de todos los empleados-------------
procedure exportarTexto(var arch:archivo);
var
	archivoTxt: text;
	e:empleado;
begin
	assign(archivoTxt,'total_empleados.txt');
	reset(arch);
	rewrite(archivoTxt);
	while(not EOF(arch)) do begin
		read(arch, e);
		with e do writeln(archivoTxt, ' ', numero, ' ', apellido, ' ', nombre, ' ', edad, ' ', dni);
	end;
	 writeln('Archivo de texto del contenido del archivo exportado correctamente');
	 close(arch);
	 close(archivoTxt);
end;

//----------------Exportar Sin DNI-------------------
procedure exportarSinDNI(var arch: archivo);
var
	archivoTxt:text;
	e:empleado;
begin
	assign(archivoTxt, 'empleadoSinDNI.txt');
	reset(arch);
	rewrite(archivoTxt);
	while (not EOF(arch)) do begin
		read(arch, e);
		if(e.dni=00) then
			with e do writeln(archivoTxt, ' ', numero, ' ', apellido, ' ' ,nombre, ' ', edad);
	end;
	writeln('Archivo de texto de los empleados que no tengan cargado el DNI exportado correctamente');
    close(arch);
    close(archivoTxt);
end;
//-------------------MENU--------------------------
procedure menuInicial(var arch:archivo);
var
    opcion: integer;
begin
    writeln('MENU PRINCIPAL: Ingrese una opcion');
    writeln('Opcion 1: Lista de empleados segun nombre o apellido elegido');
    writeln('Opcion 2: Lista de etodos los empleados de a uno por linea');
    writeln('Opcion 3: Lista de empleados mayores a 70 años');
    writeln('Opcion 4: Aregar empleados');
    writeln('Opcion 5: Modificar Edad');
    writeln('Opcion 6: Exportar lista de empleados');
    writeln('Opcion 7: Exportar empleados sin dni');
    writeln('Opcion 8: salir del programa');
    readln(opcion);
    while(opcion<>8) do begin
        case opcion of
            1: empleadosX(arch);
            2: imprimirEmpleados(arch);
            3: mayores70(arch);
            4: agregarEmpleado(arch);
            5: modificarEdad(arch);
            6: exportarTexto(arch);
            7: exportarSinDNI(arch);
        else
            writeln('Opcion incorrecta');
        end;
        writeln();
        writeln('MENU PRINCIPAL: Ingrese una opcion');
        writeln('Opcion 1: Lista de empleados segun nombre o apellido elegido');
        writeln('Opcion 2: Lista de etodos los empleados de a uno por linea');
        writeln('Opcion 3: Lista de empleados mayores a 70 años');
        writeln('Opcion 4: Aregar empleados');
		writeln('Opcion 5: Modificar Edad');
		writeln('Opcion 6: Exportar lista de empleados');
		writeln('Opcion 7: Exportar empleados sin dni');
		writeln('Opcion 8: salir del programa');
        
        readln(opcion);
    end;
end;

//-----------------Programa------------------

var
    arch: archivo;
    nombre: string[15];
begin
    writeln('Inrese nombre archivo');
    readln(nombre);
    assign(arch, nombre);
    rewrite(arch);
    cargarEmpleados(arch);
    menuInicial(arch);
end.






