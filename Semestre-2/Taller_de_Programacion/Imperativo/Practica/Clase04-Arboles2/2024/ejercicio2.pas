{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente.
    ii. Informar los datos de los socios en orden decreciente.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.
    
2 - Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo
necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.

}

Program ImperativoClase3;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarSociosOrdenDecreciente(a:arbol);

	procedure InformarDatosSociosOrdenDecreciente(a:arbol);
	begin
		if (a<> nil) then begin
			InformarDatosSociosOrdenDecreciente(a^.HD);
			writeln('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
			InformarDatosSociosOrdenDecreciente(a^.HI);
		end;
	end;
begin
	writeln;
	writeln ('----- Socios en orden decreciente por numero de socio ----->');
	writeln;
	InformarDatosSociosOrdenDecreciente (a);
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	writeln;
end;


procedure InformarNumeroSocioConMasEdad(a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure InformarExistenciaNombreSocio(a:arbol);
	function existeSocio(a:arbol; nombre:cadena15):boolean;
	var
		existe: boolean;
	begin
		if (a=nil) then
		existeSocio:= false
		else
			if (a^.dato.nombre = nombre) then
				existeSocio:= true
			else begin
				existe:= existeSocio(a^.HI, nombre);
				if (not existe) then
					existe:= existeSocio(a^.HD, nombre);
					
				existeSocio:=existe;
			end;
	end;
	
var
	esta:boolean;
	nombre: cadena15;
begin
	writeln;
  writeln ('----- Ingrese nombre de socio ----->');
  writeln;
  readln(nombre);
  esta:=existeSocio(a, nombre);
  writeln;
  if esta then
		writeln('Se encontro el socio ', nombre)
	else 
		writeln('No se encontro el socio ',nombre);	
end;

procedure InformarCantidadSocios (a:arbol);
	function sumarSocios(a:arbol):integer;
	begin
		if (a=nil)then
			sumarSocios:=0
		else
			sumarSocios:= 1 +  sumarSocios(a^.HI) + sumarSocios(a^.HD);
	end;
var
	totalSocios:integer;
begin
	writeln;
  writeln ('----- Cantidad de Socios-----');
  writeln;
  totalSocios:=sumarSocios(a);
  writeln('La cantidad todal de socios es: ', totalSocios);
end;

procedure InformarPromedioDeEdad(a: arbol);
	function sumaEdades (a:arbol):integer;
	begin
		if(a=nil) then
			sumaEdades:=0
		else
			sumaEdades:= a^.dato.edad + sumaEdades(a^.HI) + sumaEdades(a^.HD);
	end;
	
	function sumarSocios(a:arbol):integer;
	begin
		if (a=nil)then
			sumarSocios:=0
		else
			sumarSocios:= 1 +  sumarSocios(a^.HI) + sumarSocios(a^.HD);
	end;

var
	promedioEdades:real;
	totalSocios: integer;
begin
	totalSocios:=sumarSocios(a);
	writeln;
	writeln('-------Promedio de edades---------');
	writeln;
	if (a=nil) then
		writeln('no hay edades ingresadas')
	else begin
		promedioEdades:=sumaEdades(a)/totalSocios;
		writeln('el promedio de edades es: ', promedioEdades:2:2);
	end;
end;

//PROGRAMA PRACTICA 4

procedure numeroSocioMayor(a:arbol);
	function mayor(a:arbol):integer;
	begin
		if (a^.hd=nil) then
			mayor:=a^.dato.numero
		else
			mayor:=mayor(a^.hd);
	end;
var
	numeroMayor:integer;
begin
	numeroMayor:=mayor(a);
	writeln('El numero de socio mas grande es: ', numeroMayor);
end;

procedure InformarSocioMasChico(a:arbol);
	function minimo(a:arbol):arbol;
	begin
		if (a^.hi=nil) then 
			minimo:=a
		else
			minimo:=minimo(a^.hi);
	end;
var
	socioMasChico:arbol;
begin
	socioMasChico:=minimo(a);
		writeln('El socio minimo es: ', 'Numero: ', socioMasChico^.dato.numero, 
		' Nombre: ', socioMasChico^.dato.nombre, ' Edad: ', socioMasChico^.dato.edad);
end;

procedure existeSocio(a:arbol);
	function existe(a:arbol; numero:integer):boolean;
	begin
		if (a=nil) then
			existe:=false
		else
			if (a^.dato.numero = numero) then
				existe:=true
			else
				begin
					if (numero < a^.dato.numero) then
						existe:=existe(a^.hi, numero)
					else
						existe:=existe(a^.hd, numero);
				end;
	end;
var
	encontro:boolean;
	numero:integer;
begin
	writeln;
	writeln('ingrese n de socio: ');
	readln(numero);
	encontro:=existe(a, numero);
	if encontro then
		writeln('se encontro el socio: ', numero)
	else
		writeln('no existe el socio: ', numero);
end;

procedure EntreDosValores(a:arbol);
	function cantidad(a:arbol; socio1, socio2:integer): integer;
	begin
		if (a = nil) then
			cantidad:=0
		else if (a^.dato.numero > socio1) and (a^.dato.numero < socio2) then
			cantidad:= 1 +  cantidad(a^.hi,socio1, socio2) + cantidad(a^.hd,socio1, socio2)
		else if (a^.dato.numero < socio1) then
			cantidad:=cantidad(a^.hd, socio1, socio2)
		else
			cantidad:= cantidad(a^.hi, socio1, socio2);
	end;

var
	socio1, socio2, total: integer;
begin
	writeln('ingrese socio n1: '); readln(socio1);
	writeln('ingrese socio n2: '); readln(socio2);
	total:= cantidad(a, socio1, socio2);
	writeln;
	writeln('la cantidad de socios entre los valores ingresados es: ', total);
	
end;


var a: arbol; 
Begin
  randomize;
  writeln('--------Ejercicio clase 3---------');
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
{
  InformarSociosOrdenDecreciente (a); 
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  InformarExistenciaNombreSocio (a);
  InformarCantidadSocios (a); 
	InformarPromedioDeEdad (a); 
}
	writeln;
	writeln('--------Ejercicio clase 4---------');
	numeroSocioMayor(a);
	InformarSocioMasChico(a);
	existeSocio(a);
	EntreDosValores(a);

End.
