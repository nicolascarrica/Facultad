program bibliotecaSarmiento;
type
	prestamo = record
		numero:integer;
		isbn:integer;
		socio:integer;
	end;
	
	datoSocio = record
		socio:integer;
		totalPrestamos:integer;
	end;
	
	lista = ^nodoL;
	nodoL = record
		dato:datoSocio;
		sig:lista;
	end;
		
	
	arbol = ^nodoA;
	nodoA = record
		dato: prestamo;
		hi:arbol;
		hd:arbol;
	end;
	
	procedure ModuloA(var a:arbol; var l:lista);
		procedure AgregarAdelante(var l:lista; ds:datoSocio);
		var nue:lista;
		begin
			new(nue);
			nue^.dato:= ds;
			nue^.sig:= l;
			l:=nue;
		end;
		
		procedure ArmarNodo (var a :arbol; p:prestamo);
		begin
			if (a=nil) then begin
				new(a);
				a^.dato:=p;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else if p.isbn < a^.dato.isbn then
				ArmarNodo(a^.hi, p)
			else
				ArmarNodo(a^.hd, p);
		end;
		
		procedure ImprimirArbol(a:arbol);
		begin
			if(a<> nil) then begin
				ImprimirArbol(a^.hi);
				writeln('isbn: ', a^.dato.isbn, ' ,socio: ', a^.dato.socio, ', prestamo: ', a^.dato.numero);
				writeln;
				ImprimirArbol(a^.hd);
			end; 
		end;
		
		procedure imprimirLista(l:lista);
		begin
			while (l<>nil) do begin
				writeln('socio: ', l^.dato.socio, ', cantidad de prestamos:', l^.dato.totalPrestamos);
				l:=l^.sig;
			end;
		end;
		
		procedure CargarPrestamos(var a:arbol; var l:lista);
		var
			p:prestamo;
			ds:datoSocio;
			socioActual:integer;
			cantidadPrestamo:integer;
		begin
			writeln('ingreso de codigo de socio'); readln(p.socio);
			while p.socio <> 0 do begin
				socioActual:=p.socio;
				cantidadPrestamo:=0;
				while (p.socio = socioActual) and (p.socio <> 0) do begin
					writeln('ingrese isbn: '); readln(p.isbn);
					writeln('ingrese numero de prestamo: '); readln(p.numero);
					cantidadPrestamo:= cantidadPrestamo + 1;
					ArmarNodo(a,p);
					writeln('ingreso de codigo de socio'); readln(p.socio);
				end;
				ds.socio:= socioActual;
				ds.totalPrestamos:= cantidadPrestamo;
				AgregarAdelante(l,ds);
			end;
		end;
		
	begin
		l:=nil;
		a:=nil;
		CargarPrestamos(a,l);
		ImprimirArbol(a);
		ImprimirLista(l);
	end;
	
	procedure ModuloB(a:arbol);
		function ContarPrestamos(a:arbol; isbn:integer): integer;
		begin
			if(a=nil) then
				ContarPrestamos:=0
			else
				if(a^.dato.isbn = isbn) then
					ContarPrestamos:= 1 + ContarPrestamos(a^.hi, isbn) + ContarPrestamos(a^.hd, isbn)
			else
				ContarPrestamos:= ContarPrestamos(a^.hi, isbn) + ContarPrestamos(a^.hd, isbn);
		end;
	var
		cantidad:integer;
		isbn:integer;
	begin
		writeln('ingrese isbn' ); readln(isbn);
		writeln;
		cantidad:=ContarPrestamos(a, isbn);
		writeln(' la cantidad de prestamos fue.', cantidad);
	end;
	
	procedure ModuloC(l:lista);
		function ContarSocios(l:lista; x:integer):integer;
		begin
			if (l =  nil) then
				ContarSocios:=0
			else
				if(l^.dato.totalPrestamos>x) then
					ContarSocios:= 1 + ContarSocios(l^.sig, x)
				else ContarSocios:= ContarSocios(l^.sig,x);
		end;
		
	var
		cantidad:integer; x:integer;
	begin
		writeln('ingrese un valor de prestamos: '); readln(x);
		cantidad:=ContarSocios(l,x);
		writeln('la cantidad de socios con prestmos superior es: ', cantidad);
	end;
	var
		a:arbol;
		l:lista;
	begin
		ModuloA(a,l);
		ModuloB(a);
		ModuloC(l);
	end.
				
