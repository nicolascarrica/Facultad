program correoArgentino;

type
	sub_dia = 1..31;

	envio = record
		cliente: integer;
		cod_postal: integer;
		dia: sub_dia;
		peso: real;
	end;

	envioLista = record
		cod_cliente: integer;
		dia: integer;
		peso: real;
	end;

	listaEnvios = ^nodoL;
	nodoL = record
		dato: envioLista;
		sig: listaEnvios;
	end;

	envioArbol = record
		cod_postal: integer;
		envios: listaEnvios;
	end;

	arbol = ^nodoA;
	nodoA = record
		dato: envioArbol;
		hi: arbol;
		hd: arbol;
	end;

procedure imprimirLista(l: listaEnvios);
begin
	while (l <> nil) do 
	begin
		writeln('Cliente: ', l^.dato.cod_cliente, ', Dia: ', l^.dato.dia, ', Peso: ', l^.dato.peso:0:2);
		writeln;
		l := l^.sig;
	end;
end;


procedure imprimirArbol(a: arbol);
begin
	if a <> nil then 
	begin
		imprimirArbol(a^.hi);  
		writeln('Codigo Postal: ', a^.dato.cod_postal);
		writeln;
		writeln('--------------------------');
		imprimirLista(a^.dato.envios); 
		imprimirArbol(a^.hd);  
	end;
end;
procedure ModuloA(var a:arbol);
procedure leerEnvio(var e: envio);
begin
	e.peso := random(500) / (Random(10) + 1);
	if (e.peso <> 0) then 
	begin
		e.cliente := Random(50) + 1;
		// Para propósitos de prueba, fijamos el código postal a un rango limitado
		e.cod_postal := Random(15) + 1;  // Solo 5 códigos postales diferentes
		e.dia := random(31) + 1;
	end;
end;

procedure agregarAdelante(var l: listaEnvios; e: envio);
var
	nue: listaEnvios;
begin
	new(nue);
	nue^.dato.cod_cliente:=e.cliente;
	nue^.dato.dia:=e.dia;
	nue^.dato.peso:=e.peso;
	nue^.sig := l;
	l := nue;
end;

procedure insertarElemento(var a: arbol; e: envio);
begin
	if (a = nil) then 
	begin
		// Si el nodo es nuevo, se crea y se agrega el envío.
		new(a);
		a^.dato.cod_postal := e.cod_postal;
		a^.dato.envios := nil;
		agregarAdelante(a^.dato.envios, e);
		a^.hi := nil;
		a^.hd := nil;
	end
	else 
		if (e.cod_postal = a^.dato.cod_postal) then 
			agregarAdelante(a^.dato.envios, e)
		else if (e.cod_postal < a^.dato.cod_postal) then
			insertarElemento(a^.hi, e)
		else
			insertarElemento(a^.hd, e);
end;

procedure armarArbol(var a: arbol);
var
	e: envio;
begin
	leerEnvio(e);
	while e.peso <> 0 do 
	begin
		insertarElemento(a, e);
		leerEnvio(e);
	end;
end;


begin
	a := nil;
	armarArbol(a);
	writeln('Envios agrupados por código postal:');
	imprimirArbol(a);
end;

procedure ModuloB(a:arbol; var l:listaEnvios);
	function buscarPorCp(a:arbol; cp:integer):arbol;
	begin
		if (a = nil) then
			buscarPorCp:=nil
		else if a^.dato.cod_postal = cp then begin
			buscarPorCp:= a
		end
		else if cp < a^.dato.cod_postal then
			buscarPorCp:=buscarPorCp(a^.hi, cp)
		else
			buscarPorCp:=buscarPorCp(a^.hd, cp);
	end;

var 
	cp:integer;
	nodo:arbol;
begin
	writeln('Ingreso de cp: ');
	readln(cp);
	nodo:= buscarPorCp(a,cp);
	if nodo <> nil then begin
		writeln('codigo postal ' , nodo^.dato.cod_postal);
		l:=nodo^.dato.envios;
		writeln('lista elegida');
		imprimirLista(l);
	end;
end;
procedure ModuloC(l:listaEnvios);
	procedure minPesoMaxPeso(l:listaEnvios; var codMin, codMax:integer; var pesoMin, PesoMax: real);
	begin
		if (l<> nil) then begin
			if l^.dato.peso < pesoMin then begin
				pesoMin:=l^.dato.peso;
				codMin:= l^.dato.cod_cliente;
			end;
			if l^.dato.peso>pesoMax then begin
				pesoMax:= l^.dato.peso;
				codMax:= l^.dato.cod_cliente;
			end;
			minPesoMaxPeso(l^.sig, codMin, codMax, pesoMin, pesoMax);
		end;
	end;

var
	codMin, codMax: integer;
	pesoMin, pesoMax:real;
begin
	pesoMin:= 5000;
	pesoMax:=-1;
	minPesoMaxPeso(l,  codMin, codMax, pesoMin, pesoMax);
	writeln('el codigo de peso minimo es: ', codMin);
	writeln('el codigo de peso maximo es: ', codMax);
end;
var 
	a:arbol;
	l:listaEnvios;
begin
	randomize;
	ModuloA(a);
	ModuloB(a,l);
	ModuloC(l);
end.


