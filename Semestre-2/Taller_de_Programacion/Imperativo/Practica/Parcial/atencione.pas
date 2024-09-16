program carrica;
const dimF = 15;
type
	r_mes = 0..31;
	r_diag = 1..dimF;
	
	atencion=record
		dni:integer;
		mes:r_mes;
		diagnostico:r_diag;
	end;
	
	datoArbol = record
		dni:integer;
		atenciones:integer;
	end;
	
	arbol=^nodo;
	nodo=record
		dato: datoArbol;
		hi:arbol;
		hd:arbol;
	end;
	
	vector = array [1..dimF] of integer;
	
	procedure ModuloA(var a:arbol; var v:vector);
		procedure LeerAtencion(var at:atencion);
		begin
			at.mes:=Random(32);
			if(at.mes<>0) then begin
				at.dni:= Random(50);
				at.diagnostico:= Random(dimF) + 1;
			end;
		end;
		
		procedure InicarVector(var v:vector);
		var i: integer;
		begin
			for i:=1 to dimF do 
				v[i]:=0;
		end;
		
		procedure ArmarNodo(var a:arbol; at:atencion);
		begin
			if (a=nil) then begin
				new(a);
				a^.dato.dni:=at.dni;
				a^.dato.atenciones:=1;
				a^.hi:=nil;
				a^.hd:=nil;
			end
			else
				begin
					if (at.dni=a^.dato.dni) then
						a^.dato.atenciones:= a^.dato.atenciones + 1
					else if (at.dni<a^.dato.dni) then
						ArmarNodo(a^.hi, at)
					else
						ArmarNodo(a^.hd, at);
				end;
		end;
		
		procedure CargarEstructuras(var a:arbol; var v:vector);
		var at:atencion;
		begin
			LeerAtencion(at);
			while (at.mes<>0) do begin
				ArmarNodo(a, at);
				v[at.diagnostico]:=v[at.diagnostico] +1;
				LeerAtencion(at);
			end;
		end;
		
		procedure ImprimirArbol(a:arbol);
		begin
			if(a<>nil) then begin
			ImprimirArbol(a^.hi);
			writeln('Dni :', a^.dato.dni, ', atenciones: ', a^.dato.atenciones);
			writeln;
			ImprimirArbol(a^.hd);
			end;
		end;
		
		procedure ImprimirVector(v:vector);
		var i:integer;
		begin
			for i:=1 to dimF do begin
				writeln('diagnostico ', i);
				writeln('total atenciones: ', v[i]);
			end;
		end;
				
	begin
		a:=nil;
		InicarVector(v);
		writeln('cargandoDatos');
		CargarEstructuras(a,v);
		writeln('estructura i');
		ImprimirArbol(a);
		writeln;
		writeln('estructura ii');
		ImprimirVector(v);
		writeln;
	end;

{
procedure ModuloB(a:arbol);
	function buscarEntre2(a:arbol; dni1, dni2, x: integer):integer;
	begin
		if (a=nil) then
			buscarEntre2:=0
		else
			begin
				if (dni1<=a^.dato.dni) and (dni2>=a^.dato.dni) then begin
					if (a^.dato.atenciones = x) then
						buscarEntre2:=1
					else
						buscarEntre2:=0;
					buscarEntre2:=buscarEntre2 + buscarEntre2(a^.hi, dni1,dni2,x) + buscarEntre2(a^.hd, dni1, dni2,x);
				end
				else if dni1<a^.dato.dni then
					buscarEntre2:=buscarEntre2(a^.hi, dni1,dni2,x)
				else
					buscarEntre2:=buscarEntre2(a^.hd, dni1,dni2,x);
			end;
	end;
}
	
	procedure ModuloB(a: arbol);
  function buscarEntre2(a: arbol; dni1, dni2, x: integer): integer;
  begin
    if (a = nil) then
      buscarEntre2 := 0
    else
    begin
      // Inicialmente, no contamos el nodo
      buscarEntre2 := 0;
      
      // Si el DNI del nodo está dentro del rango, evaluamos si cumple con el número de atenciones
      if (dni1 <= a^.dato.dni) and (dni2 >= a^.dato.dni) then
      begin
        if (a^.dato.atenciones > x) then
          buscarEntre2 := 1; // Contamos el nodo si cumple la condición
        // Ahora sumamos los resultados de las búsquedas en ambos subárboles
        buscarEntre2 := buscarEntre2 + buscarEntre2(a^.hi, dni1, dni2, x) + buscarEntre2(a^.hd, dni1, dni2, x);
      end
      else if (a^.dato.dni < dni1) then
        // Si el nodo actual está por debajo del rango, solo buscamos en el subárbol derecho
        buscarEntre2 := buscarEntre2(a^.hd, dni1, dni2, x)
      else
        // Si el nodo actual está por encima del rango, solo buscamos en el subárbol izquierdo
        buscarEntre2 := buscarEntre2(a^.hi, dni1, dni2, x);
    end;
  end;

var
  cantidad, dni1, dni2, x: integer;
begin
  writeln('Ingrese valor DNI 1: '); readln(dni1);
  writeln('Ingrese valor DNI 2: '); readln(dni2);
  writeln('Ingrese valor a buscar X: '); readln(x);
  cantidad := buscarEntre2(a, dni1, dni2, x);
  writeln('La cantidad es: ', cantidad);
end;
	
procedure ModuloC(v: vector);
  function contarRecursivo(v: vector; indice: integer): integer;
  begin
    // Caso base: detener la recursión cuando el índice es 0
    if (indice = 0) then
      contarRecursivo := 0
    else
      // Condición recursiva: mientras indice > 0
      if (v[indice] = 0) then
        contarRecursivo := 1 + contarRecursivo(v, indice - 1)
      else
        contarRecursivo := contarRecursivo(v, indice - 1);
  end;

var
  cantidad: integer;
begin
  // Inicia la recursión desde el último índice del vector
  cantidad := contarRecursivo(v, dimF);
  writeln('La cantidad de diagnostico con cero atenciones son: ', cantidad);
end;

var
	a:arbol;
	v:vector;
begin
randomize;
ModuloA(a,v);
ModuloB(a);
ModuloC(v);
end.
