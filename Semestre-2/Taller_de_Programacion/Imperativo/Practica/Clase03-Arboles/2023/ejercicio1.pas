{
. Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como
parámetro y que :
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo
recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso
vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
xi. Informe los números de socio en orden creciente.
x. Informe los números de socio pares en orden decreciente.
}

program ejercicio1;

type
	socio = record
		n_socio:integer;
		nombre: string;
		edad: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: socio;
		HI: arbol;
		HD: arbol;
	end;

procedure leerSocio(var s:socio);
begin
	writeln('LECTURA DE SOCIOS');
	writeln('Ingrese n° de socio: ');
	readln(s.n_socio);
	if (s.n_socio <> 0) then begin
		writeln('Ingrese nombre de socio: ');
		readln(s.nombre);
		writeln('Ingrese la edad del socio: ');
		readln(s.edad);
	end;
end;

procedure agregar (var a:arbol; s:socio);
begin
	if (a=nil) then begin
		new(a);
		a^.dato:=s;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if (s.n_socio <=a^.dato.n_socio) then
		agregar(a^.HI,s)
	else
		agregar(a^.HD,s);
end;

procedure armarArbol(var a:arbol);
var
	s:socio;
begin
	leerSocio(s);
	if(s.n_socio<>0) then begin
		armarArbol(a);
		agregar(a,s);
	end
	else
		a:=nil;
end;

procedure imprimirArbol(a:arbol);
begin
	if (a<>nil) then begin
		imprimirArbol(a^.HI);
		writeln('N socio: ', a^.dato.n_socio);
		writeln('Nombre : ', a^.dato.nombre);
		writeln('Edad: ', a^.dato.edad);
		imprimirArbol(a^.HD);
	end;
end;

function nSocioMaximo(a:arbol): integer;
begin
	if (a^.HD = nil) then
		nSocioMaximo:=a^.dato.n_socio
	else
		nSocioMaximo:= nSocioMaximo(a^.HD);
end;

function nSocioMinimo (a:arbol): integer;
begin
	if (a^.HI = nil) then
		nSocioMinimo:=a^.dato.n_socio
	else
		nSocioMinimo:=nSocioMinimo(a^.HI);
end;

function maximo (a,b:integer):integer;
begin
	if a > b then
		maximo:=a
	else
		maximo:=b;
end;

procedure mayorEdad(a:arbol; var max:integer); 
begin
	if (a<>nil) then begin
		mayorEdad(a^.hi,max);
			if (a^.dato.edad > max)then
				max:=a^.dato.edad;
		mayorEdad(a^.hd,max);
	end;
end;

procedure aumentarEdad (a:arbol);
begin
	if(a<>nil) then begin
		aumentarEdad(a^.HI);
		a^.dato.edad:= a^.dato.edad+1;
		aumentarEdad(a^.HD);
	end;
end;

function buscarNumero(a:arbol; numero:integer): boolean;
begin
	if(a=nil) then 
		buscarNumero:=false
	else if (a^.dato.n_socio=numero) then
		buscarNumero:=true
	else if(numero>a^.dato.n_socio) then
		buscarNumero:= buscarNumero(a^.HD, numero)
	else
		buscarNumero:= buscarNumero(a^.HI, numero);
end;

function buscarNombre(a: arbol; nombre: string): boolean;
begin
    if (a = nil) then
        buscarNombre := false
    else if (a^.dato.nombre = nombre) then
        buscarNombre := true
    else
        buscarNombre := buscarNombre(a^.HI, nombre) or buscarNombre(a^.HD, nombre);
end;

procedure totalSocios (a:arbol; var total:integer);
begin
	if(a<>nil) then begin
		totalSocios(a^.HI, total);
		total:=total+1;
		totalSocios(a^.HD,total);
	end;
end;

procedure totalEdades(a:arbol; var sumaEdades:integer);
begin
	if(a<>nil) then begin
		totalEdades(a^.HI, sumaEdades);
		sumaEdades:= sumaEdades + a^.dato.edad;
		totalEdades(a^.HD, sumaEdades);
	end;
end;

procedure ordenDecreciente(a:arbol);
begin
	if(a<>nil) then begin
		ordenDecreciente(a^.HD);
		writeln('Numero de socio: ', a^.dato.n_socio);
		ordenDecreciente(a^.HI);
	end;
end;

procedure ordenDecrecientePar(a:arbol);
begin
	if (a<>nil) then begin
		ordenDecrecientePar(a^.HD);
			if(a^.dato.edad mod 2= 0) then
				writeln('Numero de socio: ', a^.dato.n_socio);
		ordenDecrecientePar(a^.HI);
	end;
end;

var
	a: arbol;
	socioMax: integer;
	socioMin: integer;
	SocioMayor:integer;
	existeNumero, existeNombre: boolean;
	socioBuscado:integer;
	nombreSocio:string;
	total, sumaEdades: integer;
	
begin
	//INCISO A
	a:=nil;
	total:=0;
	sumaEdades:=0;
	armarArbol(a);
	imprimirArbol(a);
	
	
	//INCISO B
	if (a<>nil) then begin

		socioMax:=nSocioMaximo(a); // i
		writeln('El maximo n de socio es: ',socioMax);
		socioMin:=nSocioMinimo(a); // ii
		writeln('El minimo n de socio es: ', socioMin);
		mayorEdad(a, SocioMayor); // iii
		writeln('El numero de socio de mayor edad es: ', SocioMayor);
		aumentarEdad(a); // iv
		writeln('-----Arbol aumentado---');
		imprimirArbol(a);
		writeln('Ingrese Numero de socio a buscar: '); // v
		readln(socioBuscado);
		existeNumero:= buscarNumero(a,socioBuscado);
		if(existeNumero) then
			writeln('Se encotro el valor buscado', socioBuscado)
		else
			writeln('no existe el valor', socioBuscado);


		writeln('Ingrese Nombre de socio a buscar: '); // vi
		readln(nombreSocio);
		existeNombre:=buscarNombre(a, nombreSocio);
		if (existeNombre) then
			writeln('Se encontro el nombre: ', nombreSocio)
		else
			writeln('no existe el nombre: ', nombreSocio);

		totalSocios(a, total); // vii
		writeln('El numero total de socios es: ', total);
		totalEdades(a, sumaEdades); // viii
		writeln('El promedio de edades es: ',sumaEdades/total);
		
		ordenDecreciente(a); // ix
		ordenDecrecientePar(a); // x
		
	end
	else
		writeln('No hay datos cargados');
end.
	
	
