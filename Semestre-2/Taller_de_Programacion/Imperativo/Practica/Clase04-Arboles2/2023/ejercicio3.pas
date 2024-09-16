{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
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
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
		}

program prestamos;

type
	r_dia = 1..31;
	r_mes = 1..12;
	prestamo = record
		isbn: integer;
		socio: integer;
		dia: r_dia;
		mes: r_mes;
		totaldias: integer;
	end;

	datoLista = record
		socio: integer;
		dia: r_dia;
		mes: r_mes;
		totalDias: integer;
	end;

	lista = ^nodoL;
	nodoL = record
		dato: datoLista;
		sig: lista;
	end;

	prestamoISBN = record
		isbn: integer;
		prestamos: lista;
	end;

	arbol = ^nodoA;
	nodoA = record
		dato: prestamo;
		hi: arbol;
		hd: arbol;
	end;

	arbol2 = ^nodoA2;
	nodoA2 = record
		dato: prestamoISBN;
		hi: arbol2;
		hd: arbol2;
	end;

procedure leerPrestamo(var p: prestamo);
begin
	p.isbn := random(200) - 1;  // ISBN en el rango de 1 a 200
	if p.isbn <> -1 then
	begin
		p.socio := random(200) + 1;
		p.dia := random(31) + 1;
		p.mes := random(12) + 1;
		p.totaldias := random(31) + 1;
	end;
end;

procedure agregarAdelante(var l: lista; p: prestamo);
var
	nue: lista;
begin
	new(nue);
	nue^.dato.socio := p.socio;
	nue^.dato.dia:=p.dia;
	nue^.dato.mes:=p.mes;
	nue^.dato.totalDias:=p.totalDias;
	nue^.sig := l;
	l := nue;
end;

procedure armarArbol1(var a: arbol; p: prestamo);
begin
	if a = nil then
	begin
		new(a);
		a^.dato := p;
		a^.hi := nil;
		a^.hd := nil;
	end
	else if p.isbn < a^.dato.isbn then
		armarArbol1(a^.hi, p)
	else
		armarArbol1(a^.hd, p);
end;

procedure armarArbol2(var a2: arbol2; p: prestamo);
var aux:arbol2;
begin
	if a2 = nil then
	begin
		new(aux);
		aux^.dato.isbn := p.isbn;
		aux^.dato.prestamos := nil;
		agregarAdelante(aux^.dato.prestamos, p);
		aux^.hi := nil;
		aux^.hd := nil;
		a2:=aux
	end
	else if p.isbn = a2^.dato.isbn then
		agregarAdelante(a2^.dato.prestamos, p)
	else if p.isbn < a2^.dato.isbn then
		armarArbol2(a2^.hi, p)
	else
		armarArbol2(a2^.hd, p);
end;
procedure ImprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		ImprimirArbol(a^.hi);
		writeln('isbn: ', a^.dato.isbn, 
			' socio: ', a^.dato.socio, 
			'| dia :', a^.dato.dia,
			'| mes: ', a^.dato.mes,
			'| dias de prestamo: ', a^.dato.totalDias);
		ImprimirArbol(a^.hd);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while (l<>nil) do begin
		writeln(' socio: ', l^.dato.socio,
			'| dia :', l^.dato.dia,
			'| mes: ', l^.dato.mes,
			'| dias de prestamo: ',l^.dato.totalDias);
		l:=l^.sig;
	end;
end;

procedure ImprimirArbol2(a2:arbol2);
begin
	if(a2<>nil) then begin
		ImprimirArbol2(a2^.hi);
		writeln('isbn: ',a2^.dato.isbn);
		imprimirLista(a2^.dato.prestamos);
		ImprimirArbol2(a2^.hd);
	end;
end;

procedure ModuloA(var a: arbol; var a2: arbol2);
var
	p: prestamo;
begin
	writeln('----- Generando arboles ---');
	a := nil;
	a2 := nil;
	leerPrestamo(p);
	while (p.isbn <> -1) do
	begin
		armarArbol1(a, p);
		armarArbol2(a2, p);
		leerPrestamo(p);
	end;
	writeln('-----------------------------------');
	writeln('arbol1');
	ImprimirArbol(a);
	writeln;
	writeln;
	writeln('arbol 2');
	ImprimirArbol2(a2);
	
end;

Procedure ModuloB(a:arbol);
	function obtenerMaximo(a:arbol):integer;
	begin
		if(a^.hd =nil)then	
			obtenerMaximo:=a^.dato.isbn
		else
			obtenerMaximo:=obtenerMaximo(a^.hd);
	end;
var
maximo: integer;
begin
	maximo:=obtenerMaximo(a);
	writeln;
	writeln('El isbn Maximo es: ', maximo);
	
end;

procedure ModuloC(a2:arbol2);
	function obtenerMinimo(a2:arbol2):integer;
	begin
		if(a2^.hi=nil) then
			obtenerMinimo:=a2^.dato.isbn
		else
			obtenerMinimo:=obtenerMinimo(a2^.hi);
	end;
var
	minimo:integer;
begin
	minimo:=obtenerMinimo(a2);
	writeln;
	writeln('eL ISBN MINIMO ES: ', minimo);
end;

procedure ModuloD(a:arbol; socio:integer);
	function contarSocios(a:arbol; socio:integer):integer;
	begin
		if (a=nil) then 
			contarSocios:=0
		else
			if(a^.dato.socio = socio) then
				contarSocios := 1 + contarSocios(a^.hi, socio) + contarSocios(a^.hd, socio)
            else
				contarSocios := contarSocios(a^.hi, socio) + contarSocios(a^.hd, socio);
	end;
var
	prestamos:integer;
begin
	writeln;
	writeln('ingrese n de socio: '); readln(socio);
	writeln;
	prestamos:=contarSocios(a,socio);
	writeln('La cantidad de prestamos es arbol1:', prestamos);
end;

procedure ModuloE(a2:arbol2; socio:integer);
	function contarEnLista (l:lista; socio:integer):integer;
	begin
		if(l=nil) then
			contarEnLista:=0
		else
			if (l^.dato.socio = socio) then
				contarEnLista:=1 +contarEnLista(l^.sig, socio)
			else 
				contarEnLista:=contarEnLista(l^.sig, socio);
	end;
	
	function cantidadPrestamos(a2:arbol2; socio:integer):integer;
	begin
		if a2=nil then
			cantidadPrestamos:=0
		else
			cantidadPrestamos:=contarEnLista(a2^.dato.prestamos,socio)+
								cantidadPrestamos(a2^.hi, socio)+
								cantidadPrestamos(a2^.hd, socio);
	end;
var
	prestamos:integer;
begin
	writeln;
	writeln('ingrese n de socio: '); readln(socio);
	prestamos:=cantidadPrestamos(a2,socio);
	writeln;
	writeln('La cantidad de prestamos es:', prestamos);
end;
var
	a: arbol;
	a2: arbol2;
	s:integer;
begin
	s:=0;
	Randomize;  // Inicializa el generador de números aleatorios
	ModuloA(a, a2);
	ModuloB(a);
	ModuloC(a2);
	ModuloD(a,s);
	ModuloE(a2,s);
	//falta temrinar
end.
