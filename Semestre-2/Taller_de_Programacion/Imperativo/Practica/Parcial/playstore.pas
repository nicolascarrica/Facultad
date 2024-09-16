program playStore;
const dimF=12;
type
	sub_dia = 1..31;
	sub_mes=1..12;
	compra= record
		videojuego:integer;
		cliente:integer;
		dia:sub_dia;
		mes: sub_mes;
	end;
	
	datosLista = record
		videojuego:integer;
		dia:sub_dia;
		mes:sub_mes;
	end;
	
	lista = ^nodoL;
	nodoL = record
		dato:datosLista;
		sig:lista;
	end;
	
	datosArbol = record
		cliente:integer;
		compras:lista;
	end;
	
	arbol = ^nodoA;
	nodoA = record
		dato:datosArbol;
		hi:arbol;
		hd: arbol;
	end;
	
	vector = array [1..dimF] of integer;
	
procedure ImprimirVector(v:vector);
	var i:sub_mes;
	begin
		for i:=1 to dimF do begin
			writeln('mes ', i, ' Compras: ', v[i]);
			writeln;
		end;
	end;
procedure ModuloA(var a:arbol; var v:vector);
	procedure leerCompra(var c:compra);
	begin
		c.cliente:= Random(100);
		if(c.cliente <>0) then begin
			c.dia:=Random(31) + 1;
			c.mes:= Random(12) + 1;
			c.videojuego:= Random(20000) + 1;
		end;
	end;
	
	procedure AgregarAdelante(var l:lista; c: compra);
	var	nue:lista;
	begin
		new(nue);
		nue^.dato.videojuego:=c.videojuego;
		nue^.dato.mes:=c.mes;
		nue^.dato.dia:=c.dia;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure ArmarNodo(var a:arbol; c:compra);
	begin
		if(a=nil) then begin
			new(a);
			a^.dato.cliente:=c.cliente;
			a^.dato.compras:= nil;
			AgregarAdelante(a^.dato.compras, c);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else if(a^.dato.cliente = c.cliente) then
			AgregarAdelante(a^.dato.compras, c)
		else if (c.cliente < a^.dato.cliente) then
			ArmarNodo(a^.hi, c)
		else
			ArmarNodo(a^.hd, c);
	end;
	
	procedure ArmarEstructuras(var a:arbol; var v:vector);
	var c:compra;
	begin
		leerCompra(c);
		while c.cliente <> 0 do begin
			ArmarNodo(a,c);
			v[c.mes]:= v[c.mes] + 1;
			leerCompra(c);
		end;
	end;
	
	procedure ImprimirLista(l:lista);
	begin
		while (l<>nil) do begin
			writeln('dia: ', l^.dato.dia, ', mes: ', l^.dato.mes, ', videojuego: ', l^.dato.videojuego);
			l:=l^.sig;
		end;
	end;
	
	procedure ImprimirArbol(a:arbol);
	begin
		if(a<> nil) then begin
			ImprimirArbol(a^.hi);
			writeln('cliente: ', a^.dato.cliente);
			ImprimirLista(a^.dato.compras);
			ImprimirArbol(a^.hd);
		end;
	end;
	
	
	procedure iniciarVector(var v:vector);
	var i:sub_mes;
	begin
		for i:=1 to dimF do 
			v[i]:=0;
	end;
	

begin
	IniciarVector(v);
	ArmarEstructuras(a,v);
	ImprimirArbol(a);
	writeln;
	ImprimirVector(v);
end;

procedure ModuloB(a:arbol);
	function contarEnLista(l:lista):integer;
	var cantidad:integer;
	begin
		cantidad:=0;
		while l<> nil do begin
			cantidad:=cantidad + 1;
			l:=l^.sig;
		end;
		contarEnLista:=cantidad;
	end;
	
	function ContarEnArbol(a:arbol; cli:integer): integer;
	begin
		if(a=nil) then
			ContarEnArbol:=0
		else
			begin
				if(a^.dato.cliente=cli) then
					ContarEnArbol:= contarEnLista(a^.dato.compras) + ContarEnArbol(a^.hi, cli) + ContarEnArbol(a^.hd, cli)
				else if (cli<a^.dato.cliente) then
					ContarEnArbol:=ContarEnArbol(a^.hi, cli)
				else
					ContarEnArbol:= ContarEnArbol(a^.hd, cli);
			end;
	end;
	
var cantidadCompras:integer;
cli:integer;
begin
	writeln('ingrese cliente :'); readln(cli);
	cantidadCompras:= ContarEnArbol(a, cli);
	writeln;
	writeln('la cantidad de compras es: ', cantidadCompras);
end;


procedure ModuloC(var v:vector);
	procedure Ordenar(var v:vector);
	var 
		i, j, pos:integer;
		item: integer;	
	begin
		for i:=1 to dimF-1 do begin
			pos:=i;
			for j:=i+1 to dimF do 
				if v[j] > v[pos] then
					pos:=j;
				item:= v[pos];
				v[pos]:=v[i];
				v[i]:=item;
		end;
	end;

begin
	Ordenar(v);
	ImprimirVector(v);
end;
var
v:vector;
a:arbol;
begin
	ModuloA(a,v);
	ModuloB(a);
	ModuloC(v);
end.





