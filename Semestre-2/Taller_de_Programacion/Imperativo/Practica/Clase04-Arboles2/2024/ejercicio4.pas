{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}


program biblioteca;
type
	r_dia=1..31;
	r_mes=1..12;
	prestamo = record
		isbn:integer;
		socio: integer;
		dia: r_dia;
		mes: r_mes;
		totalDias:integer;
	end;
	
	arbol1 = ^nodo1;
	nodo1 = record
		dato: prestamo;
		hi:arbol1;
		hd:arbol1;
	end;
	
	datosLista = record
		socio: integer;
		dia:r_dia;
		mes:r_mes;
		totalDias:integer;
	end;
	
	lista = ^nodoL;
	nodoL = record
		dato: datosLista;
		sig:lista;
	end;
	
	datosArbol2=record
		isbn:integer;
		prestamos:lista;
	end;
	
	arbol2 = ^nodo2;
	nodo2 = record
		dato: datosArbol2;
		hi:arbol2;
		hd:arbol2;
	end;
	
	datosArbol3 = record
		isbn:integer;
		totalPrestamos:integer;
	end;
	
	arbol3=^nodo3;
	nodo3=record
		dato: datosArbol3;
		hi: arbol3;
		hd: arbol3;
	end;
	
	procedure LeerPrestamos (var p:prestamo);
	begin
		p.isbn := random(300);
		if (p.isbn <> 0) then begin
			p.socio:=random(300) + 1;
			p.dia:=random(31) + 1;
			p.mes:=random(12) + 1;
			p.totalDias:=random(30)+1;
		end;
	end;
	
	procedure agregarAdelante(var l:lista; p:prestamo);
	var
		nue:lista;
	begin
		new(nue);
		nue^.dato.socio:=p.socio;
		nue^.dato.dia:=p.dia;
		nue^.dato.mes:=p.mes;
		nue^.dato.totalDias:=p.totalDias;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure ArmarArbol1(var a1:arbol1; p:prestamo);
	begin
		if(a1=nil) then begin
			new(a1);
			a1^.dato:=p;
			a1^.hi:=nil;
			a1^.hd:=nil;
		end
		else if (p.isbn < a1^.dato.isbn) then
			ArmarArbol1(a1^.hi, p)
		else ArmarArbol1(a1^.hd, p);
	end;

	procedure ArmarArbol2 (var a2:arbol2; p:prestamo);
	begin
		if(a2=nil) then begin
			new(a2);
			a2^.dato.isbn:=p.isbn;
			a2^.dato.prestamos:=nil;
			agregarAdelante(a2^.dato.prestamos, p);
			a2^.hi:=nil;
			a2^.hd:=nil;
		end
		else if (p.isbn = a2^.dato.isbn) then
			agregarAdelante(a2^.dato.prestamos, p)
		else if (p.isbn < a2^.dato.isbn) then
			ArmarArbol2(a2^.hi, p)
		else
			ArmarArbol2(a2^.hd, p);
	end;
	
	procedure ImprimirArbol1(a1:arbol1);
	begin
		if(a1<>nil) then begin
			ImprimirArbol1(a1^.hi);
			writeln('isbn: ', a1^.dato.isbn, ', socio: ', a1^.dato.socio, ', dia: ', a1^.dato.dia, ', mes: ', a1^.dato.mes, ', total dias: ', a1^.dato.totalDias);
			writeln;
			ImprimirArbol1(a1^.hd);
		end;
	end;
	
	procedure ImprimirLista(l:lista);
	begin
		while (l<>nil) do begin
			writeln('socio: ',l^.dato.socio, ', dia: ', l^.dato.dia, ', mes: ', l^.dato.mes, ', total dias: ', l^.dato.totalDias);
			l:=l^.sig;
		end;
	end;
	
	procedure ImprimirArbol2(a2:arbol2);
	begin
		if (a2<>nil) then begin
			ImprimirArbol2(a2^.hi);
			writeln('isbn: ', a2^.dato.isbn);
			ImprimirLista(a2^.dato.prestamos);
			writeln;
			ImprimirArbol2(a2^.hd);
		end;
	end;
	
	procedure ModuloA(var a1:arbol1; var a2:arbol2);
	var p:prestamo;
	begin
		LeerPrestamos(p);
		while(p.isbn <>0) do begin
			ArmarArbol1(a1,p);
			ArmarArbol2(a2,p);
			LeerPrestamos(p);
		end;
		writeln('---Generando Arboles---');
		writeln;
		writeln('----Arbol 1----');
		ImprimirArbol1(a1);
		writeln('----Arbol 2----');
		ImprimirArbol2(a2);
	end;
	
	procedure ModuloB(a1:arbol1);
		function IsbnMayor(a1:arbol1): integer;
		begin
			if(a1^.hd=nil) then
			 IsbnMayor:=a1^.dato.isbn
			else
				IsbnMayor:=IsbnMayor(a1^.hd);
		end;
	var
		mayorIsbn:integer;
	begin
		writeln;
		mayorIsbn:= IsbnMayor(a1);
		writeln('el numero mas grande de isbn es: ', mayorIsbn);
	end;
	
	procedure ModuloC(a2:arbol2);
		function IsbnMenor(a2:arbol2):integer;
		begin
			if(a2^.hi=nil) then
				IsbnMenor:= a2^.dato.isbn
			else
				IsbnMenor:= IsbnMenor(a2^.hi);
		end;
	var
		menorIsbn:integer;
	begin
		writeln;
		menorIsbn:= IsbnMenor(a2);
		writeln('el numero de isbn mas chico es: ', menorIsbn);
	end;
	
	procedure ModuloD(a1:arbol1);
		function CantidadPrestamos(a1: arbol1; socio: integer): integer;
		begin
			if (a1 = nil) then
        CantidadPrestamos := 0 // Nodo vacío, sin préstamos.
			else
				begin
					if (a1^.dato.socio = socio) then
            CantidadPrestamos := 1 + CantidadPrestamos(a1^.hi, socio) + CantidadPrestamos(a1^.hd, socio)
					else
            CantidadPrestamos := CantidadPrestamos(a1^.hi, socio) + CantidadPrestamos(a1^.hd, socio);
				end;
		end;
	var
		prestamos: integer;
		socio:integer;
	begin
		writeln;
		writeln('ingrese un numero de socio: '); readln(socio);
		prestamos:=CantidadPrestamos(a1, socio);
		writeln;
		writeln('La cantidad todal de prestamos para ese socio fue: ', prestamos);
	end;
	
	procedure ModuloE(a2:arbol2);
		function contarEnLaLista(l:lista; socio:integer): integer;
		var cantidad:integer;
		begin
			cantidad:=0;
			while (l<>nil) do begin
				if(l^.dato.socio = socio) then
					cantidad:= cantidad + 1;
				l:=l^.sig
			end;
			contarEnLaLista:=cantidad; 
		end;
		
		function ContarArbol (a2:arbol2; socio:integer):integer;
		begin
			if(a2=nil) then
				ContarArbol:=0
			else
				ContarArbol:= contarEnLaLista(a2^.dato.prestamos,socio) + ContarArbol(a2^.hi, socio) + ContarArbol(a2^.hd, socio);
		end;
	var
		prestamos:integer;
		socio:integer;
	begin
		writeln;
		writeln('ingrese un numero de socio: '); readln(socio);
		prestamos:=ContarArbol(a2, socio);
		writeln;
		writeln('La cantidad todal de prestamos para ese socio fue: ', prestamos);
	end;
	
	procedure ModuloF(a1:arbol1; var a3:arbol3);
	
		procedure ArmarArbol3 (var a3:Arbol3; a1:arbol1);
		begin
			if(a3=nil) then begin
				new(a3);
				a3^.dato.isbn := a1^.dato.isbn;
				a3^.dato.totalPrestamos:= 1;
				a3^.hi:=nil;
				a3^.hd:=nil;
			end
			else if (a1^.dato.isbn = a3^.dato.isbn) then 
				a3^.dato.totalPrestamos:= a3^.dato.totalPrestamos + 1
			else if (a1^.dato.isbn < a3^.dato.isbn) then
				ArmarArbol3(a3^.hi, a1)
			else 
				ArmarArbol3(a3^.hd, a1);
		end;
	
		procedure ImprimirArbol3 (a3:arbol3);
		begin
			if (a3<>nil) then begin
				ImprimirArbol3(a3^.hi);
				writeln('isbn: ', a3^.dato.isbn, ' total prestamos: ', a3^.dato.totalPrestamos);
				writeln;
				ImprimirArbol3(a3^.hd);
			end;
		end;
	
		procedure GenerarArbol3 (var a3:arbol3; a1:arbol1);
		begin
			if (a1<>nil) then begin
				ArmarArbol3(a3, a1);
				GenerarArbol3(a3, a1^.hi);
				GenerarArbol3(a3, a1^.hd);
			end;
		end;
		
	begin
		writeln;
		writeln('----Arbol 3----');
		GenerarArbol3(a3,a1);
		ImprimirArbol3(a3);
	end;
	
	procedure ModuloG(a2:arbol2; var a4:arbol3);
		function contarEnLaLista(l:lista): integer;
		var elementos:integer;
		begin
			elementos:=0;
			while (l<>nil) do begin
				elementos:=elementos+1;
				l:=l^.sig;
			end;
			contarEnLaLista:=elementos;
		end;
		
		procedure ArmarArbol4 (var a4:Arbol3; a2:arbol2);
		begin
			if(a4=nil) then begin
				new(a4);
				a4^.dato.isbn := a2^.dato.isbn;
				a4^.dato.totalPrestamos:= contarEnLaLista(a2^.dato.prestamos);
				a4^.hi:=nil;
				a4^.hd:=nil;
			end
			else if (a2^.dato.isbn = a4^.dato.isbn) then 
				a4^.dato.totalPrestamos:= contarEnLaLista(a2^.dato.prestamos) + a4^.dato.totalPrestamos
			else if (a2^.dato.isbn < a4^.dato.isbn) then
				ArmarArbol4(a4^.hi, a2)
			else 
				ArmarArbol4(a4^.hd, a2);
		end;
		
		procedure GenerarArbol4 (var a4:arbol3; a2:arbol2);
		begin
			if (a2<>nil) then begin
				ArmarArbol4(a4, a2);
				GenerarArbol4(a4, a2^.hi);
				GenerarArbol4(a4, a2^.hd);
			end;
		end;
		
		procedure ImprimirArbol4 (a4:arbol3);
		begin
			if (a4<>nil) then begin
				ImprimirArbol4(a4^.hi);
				writeln('isbn: ', a4^.dato.isbn, ' total prestamos: ', a4^.dato.totalPrestamos);
				writeln;
				ImprimirArbol4(a4^.hd);
			end;
		end;
		
	begin
		writeln;
		writeln('----Arbol 4----');
		GenerarArbol4(a4,a2);
		ImprimirArbol4(a4);
	end;
	
	procedure ModuloI(a1:arbol1);
		function contarEntreDos (a1: arbol1; isbn1, isbn2:integer): integer;
		begin
			if (a1=nil) then
				contarEntreDos:=0
			else
				begin
					if(a1^.dato.isbn>isbn1) and (a1^.dato.isbn<isbn2) then
						contarEntreDos:= 1 + contarEntreDos(a1^.hi, isbn1, isbn2) + contarEntreDos(a1^.hd, isbn1, isbn2)
					else if (a1^.dato.isbn <= isbn1) then
						contarEntreDos:=contarEntreDos(a1^.hd, isbn1, isbn2)
					else
						contarEntreDos:=contarEntreDos(a1^.hi, isbn1, isbn2);
				end;
		end;
	var
	 total:integer;
	 isbn1, isbn2:integer;
	begin
		writeln;
		writeln('ingrese valor isbn1: '); readln(isbn1);
		writeln;
		writeln('ingrese valor isbn1: '); readln(isbn2);
		total:= contarEntreDos(a1, isbn1, isbn2);
		writeln;
		writeln('La cantidad total entre los dos valores es: ', total);
	end;

	var
		a1:arbol1;
		a2:arbol2;
		a4,a3:arbol3;
		
	begin
		randomize;
		ModuloA(a1, a2);
{
		ModuloB(a1);
		ModuloC(a2);
		ModuloD(a1);
		ModuloE(a2);
}
		ModuloF(a1,a3);
		ModuloG(a2,a4);
		ModuloI(a1);
	end.
	
	

