{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.}

program ejercicio1;
type
	archivo  = file of integer;
procedure agregarNumeros(var arch: archivo);
var
	numero: integer;
begin
	writeln('Ingrese un numero');
	readln(numero);
	while(numero<>30000) do
		begin
			write(arch, numero);
			readln(numero);
		end;
	close(arch);
end;

var
	nombre: string[15];
	arch:archivo;
begin
	writeln('Ingrese nombre archivo');
	readln(nombre);
	assign(arch, nombre);
	rewrite(arch);
	agregarNumeros(arch);
end.
