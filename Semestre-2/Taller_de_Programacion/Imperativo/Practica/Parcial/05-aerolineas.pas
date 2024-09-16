program aerolineas;
type

	pasaje = record
		vuelo:integer;
		cliente:integer;
		destino:integer;
		monto:real;
	end;
	
	datoLista =record
		vuelo:integer;
		cliente:integer;
		monto:real;
	end;
	
	lista = ^nodoL;
	nodoL =record
		dato:datoLista;
		sig:lista;
	end;
	
	datoArbol = record
		destino:integer;
		pasajes:lista;
	end;
	
	arbol =^nodoA;
	nodoA=record
		dato: datoArbol;
		hi:arbol;
		hd:arbol;
	end;
	
procedure leerPasaje(var p:pasaje);
begin
	p.monto:=Random(9999)/(Random(10)+1);
	if (p.monto <> 0) then begin
		p.vuelo:= Random(7000);
		p.cliente:=Random(100) + 1;
		p.destino:=Random(500)+1;
	end;
end;

procedure agregarAdelante(var l:lista; p:pasaje);
var nue:lista;
begin
	new(nue);
	nue^.dato.vuelo:=p.vuelo;
	nue^.dato.cliente:=p.cliente;
	nue^.dato.monto:=p.monto;
	nue^.sig:=l;
	l:=nue;
end;

procedure armarNodo (var a:arbol; p:pasaje);
begin
	if(a=nil) then begin
		new(a);
		a^.dato.destino:=p.destino;
		a^.dato.pasajes:= nil;
		agregarAdelante(a^.dato.pasajes, p);
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else if a^.dato.destino = p.destino then
		agregarAdelante(a^.dato.pasajes,p)
	else if p.destino < a^.dato.destino then
		armarNodo(a^.hi, p)
	else 
		armarNodo(a^.hd,p);
end;

procedure cargarArbol(var a:arbol);
var
	p:pasaje;
begin
	leerPasaje(p);
	while (p.monto <> 0) do begin
		armarNodo(a,p);
		leerPasaje(p);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while (l <> nil) do begin
		writeln('vuelo: ', l^.dato.vuelo, ' cliente: ', l^.dato.cliente, ' monto: ', l^.dato.monto:2:2);
		l:=l^.sig;
	end;
end;

procedure ImprimirArbol(a:arbol);
begin
	if(a<> nil) then begin
		ImprimirArbol(a^.hi);
		writeln ('destino: ', a^.dato.destino);
		writeln('------------------');
		imprimirLista(a^.dato.pasajes);
		writeln;
		ImprimirArbol(a^.hd);
	end;
end;

procedure IncisoA(var a:arbol);
begin
	writeln('<----Generando arbol----<');
	writeln;
	a:=nil;
	cargarArbol(a);
	ImprimirArbol(a);
end;

procedure IncisoB(a:arbol);
	function buscarDestino(a:arbol; destino:integer):arbol;
	begin
		if(a=nil) then
			buscarDestino:=nil
		else
			if(a^.dato.destino=destino) then
				buscarDestino:=a
			else if (destino<a^.dato.destino) then
				buscarDestino:=buscarDestino(a^.hi, destino)
			else 
				buscarDestino:=buscarDestino(a^.hd,destino);
	end;
	
var
	existe: arbol;
	destino: integer;
begin
	writeln;
	writeln('ingresar codifo de destino:'); readln(destino);
	writeln;
	existe:=buscarDestino(a, destino);
	if existe<> nil then begin
		writeln('los pasajes vendidos fueron: ');
		imprimirLista(existe^.dato.pasajes);
	end
	else
		writeln('no existe el destino');
end;
	
procedure IncisoC(a:arbol);
	function contarPasajes(l:lista):integer;
	var
		cantidad:integer;
	begin
		cantidad:=0;
		while (l<> nil) do begin
			cantidad:=cantidad +1;
			l:=l^.sig;
		end;
		contarPasajes:=cantidad;
	end;
	
	procedure maximo(a:arbol; var maxVentas:integer; var codMax:integer);
	var pasajesEnDestino:integer;
	begin
		if(a<>nil) then begin
			pasajesEnDestino:=contarPasajes(a^.dato.pasajes);
			if (pasajesEnDestino > maxVentas) then begin
				maxVentas:=pasajesEnDestino;
				codMax:=a^.dato.destino
			end;
			maximo(a^.hi, maxVentas, codMax);
			maximo(a^.hd, maxVentas, codMax);
		end;
	end;
var
	maxVentas, codMax:integer;
begin
	maxVentas:=-1;
	maximo(a, maxVentas, codMax);
	writeln;
	writeln('El codigo con mas venta es, ', codMax, ' con ', maxVentas);
end;
var 
	a:arbol;
begin
	randomize;
	IncisoA(a);
	IncisoB(a);
	IncisoC(a);
end.
