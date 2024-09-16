{
Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de
los autos en venta. Implementar un programa que:
a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.
b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
cantidad de autos de dicha marca que posee la agencia.
c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.
e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.
f)
Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
modelo del auto con dicha patente.}

program agencia;
type
	r_anio = 2010..2018;
	r_patente = string [7];
	
	auto = record
		patente: r_patente;
		anio: r_anio;
		marca: string;
		modelo: string;
	end;
	
	datosLista=record
		modelo:string;
		patente:r_patente;
		anio: r_anio;
	end;
		
	lista = ^nodoL;
	nodoL=record
		dato: datosLista;
		sig:lista;
	end;
	
	datosArbol2 = record
		marca:string;
		info:lista;
	end;
	
	arbol1 = ^nodoA1;
	nodoA1 = record
		dato: auto;
		hi:arbol1;
		hd:arbol1;
	end;
	
	arbol2 = ^nodoA2;
	nodoA2 = record
		dato: datosArbol2;
		hi:arbol2;
		hd:arbol2;
	end;
	
procedure ModuloA(var a1:arbol1; var a2:arbol2);
	procedure leerAuto(var v:auto);
	begin
		writeln('ingrese marca:');
		readln(v.marca);
		if(v.marca <> 'MMM') then begin
			writeln('ingrese patente: '); readln(v.patente);
			writeln('ingrese modelo: '); readln(v.modelo);
			v.anio:=2010 + Random(2018-2010);
		end;
	end;
	
	procedure AgregarAdelante(var l:lista; v:auto);
	var	nue:lista;
	begin
		new(nue);
		nue^.dato.modelo:=v.modelo;
		nue^.dato.patente:=v.patente;
		nue^.dato.anio:=v.anio;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure ArmarNodoi (var ai:arbol1; v:auto);
	begin
		if (ai = nil) then begin
			new(ai);
			ai^.dato:=v;
			ai^.hi:=nil;
			ai^.hd:=nil;
		end
		else if (v.patente < ai^.dato.patente) then
			ArmarNodoi(ai^.hi, v)
		else
			ArmarNodoi(ai^.hd,v);
	end;
	
	procedure ArmarNodoii(var aii:arbol2; v:auto);
	begin
		if(aii=nil) then begin
			new(aii);
			aii^.dato.marca:=v.marca;
			aii^.dato.info:=nil;
			AgregarAdelante(aii^.dato.info, v);
			aii^.hi:=nil;
			aii^.hd:=nil;
		end
		else if (v.marca = aii^.dato.marca) then
			AgregarAdelante(aii^.dato.info, v)
		else if (v.marca < aii^.dato.marca) then
			ArmarNodoii(aii^.hi,v)
		else
			ArmarNodoii(aii^.hd,v);
	end;
	
	procedure CargarArboles(var ai:arbol1; var aii:arbol2);
	var
		v:auto;
	begin
		leerAuto(v);
		while(v.marca <> 'MMM') do begin
			ArmarNodoi(ai, v);
			ArmarNodoii(aii,v);
			leerAuto(v);
		end;
	end;
	
	procedure ImprimirArboli (ai:arbol1);
	begin
		if(ai<>nil)then begin
			ImprimirArboli(ai^.hi);
			writeln;
			writeln('marca: ', ai^.dato.marca, ', modelo: ', ai^.dato.modelo, ', patente: ', ai^.dato.patente, ', anio: ', ai^.dato.anio);
			ImprimirArboli(ai^.hd);
		end;
	end;
	
	procedure ImprimirLista(l:lista);
	begin
		while (l<>nil) do begin
			writeln;
			writeln('modelo: ', l^.dato.modelo, ', patente: ', l^.dato.patente, ', anio: ', l^.dato.anio);
			l:=l^.sig;
		end;
	end;
	
	procedure ImprimirArbolii(aii:arbol2);
	begin
		if(aii<>nil)then begin
			ImprimirArbolii(aii^.hi);
			writeln;
			writeln('marca: ', aii^.dato.marca);
			ImprimirLista(aii^.dato.info);
			ImprimirArbolii(aii^.hd);
		end;
	end;

var ai:arbol1; aii:arbol2;
begin
	ai:=nil;
	aii:=nil;
	CargarArboles(ai,aii);
	writeln('<----Arbol 1---->');
	ImprimirArboli(ai);
	writeln('<----Arbol 2---->');
	ImprimirArbolii(aii);
	
end;

Procedure ModuloB(ai:arbol1);
	function contarMarcas(ai:arbol1; marca:string):integer;
	begin
		if (ai=nil) then
			contarMarcas:=0
		else
			begin
				if (ai^.dato.marca = marca ) then
					contarMarcas:= 1 + contarMarcas(ai^.hi, marca) + contarMarcas(ai^.hd, marca)
				else
					contarMarcas:= contarMarcas (ai^.hi, marca) +  contarMarcas(ai^.hd,marca);
			end;
	end;

var
	totalMarcas:integer;
	marca: string;
begin
	writeln('Ingresa marca de auto a contar: '); readln(marca);
	totalMarcas:=contarMarcas(ai, marca);
	writeln;
	writeln('La cantidad de esa marca es: ', totalMarcas);
end;

procedure ModuloC(aii:arbol2);
	function ContarLista(l:lista):integer;
	var cantidad:integer;
	begin
		cantidad:=0;
		while (l<>nil) do begin
			cantidad:=cantidad + 1;
			l:=l^.sig;
		end;
		ContarLista:=cantidad;
	end;
	
	function ContarMarcas(aii:arbol2; marca:string):integer;
	begin
		if(aii=nil) then
			ContarMarcas:=0
		else
			begin
				if(aii^.dato.marca = marca) then
					ContarMarcas:= ContarLista(aii^.dato.info)
				else if (marca < aii^.dato.marca) then
					ContarMarcas(aii^.hi, marca)
				else
					ContarMarcas(aii^.hd,marca);
			end;	
	end;
	
	var
		marca:string;
		totalMarcas:integer;
	begin
		writeln('ingrese marca a contar del a2: '); readln(marca);
		totalMarcas:=ContarMarcas(aii, marca);
		writeln;
		writeln('La cantidad es: ', totalMarcas);
	end;

var 
	ai:arbol1;
	aii:arbol2;
begin
	ModuloA(ai,aii);
	ModuloB(ai);
	ModuloC(aii);
end.
	
	
	
