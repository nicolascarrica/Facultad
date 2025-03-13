{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}

program ejercicio2;
type
	archivo = file of integer;
procedure procesarArchivo(var arch: archivo; var cant: integer; var promedio: real);
var
	numero:integer;
begin
	while(not EOF(arch)) do begin
		read(arch, numero);
		writeln(numero);
		if(numero < 1500) then
			cant +=1;
		promedio+=numero;
	end;
	promedio:= promedio/fileSize(arch);
end;

var
	nombre: string[15];
	arch:archivo;
	menores1500: integer;
	promedio: real;
begin
	menores1500:=0;
	promedio:=0;
	writeln('Ingrese nombre archivo');
	readln(nombre);
	assign(arch, nombre);
	reset(arch);
	procesarArchivo(arch, menores1500, promedio);
	writeln('Cantidad de numeros menores a 1500: ', menores1500);
	writeln('Promedio de los numeros ingresados: ', promedio:0:2);
end.

