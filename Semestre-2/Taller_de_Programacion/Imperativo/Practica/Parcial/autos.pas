program autos;
type
	sub_mes=1..12;
	atencion = record
		dni: integer;
		mes:sub_mes;
		anio:integer;
		patente:integer;
	end;
	
	datosLista = record
		mes:sub_mes;
		anio:integer;
		dni:integer;
	end;
	
	lista =^nodoL;
	nodoL=record
		dato:datosLista;
		sig:lista;
	end;
	
	datosArbol = record
		patente:integer;
		alquileres:lista;
	end;
	
	arbol =^nodoA;
	nodoA=record
		dato: datosArbol;
		hi:arbol;
		hd:arbol;
	end;

procedure ModuloA(var ar:arbol);
	procedure leerAlquiler( var a:atencion);
	begin
		a.patente:=Random(50);
		if(a.patente<>0) then begin
			a.dni:=Random(50) +1;
			a.mes:=Random(12)+1;
			a.anio:=Random(24) + 2000;
		end;
	end;
	
	procedure AgregarAdelante(var l:lista; a:atencion);
	var nue:lista;
	begin
		new(nue);
		nue^.dato.mes:= a.mes;
		nue^.dato.anio:=a.anio;
		nue^.dato.dni:=a.dni;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure ArmarNodo(var ar:arbol; a:atencion);
	begin
		if(ar=nil) then begin
			new(ar);
			ar^.dato.patente:=a.patente;
			ar^.dato.alquileres:=nil;
			AgregarAdelante(ar^.dato.alquileres,a);
			ar^.hi:=nil;
			ar^.hd:=nil;
		end
		else if(a.patente = ar^.dato.patente) then
			AgregarAdelante(ar^.dato.alquileres, a)
		else if(a.patente < ar^.dato.patente) then
			ArmarNodo(ar^.hi, a)
		else 
			ArmarNodo(ar^.hd, a);
	end;

	procedure ArmarArbol(var ar:arbol);
	var a:atencion;
	begin
		leerAlquiler(a);
		while (a.patente <> 0) do begin
			ArmarNodo(ar, a);
			leerAlquiler(a);
		end;
	end;
	
	procedure ImprimirLista(l:lista);
	begin
		while (l<> nil) do begin
			writeln;
			writeln('dni: ', l^.dato.dni,  ' mes: ', l^.dato.mes, ' anio: ', l^.dato.anio);
			l:=l^.sig;
		end;
	end;
	
	procedure  ImprimirArbol(ar:arbol);
	begin
		if (ar<> nil) then begin
		ImprimirArbol(ar^.hi);
		writeln;
		writeln('patente :', ar^.dato.patente);
		ImprimirLista(ar^.dato.alquileres);
		ImprimirArbol(ar^.hd);
		end;
	end;

begin
	ar:=nil;
	ArmarArbol(ar);
	ImprimirArbol(ar);
end;

procedure ModuloB(ar:arbol);
	function contarLista(l:lista; dni:integer):integer;
	var cantidad:integer;
	begin
		cantidad:=0;
		while (l<>nil) do begin
			if(l^.dato.dni = dni) then
				cantidad:=cantidad+1;
			l:=l^.sig;
		end;
		contarLista:=cantidad;
	end;
	
	function ContarEnArbol(ar:arbol; dni:integer): integer;
	begin
		if(ar=nil) then
			ContarEnArbol:=0
		else
			ContarEnArbol:= ContarLista(ar^.dato.alquileres, dni) + ContarEnArbol(ar^.hi, dni) + ContarEnArbol(ar^.hd, dni);
	end;

var
	cantidad:integer;
	dni:integer;
begin
	writeln('ingrese un dni ');readln(dni);
	writeln;
	cantidad:= ContarEnArbol(ar, dni);
	writeln('la cantidad es: ', cantidad);
	
end;

procedure ModuloC(ar:arbol);
	function contarAnios(l:lista; anio:integer): integer;
	var cantidad:integer;
	begin
		cantidad:=0;
		while (l<>nil) do begin
			if (l^.dato.anio = anio) then
				cantidad:=cantidad + 1;
			l:=l^.sig;
		end;
		contarAnios:=cantidad;
	end;
	
	function entreDosValores(ar:arbol; anio, pat1, pat2:integer): integer;
	begin
		if(ar=nil) then
			entreDosValores:=0
		else
			begin
				if(ar^.dato.patente > pat1) and (ar^.dato.patente <pat2) then 
					entreDosValores:= contarAnios(ar^.dato.alquileres, anio) +
														entreDosValores(ar^.hi, anio,pat1, pat2) + 
														entreDosValores(ar^.hd, anio,pat1,pat2)
				else if (pat1<ar^.dato.patente) then
					entreDosValores:=entreDosValores(ar^.hi, anio,pat1, pat2)
				else
					entreDosValores:=entreDosValores(ar^.hd, anio, pat1, pat2);
			end;
	end;
var
	cantidad,anio, pat1, pat2:integer;
begin
	writeln('ingrese patente 1'); readln(pat1);
	writeln;
	writeln('ingrese patente 2'); readln(pat2);
	writeln;
	writeln('ingrese anio');readln(anio);
	cantidad:=entreDosValores(ar, anio, pat1,pat2);
	writeln('La cantidad es de alquileres entre esas dos patententes en ese año es: ', cantidad);
end;
var
	ar:arbol;
begin
randomize;
	ModuloA(ar);
	ModuloB(ar);
	ModuloC(ar);
	
end.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
