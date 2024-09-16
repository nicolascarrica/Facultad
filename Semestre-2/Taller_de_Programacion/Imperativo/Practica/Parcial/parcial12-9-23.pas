program parcial12923;
const dimf = 12;
type
	sub_mes = 1..12;
	compra = record
		cliente: integer;
		mes: sub_mes;
		monto: real;
	end;
	
	vector = array [1..dimF] of real;
	
	datosArbol = record
		cliente:integer;
		montos: vector;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: datosArbol;
		hi:arbol;
		hd:arbol;
	end;
	
procedure ModuloA(var a:arbol);
	procedure LeerCompra(var c:compra);
	begin
		c.cliente:=Random(100);
		if(c.cliente<>0) then begin
			c.monto:=Random(20000) / (Random(10)+1);
			c.mes:= Random(12) + 1;
		end;
	end;
	
	procedure IniciarVectorMontos(var v:vector);
	var i:sub_mes;
	begin
		for i:=1 to dimF do 
			v[i]:=0;
	end;
	
	procedure ArmarNodo(var a :arbol; c:compra);
	begin
		if(a=nil) then begin
			new(a);
			a^.dato.cliente:=c.cliente;
			IniciarVectorMontos(a^.dato.montos);
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else if (a^.dato.cliente = c.cliente) then
			a^.dato.montos[c.mes]:= a^.dato.montos[c.mes] + c.monto
		else if c.cliente < a^.dato.cliente then
			ArmarNodo(a^.hi, c)
		else
			ArmarNodo(a^.hd, c);
	end;
	
	procedure ArmarArbol(var a:arbol);
	var c:compra;
	begin
		LeerCompra(c);
		while(c.cliente<>0) do begin
			ArmarNodo(a,c);
			LeerCompra(c);
		end;
	end;
	
	procedure ImprimirVector(v:vector);
	var i:integer;
	begin
		for i:=1 to dimF do begin
			write('mes ',i, ', monto: ', v[i]:2:2);
			writeln;
		end;
	end;
	
	procedure ImprimirArbol(a:arbol);
	begin
		if(a<>nil) then begin
			ImprimirArbol(a^.hi);
			writeln;
			writeln('cliente: ', a^.dato.cliente);
			ImprimirVector(a^.dato.montos);
			ImprimirArbol(a^.hd);
		end;
	end;
	
begin
	a:=nil;
	writeln('arbol de datos: ');
	ArmarArbol(a);
	ImprimirArbol(a);
end;

procedure ModuloB(a:arbol);
	procedure BuscarMaximo(v:vector; var maximo:real; var mesMax:integer);
	var i:integer;
	begin
		for i:= 1 to dimF do begin
			if(v[i] > maximo) then begin
				maximo:=v[i];
				mesMax:=i;
			end;
		end;
	end;
	
	procedure mayorGasto(a:arbol; cliente:integer; var maximo:real ; var mesMax:integer);
	begin
		if (a = nil) then
			writeln('arbol vacio')
		else if (a^.dato.cliente=cliente) then
			BuscarMaximo(a^.dato.montos, maximo, mesMax)
		else if ( cliente < a^.dato.cliente) then
			mayorGasto(a^.hi, cliente, maximo, mesMax)
		else
			mayorGasto(a^.hd, cliente, maximo, mesMax)
	end;
var
	mesMax, cliente:integer;
	maximo:real;
begin
	maximo:=-1;
	writeln('ingreso de cliente: '); readln(cliente);
	mayorGasto(a, cliente, maximo, mesMax);
	writeln(' el mes de mas gasto es: ', mesMax);
end;

procedure ModuloC(a:arbol);
	function noGasto(v:vector; mes:integer):boolean;
	var cumple:boolean;
	begin
		cumple:=false;
		if v[mes]=0 then
			cumple:= true;
		noGasto:=cumple;
	end;

 function ContarClientes(a:arbol; mes:integer): integer;
 begin
	if (a=nil) then
		ContarClientes:=0
	else begin
		if noGasto(a^.dato.montos, mes) then
			ContarClientes:= 1 + ContarClientes(a^.hi, mes) + ContarClientes(a^.hd, mes)
		else ContarClientes:= ContarClientes(a^.hi, mes) + ContarClientes(a^.hd, mes);
	end;
 end;

var cantidad:integer;
	mes:integer;
begin
	writeln;
	writeln('ingrese mes: '); readln(mes);
	cantidad:=ContarClientes(a, mes);
	writeln('la cantidad de clientes sin gasto en ese mes es: ', cantidad);
end;


var
	a:arbol;
begin
	ModuloA(a);
	ModuloB(a);
	ModuloC(a);
end.
