program horasTrabajadas;
type
	dias = 1..31;
	meses = 1..12;
	rangoHoras = 1..8;
	
	registro = record
		numero:integer;
		dia: dias;
		mes: meses;
		horas: rangoHoras;
	end;

	arbol = ^nodo;
	nodo = record
		dato: registro;
		hi: arbol;
		hd: arbol;
	end;
	
procedure leerRegistro (var r: registro);
	begin
		r.numero:=Random(101);
		if (r.numero <>0) then begin
			r.numero:= 500 + r.numero;
			r.dia:=1 + Random(31);
			r.mes:= 1+ Random(12);
			r.horas:= 1 + Random(8);
		end;
end;
	
procedure agregar (var a:arbol; r:registro);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:=r;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else if (a^.dato.numero > r.numero) then
			agregar(a^.hi, r)
		else
			agregar(a^.hd, r);
end;

procedure armarArbol(var a: arbol);
	var
		r:registro;
	begin
		leerRegistro(r);
		if (r.numero <> 0) then begin
			armarArbol(a);
			agregar(a,r);
		end
		else
			a:=nil;
end;
procedure imprimirArbol(a:arbol);
begin
	if (a<>nil) then begin
		imprimirArbol(a^.hi);
			writeln;
			writeln('numero de empleado: ', a^.dato.numero);
			writeln('dia: ', a^.dato.dia);
			writeln('mes: ', a^.dato.mes);
			writeln('horas: ', a^.dato.horas);
		imprimirArbol(a^.hd);
	end;
end;

procedure generaRango(a:arbol; var a2:arbol);

	procedure armarNuevoArbol (var a2:arbol; a:arbol; x,y:integer);
	begin
		if (a<>nil) then begin
			if(a^.dato.numero >= x) then
				armarNuevoArbol(a2,a^.hi,x,y);
			if(a^.dato.numero >= x) and (a^.dato.numero<=y) then
				agregar(a2, a^.dato);
			if(a^.dato.numero <= y) then
				armarNuevoArbol(a2, a^.hd, x, y);
		end;
	end;
var x, y :integer;
begin
		writeln('Ingrese rango de numeros: ');
		writeln('ingrese  valor 1: ');
		readln(x);
		writeln('Ingrese valor 2: ');
		readln(y);
		armarNuevoArbol(a2, a, x,y);
		writeln('nuevos datos: ');
		imprimirArbol(a2);
end;	

function sumaRecursiva(a2:arbol):integer;
begin
	if(a2=nil) then
		sumaRecursiva:=0
	else
		begin
			sumaRecursiva:=a2^.dato.horas;
			sumaRecursiva:= sumaRecursiva + sumaRecursiva(a2^.hi) + sumaRecursiva(a2^.hd);
		end;
end;
var 
	a,a2:arbol;	
	sumaHoras:integer;
begin
	Randomize;
	a:=nil;
	a2:=nil;
	armarArbol(a); // inciso A
	imprimirArbol(a);
	generaRango (a, a2); // inciso B
	sumaHoras:=sumaRecursiva(a2);
	writeln ('El total de hora es: ', sumaHoras);
	
end.
