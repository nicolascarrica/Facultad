{

Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program ejercicio3;
type
	r_nota = 1..10;
	r_codigo = -1..35;
	r_dia = 1..31;
	r_mes = 1..12;
	r_anio = 2008..2024;
	
	fecha =record
		dia:r_dia;
		mes:r_mes;
		anio:r_anio;
	end;
	
	examen = record
		codigo:r_codigo;
		fecha_examen: fecha;
		nota:r_nota;
	end;
	
	lista=^nodoL;
	nodoL = record
		dato:examen;
		sig:lista;
	end;
	
	alumnos = record
		legajo: integer;
		notas: lista;
	end;
	
	arbol=^nodoA;
	nodoA = record
		dato: alumnos;
		hi:arbol;
		hd:arbol;
	end;
	
procedure ModuloA (var a:arbol);
	procedure leerFecha(var f:fecha);
	begin
		f.dia:=random(31)+1;
		f.mes:=random(12)+1;
		f.anio:=random(2023 - 2010) + 2010;
	end;
	
	procedure leerExamen(var e:examen);
	begin
		e.codigo:=random(36) - 1;
		if (e.codigo<>-1) then begin
			leerFecha(e.fecha_examen);
			e.nota:=random(10) + 1;
		end;
	end;
	
	procedure agregarAdelante(var l:lista; e:examen);
	var nue:lista;
	begin
		new(nue);
		nue^.dato:=e;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure leerAlumno(var a:alumnos);
	var
		e:examen;
	begin
		a.legajo:=random(100);
		if(a.legajo <>0 ) then begin
			a.notas:=nil;
			leerExamen(e);
			while(e.codigo <>-1) do begin
				agregarAdelante(a.notas,e);
				leerExamen(e);
			end;
		end;
	end;
	
	procedure insertarElemento (var a:arbol; alu:alumnos);
	begin
		if (a=nil) then begin
			new(a);
			a^.dato:=alu;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else if alu.legajo < a^.dato.legajo then
			insertarElemento(a^.hi, alu)
		else
			insertarElemento(a^.hd, alu);
	end;

procedure imprimirArbol (a:arbol);
	procedure imprimirLista(l:lista);
	begin
		while l<>nil do begin
			writeln('Codigo de Materia: ', l^.dato.codigo);
			writeln('Fecha: ',l^.dato.fecha_examen.dia,'/',l^.dato.fecha_examen.mes,'/',l^.dato.fecha_examen.anio);
			writeln('Nota: ', l^.dato.nota);
			l:=l^.sig;
		end;
	end;
begin
	if (a<>nil) then begin
		imprimirArbol(a^.hi);
		writeln('Legajo: ', a^.dato.legajo);
		writeln('finales Rendidos: ');
		imprimirLista(a^.dato.notas);
		writeln('---------------------');
		writeln;
		imprimirArbol(a^.hd);
	end;
end;
			
var
	unAlumno:alumnos;
	
begin
	writeln;
	writeln ('----- Ingreso de alumnos y armado del arbol ----->');
	writeln;
	a:= nil;
	leerAlumno (unAlumno);
	while (unAlumno.legajo <> 0)do
	begin
		insertarElemento (a, unAlumno);
		leerAlumno (unAlumno);
	end;
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	imprimirArbol(a);
end;



procedure ModuloC(a:arbol);
	function maximo(a:arbol): integer;
	begin
		if(a^.hd = nil) then
			maximo:=a^.dato.legajo
		else 
			maximo:=maximo(a^.hd);
	end;

var legajoMaximo: integer;
begin
	legajoMaximo:= maximo(a);
	writeln('El legajo Maximo es el n: ', legajoMaximo);
	writeln;
	writeln('----------------------');
end;
var a:arbol;
begin
	ModuloA(a);
	writeln;
	ModuloC(a);
end.

{ Modulo b: Contar alumnos con legajo impar 
function ContarImpares(a: arbol): integer;
begin
	if a = nil then
		ContarImpares := 0
	else if (a^.dato.legajo mod 2) = 1 then
		ContarImpares := 1 + ContarImpares(a^.hi) + ContarImpares(a^.hd)
	else
		ContarImpares := ContarImpares(a^.hi) + ContarImpares(a^.hd);
end;

Modulo c: Contar finales aprobados (nota >= 4) por alumno 
procedure ContarFinalesAprobados(a: arbol);
	function contarAprobados(l: lista): integer;
	var
		count: integer;
	begin
		count := 0;
		while l <> nil do begin
			if l^.dato.nota >= 4 then
				count := count + 1;
			l := l^.sig;
		end;
		contarAprobados := count;
	end;

begin
	if a <> nil then begin
		ContarFinalesAprobados(a^.hi);
		writeln('Legajo: ', a^.dato.legajo, ' - Finales Aprobados: ', contarAprobados(a^.dato.notas));
		ContarFinalesAprobados(a^.hd);
	end;
end;


procedure AlumnosConPromedioMayor(a: arbol; valor: real);
	function calcularPromedio(l: lista): real;
	var
		sum, count: integer;
	begin
		sum := 0;
		count := 0;
		while l <> nil do begin
			sum := sum + l^.dato.nota;
			count := count + 1;
			l := l^.sig;
		end;
		if count > 0 then
			calcularPromedio := sum / count
		else
			calcularPromedio := 0;
	end;

begin
	if a <> nil then begin
		AlumnosConPromedioMayor(a^.hi, valor);
		if calcularPromedio(a^.dato.notas) > valor then
			writeln('Legajo: ', a^.dato.legajo, ' - Promedio: ', calcularPromedio(a^.dato.notas):0:2);
		AlumnosConPromedioMayor(a^.hd, valor);
	end;
end;
}
