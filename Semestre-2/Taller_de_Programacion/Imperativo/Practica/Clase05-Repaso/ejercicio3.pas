{
Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.
}

program super;

const dimF = 10;

type 
	r_rubro = 1..10;
	
	producto = record
		codigo:integer;
		rubro:r_rubro;
		stock:integer;
		precioU:real;
	end;
	
	infoArbol = record
		codigo:integer;
		stock: integer;
		precioU: real;
	end;
	
	arbol = ^nodoA;
	nodoA= record
		dato: infoArbol;
		hi:arbol;
		hd:arbol;
	end;
	
	vector = array [1..dimF] of arbol;
	
	procedure InicarVector(var v:vector);
	var i:r_rubro;
	begin
		for i:=1 to dimF do begin
			v[i]:=nil;
		end;
	end;
	
	procedure LeerProducto(var p:producto);
	begin
		p.codigo:=random(100);
		if(p.codigo <> 0) then begin
			p.rubro:= Random (10) + 1 ;
			p.stock:= random (100);
			p.precioU:=150 + Random(500) + 1;
		end; 
	end;
	
	procedure ModuloA(var v:vector);
		procedure ArmarNodo( var a: arbol; p:producto);
		begin
			if(a=nil) then begin
				new(a);
				a^.dato.codigo:= p.codigo;
				a^.dato.stock:=p.stock;
				a^.dato.precioU:=p.precioU;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
				if(p.codigo = a^.dato.codigo) then
					a^.dato.stock:= a^.dato.stock+p.stock
				else if (p.codigo < a^.dato.codigo) then
					ArmarNodo(a^.hi, p)
				else 
					ArmarNodo(a^.hd,p);		
		end;
		
		procedure CargarVector(var v:vector);
		var p:producto;
		begin
			LeerProducto(p);
			while(p.codigo <> 0) do begin
				ArmarNodo(v[p.rubro], p);
				LeerProducto(p);
			end;
		end;
		
		procedure ImprimirArbol(a:arbol);
		begin
			if(a<>nil) then begin
				ImprimirArbol(a^.hi);
				writeln('codigo producto: ', a^.dato.codigo, ', stock: ', a^.dato.stock, ', Precio un: ', a^.dato.precioU:2:2);
				writeln;
				ImprimirArbol(a^.hd);
			end;
		end;
		
		procedure ImprimirVector(v:vector);
		var i: r_rubro;
		begin
			for i:=1 to dimF do begin
				writeln('Rubro ', i);
				ImprimirArbol(v[i]);
			end;
		end;

begin
	InicarVector(v);
	CargarVector(v);
	ImprimirVector(v);
end;

procedure ModuloB(v:vector);
	function buscarEnArbol (a:arbol; codigo:integer):boolean;
	begin
		if(a=nil) then
			buscarEnArbol:=false
		else
			begin
				if (codigo = a^.dato.codigo) then
					buscarEnArbol:= true
				else if (codigo > a^.dato.codigo) then
					buscarEnArbol:= buscarEnArbol(a^.hi, codigo)
				else 
					buscarEnArbol:=buscarEnArbol(a^.hd, codigo);
			end;
	end;
var
	esta:boolean;
	rubro:r_rubro;
	codigo:integer;
begin
	writeln;
	writeln('ingrese codigo de rubro: '); readln(rubro);
	writeln('ingrese codigo de producto: '); readln(codigo);
	esta:=buscarEnArbol(v[rubro], codigo);
	if (esta) then
		writeln('existe ese producto en el rubro', rubro)
	else
		writeln('no existe ese producto en el rubro', rubro);
end;

procedure ModuloC(v:vector);
	function ObtenerMaximoArbol(a:arbol):arbol;
	begin
		if (a=nil) then
			ObtenerMaximoArbol:=nil
		else
		begin
			if (a^.hd=nil) then
				ObtenerMaximoArbol:=a
			else
				ObtenerMaximoArbol:=ObtenerMaximoArbol(a^.hd);
		end;
	end;
var 
	i:r_rubro;
	maximo:arbol;
begin
	for i:=1 to dimF do begin
		maximo:=ObtenerMaximoArbol(v[i]);
		if(maximo<>nil) then begin
			writeln('El codigo maximo del rubro ', i,' es: ', maximo^.dato.codigo);
			writeln('El stock del procto ',maximo^.dato.codigo,' es: ', maximo^.dato.stock);
		end
		else
			writeln('Sin productos en el rubro ', i);
	end;
end;

Procedure ModuloD(v:vector);
	function entreDosValores(a:arbol; num1,num2:integer): integer;
	begin
		if (a=nil) then
			entreDosValores:=0
		else
			begin
				if (num1<a^.dato.codigo)and(num2>a^.dato.codigo) then
					entreDosValores:= 1 + entreDosValores(a^.hi, num1, num2) + entreDosValores(a^.hd, num1, num2)
				else if(num1>= a^.dato.codigo) then
					entreDosValores:=entreDosValores(a^.hd, num1, num2)
				else 
					entreDosValores:=entreDosValores(a^.hi, num1, num2)
			end;
	end;
var num1, num2: integer;
		i,cantidad:integer;
begin
	writeln;
	writeln('Ingrese valor num1: '); readln(num1);
	writeln;
	writeln('Ingrese valor num2: '); readln(num2);
	for i:=1 to dimF do begin
		writeln('para el rubro ', i);
		cantidad:=entreDosValores(v[i], num1, num2);
		writeln('la cantidad entre dos valores es: ', cantidad);
		writeln;
	end;
end;

var
	v:vector;
begin
randomize;
	ModuloA(v);
	//ModuloB(v);
	ModuloC(v);
	ModuloD(v);
end.
