{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program ejercicio1;
type
	empleado = record
		codigo: integer;
		nombre: string[20];
		comision: real;
	end;
	archivoComisiones = file of empleado;
	
procedure compactar(var arch: archivoComisiones; var nuevoArch: archivoComisiones);
var
	registro, empleadoActual: empleado;
	totalComision:real;
begin
	reset(arch); //abre el archivo original
	rewrite(nuevoArch); // crea el nuevo archivo;
	
	if not eof(arch) then begin
		read(arch, empleadoActual); //leer el primer empleado;
		
		while (not eof(arch)) do begin
			totalComision:=0; //incia el contador de comision;
			registro.codigo:=empleadoActual.codigo;
			registro.nombre:=empleadoActual.nombre;
			
			while (not eof(arch)) and (empleadoActual.codigo = registro.codigo) do begin
				totalComision:= totalComision + empleadoActual.comision;
				read(arch, empleadoActual); //lee el siguiente empleado
			end;
			registro.comision:=totalComision;
			write(nuevoArch, registro);
		end;
	end;
	close(arch);
	close(nuevoArch);
end;


var
	arch, nuevoArch: archivoComisiones;
begin
	assign(arch, 'comisiones.dat');
	assign(nuevoArch,'compactados.dat');
	compactar(arch, nuevoarch);
	writeln('proceso de compactacion realizado');
end.
// no va a funcionar porque los archivos comisiones.dat y compactados.dat no existen
