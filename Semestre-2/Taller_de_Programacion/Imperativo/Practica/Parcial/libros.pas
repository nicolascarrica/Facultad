{
la biblioteca sarmiento necesita un sistema para obtener estadisticas sobre libros prestados. de cada prestao se conoce su numero de prestamo, ISBN del libro, y codigo de socio. la lectura finaliza con codigo de socio 0 y todos los prestamos realizados a un mismo socio se leen consecutivanemte.
a) implementar un modulo que lea la informacion de los prestamos y genere:
i) la estructura de datos eficiente para la busquera (ABB) ordenada por isbn de libro
ii)
una estructura dnde se almacenen los codigos de socio junto a su cantidad de prestamos.
b) implementar un modulo que reciba la estructura generada en a y un numero de isbn y devuelva la cantidad de prestamos de ese isbn
}

program bibliotecaSarmiento;
type

	prestamo = record
		numero:integer;
		isbn:integer;
		codigo: integer;
	end;
	
	socio = record
		numero:integer;
		totalPrestamos:integer;
	end;
	
	arbol =  ^nodo1;
	nodo1 = record
		dato: prestamo;
		hi:arbol;
		hd:arbol;
	end;
	
	arbol2= ^nodo2;
	nodo2 = record
		dato:socio;
		hi:arbol2;
		hd:arbol2;
	end;
	
procedure insertarPrestamo(var a: arbol; p: prestamo);
begin
	if (a=nil) then begin
		new(a);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else
		if p.isbn < a^.dato.isbn then
			insertarPrestamo(a^.hi, p)
		else
			insertarPrestamo(a^.hd, p);
end;

procedure insertarSocio(var a2: arbol2; s:socio);
begin
	if(a2=nil) then begin
		new(a2);
		a2^.dato:=s;
		a2^.hi:=nil;
		a2^.hd:=nil;
	end
	else 
		if s.numero < a2^.dato.numero then
			insertarSocio(a2^.hi, s)
		else
			insertarSocio(a2^.hd,s);
end;

procedure leerPrestamos (var a:arbol; var a2:arbol2);
var
	p: prestamo;
	codigoActual:integer;
	cantidadPrestamos:integer;
	s:socio;
begin
	writeln('ingrese codigo de socio: '); readln(p.codigo);
	while p.codigo <> 0 do begin
		codigoActual:=p.codigo;
		cantidadPrestamos:=0;
		while(p.codigo = codigoActual) and (p.codigo <> 0) do begin
			cantidadPrestamos:= cantidadPrestamos + 1;
			writeln('ingrese n de prestamo:' ); readln(p.numero);
			writeln('ingrese isbn de libro:'); readln(p.isbn);
			insertarPrestamo(a,p);
			writeln('ingrese codigo de socio: '); readln(p.codigo);
		end;
		s.numero:=codigoActual;
		s.totalPrestamos:=cantidadPrestamos;
		insertarSocio(a2, s);
	end;
end;

function cantidadxISBN(a: arbol; isbn: integer): integer;
begin
  if (a = nil) then
    cantidadxISBN := 0
  else if (a^.dato.isbn = isbn) then
    cantidadxISBN := 1 + cantidadxISBN(a^.hi, isbn) + cantidadxISBN(a^.hd, isbn)
  else
    cantidadxISBN := cantidadxISBN(a^.hi, isbn) + cantidadxISBN(a^.hd, isbn);
end;

function sumarSocios(a2: arbol2; x:integer): integer;
begin
	if(a2=nil) then
		sumarSocios:=0
	else 
		if(a2^.dato.totalPrestamos > x) then 
		sumarSocios:= 1 + sumarSocios(a2^.hi, x) + sumarSocios (a2^.hd,x);
end;

var
	a:arbol;
	a2:arbol2;
	totalIsbn:integer;
	cantidadSocios:integer;
	isbn:integer;
	valor:integer;
begin
	a:=nil;
	a2:=nil;
	leerPrestamos(a,a2);
	writeln;
	writeln('ingrese valor isbn'); readln(isbn);
	totalIsbn:= cantidadxISBN(a, isbn);
	writeln;
	writeln('la cantidad total para ese isbn es: ', totalIsbn);
	writeln;
	writeln('ingrese valor X'); readln(valor);
	cantidadSocios:= sumarSocios(a2, valor);
	writeln;
	writeln('la cantidad de socios que supera esa cantidad de prestamos es: ', cantidadSocios);
end.
			
	
	
	
