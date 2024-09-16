// 1.- Implementar un programa que invoque a los siguientes módulos.
// a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
// almacene en un vector con dimensión física igual a 10 y retorne el vector.
// b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
// c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
// d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
// retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
// e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
// retorne una lista con los caracteres leídos.
// f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
// mismo orden que están almacenados.
// g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
// la lista en orden inverso al que están almacenados.

program ejercicio1;
const 
  dimF = 10;
type
  vector = array [1..dimF] of char;
  lista = ^nodo;
  nodo = record
    dato:char;
    sig:lista;
  end;
//a
procedure CargarVectorRecursion(var v:vector; var dimL:integer);
var 
  caracter: char;
begin
  writeln('Ingrese un caracter: ');
  readln(caracter);
  if(caracter <> '.') and (dimL < dimF) then begin
    dimL:= dimL + 1;
    v[dimL]:= caracter;
    CargarVectorRecursion(v, dimL);
  end;
end;

//b
procedure ImprimirVector (v:vector; dimL:integer);
var i:integer;
begin
  for i:=1 to dimL do begin
    writeln('--------');
    writeln('pos ', i);
    writeln(v[i]);
  end;
end;

//c
procedure ImprimirRecursivo(v: vector; dimL, index: integer);
begin
  if index <= dimL then begin
    writeln('--------');
    writeln('pos ', index);
    writeln(v[index]);
    ImprimirRecursivo(v, dimL, index + 1);
  end;
end;

//d
function contarCaracteres(): integer;
var 
  caracter: char;
begin
  writeln('Ingrese un caracter: ');
  readln(caracter);
  if (caracter = '.') then
    contarCaracteres := 0
  else
    contarCaracteres := 1 + contarCaracteres();
end;

//e
procedure agregarAdelante (var l:lista; caracter:char);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:=caracter;
  nue^.sig:=l;
  l:=nue;
end;

procedure cargarLista(var l: lista); //por que primero se hace la recursion y luego el agregaradelane?
var 
  caracter: char;
begin 
  write ('Ingerese un caracter: ');
  readln(caracter);
  if (caracter <> '.') then begin
    cargarLista(l);
    agregarAdelante(l, caracter);
  end
  else
    l:=nil;
end;

//f
procedure imprimirLista(l:lista);
begin
  if(l<>nil) then begin
    writeln('--------');
    writeln(l^.dato);
    l:=l^.sig;
    imprimirLista(l);
  end;
end;

//g
procedure imprimirInverso(l: lista);
begin
  if l <> nil then begin
    imprimirInverso(l^.sig); // Llamada recursiva para avanzar en la lista
    writeln(l^.dato); // Imprimir el dato una vez que se ha llegado al final de la lista
    writeln('--------');
  end;
end;

var
  v:vector;
  dimL:Integer;
  index:integer;
  cantidadCaracteres:integer;
  l:lista;

begin
  l:=nil;
  dimL:=0;
  index:=1;
  // a. Leer secuencia de caracteres y almacenar en un vector
  //CargarVectorRecursion(v, dimL);
  // b. Imprimir el vector usando un procedimiento no recursivo
  // ImprimirVector(v, dimL);
  // c. Imprimir el vector usando un procedimiento recursivo
  //ImprimirRecursivo(v, dimL, index);
  // d. Contar caracteres ingresados hasta el punto
  //cantidadCaracteres:=contarCaracteres();
  //writeln('se ingresaron ', cantidadCaracteres, ' caracteres');
  // e. leer la secuencia y almacenar en una lista
  cargarLista(l);
  // f. Imprimir la Lista con recursion en orden
  imprimirLista(l);
  // g. Imprimir la lista invertida
  imprimirInverso(l);

end.
