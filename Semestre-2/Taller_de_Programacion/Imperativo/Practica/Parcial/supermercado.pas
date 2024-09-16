{
Un supermercado quiere llevar un registro de todas sus ventas, de cada venta se lee el codigo, dni del cliente, suscursal en la que compró (1..5) y monto gastado, 
la lectura se detiene con el código de venta 0, se pide:

A- crear una estructura eficiente para la busqueda por dni de cliente, de cada cliente se guarda el monto gastado en cada sucursal

B-un módulo que reciba la estructura generada en A y un número de sucursal y retorne la cantidad de clientes que no gastaron nada en la sucursal

C-un modulo que reciba la estructura generara en A y un dni y retorne el monto total general gastado por dicho dni (es decir, la suma de los montos de todas las sucursales)

}
program supermercado;
const dimF=5;
type
	r_sucursal = 1..5;
	
	venta = record
		codigo:integer;
		dni:integer;
		sucursal:r_sucursal;
		monto:real;
	end;
	
	vector = array [1..dimF] of real;
	
	datoArbol = record
		dni: integer;
		gastado:vector;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: datoArbol;
		hi:arbol;
		hd:arbol;
	end;
	
procedure iniciarContador (var v:vector);
var i:integer;
begin
	for i:=1 to dimF do begin
		v[i]:=0;
	end;
end;

procedure LeerVenta(var v:venta);
begin
	v.codigo:= Random(100);
	if v.codigo <>0 then begin
		v.dni:=Random(50) + 1;
		v.sucursal:=Random(5) + 1;
		v.monto:=Random(500)+1;
	end;
end;

procedure armarNodo (var a:arbol; v:venta);
begin
	if (a=nil) then begin
		new(a);
		a^.dato.dni:=v.dni;
		iniciarContador(a^.dato.gastado);
		a^.dato.gastado[v.sucursal]:= v.monto;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else 
			if(a^.dato.dni = v.dni) then
				a^.dato.gastado[v.sucursal]:= a^.dato.gastado[v.sucursal] + v.monto
			else if (a^.dato.dni > v.dni) then
				armarNodo(a^.hi, v)
			else
				armarNodo(a^.hd, v);

end;

procedure CrearArbol (var a:arbol);
var v:venta;
begin
	LeerVenta(v);
	while(v.codigo<>0) do begin
		armarNodo(a,v);
		LeerVenta(v);
	end;
end;

procedure ImprimirVector(v:vector);
var i:integer;
begin
	for i:=1 to dimF do begin
		writeln('sucursal ',i, '- monto: ', v[i]:2:2);
	end;
end;

procedure ImprimirArbol(a:arbol);
begin
	if (a<>nil) then begin
		ImprimirArbol(a^.hi);
		writeln('dni cliente: ', a^.dato.dni);
		ImprimirVector(a^.dato.gastado);
		ImprimirArbol(a^.hd);
	end;
end;

Procedure insisoA(a:arbol);
begin
	writeln('<----generando arbol de datos---->');
	writeln;
	CrearArbol(a);
	ImprimirArbol(a);
end;

procedure insisoB(a: arbol);
  
  function contarClientesSinGasto(a: arbol; sucursal: integer): integer;
  begin
    if (a = nil) then
      contarClientesSinGasto := 0
    else
    begin
      if (a^.dato.gastado[sucursal] = 0) then begin
        contarClientesSinGasto := 1 + contarClientesSinGasto(a^.hi, sucursal) + contarClientesSinGasto(a^.hd, sucursal);
        writeln('aaa: ', contarClientesSinGasto);
       end
      else
        contarClientesSinGasto := contarClientesSinGasto(a^.hi, sucursal) + contarClientesSinGasto(a^.hd, sucursal);
    end;
  end;

var
  cantidad: integer;
  sucursal: integer;
begin
  writeln('Ingrese sucursal (1..5): ');
  readln(sucursal);
  cantidad := contarClientesSinGasto(a, sucursal);
  writeln('La cantidad de clientes que no compraron en la sucursal ', sucursal, ' es: ', cantidad);
end;

var
	a:arbol;
begin
	randomize;
	a:=nil;
	insisoA(a);
	insisoB(a);
	
end.
