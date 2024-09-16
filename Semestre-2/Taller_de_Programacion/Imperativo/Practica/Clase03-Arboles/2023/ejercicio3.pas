{
Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program ejercicio3;

type 
	calificacion=1..10;
	
	finales = record
		codigo:integer;
		nota:calificacion;
	end;
	
	lista = ^nodoLista;
	
	nodoLista = record
		dato:finales;
		sig:lista;
	end;
	
	alumno = record
		legajo: integer;
		dni: integer;
		ingreso: integer;
		notas: lista;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: alumno;
		hi: arbol;
		hd: arbol;
	end;
	
procedure leerNotas (var f:finales);
begin
	writeln('Ingreso de notas');
	writeln('Ingrese codigo de final: ');
	readln(f.codigo);
	if (f.codigo <> -1) then begin
		writeln ('ingrese calificacion: ');
		readln(f.nota);
	end;
end;

procedure agregarNotas(var l:lista; f:finales);
var nue:lista;
begin
	new(nue);
	nue^.dato:=f;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarListaNotas(var l:lista);
var
	f:finales;
begin
	leerNotas(f);
	while (f.codigo <>-1) do begin
		agregarNotas(l,f);
		leerNotas(f);
	end;
end;

procedure leerAlumno(var a:alumno);
begin
	writeln('Lectrua de alumnos: ');
	writeln('Ingrese codigo legago: ');
	readln(a.legajo);
	if (a.legajo <>0) then begin
		writeln('Ingrese dni: ');
		readln(a.dni);
		writeln('Ingrese anio de ingreso: ');
		readln(a.ingreso);
		a.notas:=nil;
		cargarListaNotas(a.notas);
	end;
end;

procedure armarArbol (var a:arbol; alu:alumno);
begin
	if (a=nil) then begin
		new(a);
		a^.dato:=alu;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else if (alu.legajo < a^.dato.legajo) then
		armarArbol(a^.hi, alu)
	else armarArbol(a^.hd, alu);
end;

procedure cargarArbol (var a:arbol);
var
	alu:alumno;
begin
	leerAlumno(alu);
	if (alu.legajo<>0) then begin
		cargarArbol(a);
		armarArbol(a, alu);
	end
	else
		a:=nil;
end;

procedure imprimirListaNotas(l:lista);
begin
	while (l<>nil) do begin
		writeln('-----');
		writeln('materia: ', l^.dato.codigo);
		writeln('nota: ', l^.dato.nota);
		l:=l^.sig;
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.hi);
		writeln('Alumno: ', a^.dato.legajo);
		writeln('DNI: ', a^.dato.dni);
		writeln('anio de ingreso: ', a^.dato.ingreso);
		imprimirListaNotas(a^.dato.notas);
		writeln('-------');
		imprimirArbol(a^.hd);
	end;
end;

procedure legajoInferior(a:arbol; legajo:integer);

var
	a:arbol;
begin
	a:=nil;
	cargarArbol(a);
	writeln('Listado Alumnos');
	imprimirArbol(a);
end.


		
	
		


	
	
	
