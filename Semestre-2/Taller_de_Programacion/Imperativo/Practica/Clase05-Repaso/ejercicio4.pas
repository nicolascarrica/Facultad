{
Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se ingresa código, DNI de la persona, año y tipo de reclamo. El ingreso finaliza con el
código de igual a 0. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}

program reclamos;

type
  r_tipo = 1..10;
  reclamo = record
    codigo: integer;
    dni:integer;
    anio: integer;
    tipo: r_tipo;
  end;
  
  datosLista = record
    codigo:integer;
    anio:integer;
    tipo:r_tipo;
  end;
  
  lista = ^nodoL;
  nodoL = record
    dato: datosLista;
    sig:lista;
  end;
  
  datosArbol = record
    dni: integer;
    cantidad_reclamos: integer;
    lista_reclamos: lista;
  end;
  
  arbol = ^nodoA;
  nodoA = record
    dato: datosArbol;
    hi:arbol;
    hd:arbol;
  end;
  
  lista2=^nodoL2;
  nodoL2 = record
		dato:integer;
		sig:lista2;
	end;

procedure LeerReclamo(var r:reclamo);
begin
  r.codigo:= random(200);
  if (r.codigo <> 0 ) then begin
    r.anio:= 2010 + random(14) + 1;
    r.tipo:= random(10) + 1;
    r.dni:= random(25) + 1;
  end;
end;

procedure AgregarAdelante (var l:lista; r:reclamo);
var
  nue:lista;
begin
  new(nue);
  nue^.dato.anio:= r.anio;
  nue^.dato.tipo:= r.tipo;
  nue^.dato.codigo:=r.codigo;
  nue^.sig:=l;
  l:=nue;
end;

procedure ImprimirLista(l:lista);
begin
  while (l<>nil) do begin
    writeln('Codigo: ', l^.dato.codigo, ', Anio: ', l^.dato.anio, ', tipo: ', l^.dato.tipo);
    writeln;
    l:=l^.sig;
  end;
end;

procedure ImprimirArbol(a:arbol);
begin
  if (a <> nil) then begin
    ImprimirArbol(a^.hi);
    writeln('Dni: ', a^.dato.dni);
    writeln('Cantidad de Reclamos: ', a^.dato.cantidad_reclamos);
    ImprimirLista(a^.dato.lista_reclamos);
    ImprimirArbol(a^.hd);
  end;
end;

procedure ModuloA(var a:arbol);
  procedure ArmarNodo (var a:arbol; r:reclamo);
  begin
    if (a=nil) then begin
      new(a);
      a^.dato.dni:=r.dni;
      a^.dato.lista_reclamos:=nil;
      a^.dato.cantidad_reclamos:=1;
      AgregarAdelante(a^.dato.lista_reclamos, r);
      a^.hi:=nil;
      a^.hd:=nil;
    end
    else 
    begin 
      if (r.dni = a^.dato.dni) then begin
	a^.dato.cantidad_reclamos:=a^.dato.cantidad_reclamos + 1;
	AgregarAdelante(a^.dato.lista_reclamos, r);
      end
      else if (r.dni < a^.dato.dni) then
	ArmarNodo(a^.hi, r)
      else 
	ArmarNodo(a^.hd,r);
    end;
  end;
  
  procedure CargarArbol (var a:arbol);
  var r:reclamo;
  begin
    writeln('aaa');
    LeerReclamo(r);
    while (r.codigo <> 0) do begin
      ArmarNodo(a, r);
      LeerReclamo(r);
    end;
  end;
  
begin
  a:=nil;
  writeln('<----Arbol de datos---->');
  CargarArbol(a);
  ImprimirArbol(a);
end;

procedure ModuloB(a:arbol);
  function buscarDni(a:arbol; dni:integer):arbol;
  begin
    if a=nil then
      buscarDni:=nil
    else
      begin
	if (dni = a^.dato.dni) then
	  buscarDni:=a
	else if (dni<a^.dato.dni) then
	  buscarDni:= buscarDni(a^.hi, dni)
	else 
	  buscarDni:= buscarDni(a^.hd, dni)
      end;
  end;

var
  dni:integer;
  hoja:arbol;
begin
  writeln('ingerese dni: '); readln(dni);
  hoja:=buscarDni(a, dni);
  if (hoja = nil) then
    writeln('no existe el usuario')
  else
    writeln('la Cnatidad de reclamos para ese dni es:', hoja^.dato.cantidad_reclamos);
end;


procedure ModuloC(a:arbol);
  function buscarEntreDos(a:arbol; dni1, dni2:integer): integer;
  begin
    if(a=nil) then
      buscarEntreDos:=0
    else
      begin
	if(dni1<a^.dato.dni) and (dni2>a^.dato.dni) then
	  buscarEntreDos:= a^.dato.cantidad_reclamos + buscarEntreDos(a^.hi, dni1, dni2) + buscarEntreDos(a^.hd, dni1, dni2)
	else if (dni1>=a^.dato.dni) then
	  buscarEntreDos:=buscarEntreDos(a^.hd, dni1, dni2)
	else
	  buscarEntreDos:= buscarEntreDos(a^.hi, dni1, dni2)
      end;
  end;
  
var
    dni1, dni2:integer;
    cantidad:integer;
begin
  writeln('Ingrese dni 1:'); readln(dni1);
  writeln;
  writeln('ingrese dni 2:'); readln(dni2);
  cantidad:=buscarEntreDos(a,dni1, dni2);
  writeln('la cantidad entre dos dni es: ', cantidad);
end;



procedure ModuloD(a:arbol);
	procedure AgregarALista(var l:lista2; dato:integer);
	var nue: lista2;
	begin
		new(nue);
		nue^.dato:=dato;
		nue^.sig:=l;
		l:=nue;
	end;
	
  procedure ObtenerCodigos(a:arbol; anio:integer; var l:lista2);
  var reclamoActual: lista;
  begin
		if(a<>nil) then begin
			reclamoActual:=a^.dato.lista_reclamos;
			while reclamoActual <> nil do begin
				if(reclamoActual^.dato.anio = anio) then
					AgregarALista(l, reclamoActual^.dato.codigo);
				reclamoActual:=reclamoActual^.sig;
			end;
			ObtenerCodigos(a^.hi, anio, l);
			ObtenerCodigos(a^.hd, anio, l);
		end;
  end;
  
  
  procedure Imprimir(l:lista2);
  begin
		while l<>nil do begin
			write(l^.dato);
			writeln;
			l:=l^.sig;
		end;
  end;
 
var l:lista2; anio:integer;
begin
	l:=nil;
	writeln('ingrese anio:'); readln(anio);
	ObtenerCodigos(a, anio, l);
	writeln('codigos para el anio ', anio);
	Imprimir(l);

end;


//PROGRAMA PPAL
var a:arbol;
begin
  randomize;
  ModuloA(a);
  ModuloB(a);
  ModuloC(a);
  ModuloD(a);
end.
  
  
  
  
  
  
  
  
  
  
  
  
