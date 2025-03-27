{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado,
y se decrementa en uno la cantidad de materias sin final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto aquellos alumnos que tengan más materias con finales
aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado
es un reporte de salida (no se usa con fines de carga), debe informar todos los
campos de cada alumno en una sola línea del archivo de texto.}

program ejercicio2;
const valorAlto = 999;
type
	Alumno = record
		codigo: integer;
		sinFinal: integer;
		conFinal: integer;
		apellido: string;
	end;
	
	Detalle = record
		codigo:integer;
		aproboFinal: boolean;
	end;
	
	ArchivoMaestro = file of Alumno;
	ArchivoDetalle = file of Detalle;

procedure leer(var det:ArchivoDetalle; var reg: Detalle);
begin
	if(not eof(det)) then
		read(det, reg)
	else
		reg.codigo:= valorAlto;
end;

procedure CrearMaestro(var maestro: ArchivoMaestro);
var
    alu: Alumno;
begin
    assign(maestro, 'maestro.dat');
    rewrite(maestro);
    
    // Agregamos alumnos de prueba
    alu.codigo := 1; alu.apellido := 'Perez'; alu.sinFinal := 3; alu.conFinal := 2;
    write(maestro, alu);

    alu.codigo := 2; alu.apellido := 'Gomez'; alu.sinFinal := 5; alu.conFinal := 1;
    write(maestro, alu);
    
    alu.codigo := 3; alu.apellido := 'Lopez'; alu.sinFinal := 2; alu.conFinal := 4;
    write(maestro, alu);
    
    close(maestro);
    writeln('Archivo maestro creado.');
end;

procedure CrearDetalle(var detalle: ArchivoDetalle);
var
    det: Detalle;
begin
    assign(detalle, 'detalle.dat');
    rewrite(detalle);
    
    // Agregamos registros de prueba
    det.codigo := 1; det.aproboFinal := true;  // Perez aprobó un final
    write(detalle, det);
    
    det.codigo := 2; det.aproboFinal := false; // Gomez aprobó una cursada
    write(detalle, det);
    
    det.codigo := 2; det.aproboFinal := true;  // Gomez aprobó un final
    write(detalle, det);
    
    det.codigo := 3; det.aproboFinal := true;  // Lopez aprobó un final
    write(detalle, det);
    
    close(detalle);
    writeln('Archivo detalle creado.');
end;

procedure ActualizarMaestro(var maestro: ArchivoMaestro; var detalle: ArchivoDetalle);
var
	alu: Alumno;
	regD: Detalle;
	codigoActual: integer;
begin
	reset(maestro);
	reset(detalle);
	
	leer(detalle, regD); //lee el primer registro
	while(regD.codigo <> valorAlto) do begin
		read(maestro, alu);
		while (alu.codigo <> regD.codigo) and (not eof(maestro)) do
			read(maestro, alu);
			
		if (alu.codigo = regD.codigo) then begin
			codigoActual:= alu.codigo;
			while(regD.codigo = codigoActual) do begin
				if(regD.aproboFinal) then begin
					alu.conFinal:=alu.conFinal+1;
					alu.sinFinal:=alu.sinFinal-1;
				end
				else alu.sinFinal:=alu.sinFinal+1;
				leer(detalle, regD);
			end;
			seek(maestro, filepos(maestro)-1);
			write(maestro, alu);
		end;
	end;
	close(maestro);
	close(detalle);
end;

procedure MostrarMaestro(var maestro: ArchivoMaestro);
var
    alu: Alumno;
begin
    reset(maestro);
    writeln('--- Archivo Maestro ---');
    while (not eof(maestro)) do begin
        read(maestro, alu);
        writeln('Codigo: ', alu.codigo, ' | Apellido: ', alu.apellido, 
                ' | Sin Final: ', alu.sinFinal, ' | Con Final: ', alu.conFinal);
    end;
    close(maestro);
end;


procedure GenerarReporte(var maestro: ArchivoMaestro);
var
	alu: Alumno;
	reporte:text;
	nombre:string;
begin
	writeln('Ingrese nombre del reporte: ' );
	readln(nombre);
	assign(reporte, nombre);
	reset(maestro);
	rewrite(reporte);
	while (not(eof(maestro))) do begin
		read(maestro, alu);
		if(alu.conFinal > alu.sinFinal) then
			writeln(reporte, 'Codigo: ', alu.codigo, 'apellido: ', alu.apellido,
				'Con final: ', alu.conFinal, 'Sin Final: ', alu.sinFinal);
	end;
	close(maestro);
	close(reporte);
end;

var
	maestro: ArchivoMaestro;
	detalles: ArchivoDetalle;
begin
	assign(maestro, 'maestro.dat');
    assign(detalles, 'detalle.dat');
    
    CrearMaestro(maestro);  // Crea el archivo maestro con datos de prueba
    CrearDetalle(detalles);  // Crea el archivo detalle con datos de prueba
    
    MostrarMaestro(maestro); // Muestra los datos antes de la actualización
    
    ActualizarMaestro(maestro, detalles); // Aplica la actualización
    
    MostrarMaestro(maestro); // Muestra los datos después de la actualización
    GenerarReporte(maestro);
end.

//HACER LOS ASSING DE LOS MODULOS EN EL PROGRAMA PRINCIPAL; NO EN LOS MODULOS
