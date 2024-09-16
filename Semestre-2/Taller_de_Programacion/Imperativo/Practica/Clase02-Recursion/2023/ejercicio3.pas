// 3.- Escribir un programa que:
// a. Implemente un módulo recursivo que genere una lista de números enteros “random”
// mayores a 0 y menores a 100. Finalizar con el número 0.
// b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
// c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
// d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
// encuentra en la lista o falso en caso contrario.

program ejercicio3;
type
  lista=^nodo;
  nodo=record
    dato:integer;
    sig:lista;
  end;

procedure agregarAdelante(var l:lista; d:integer);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:= d;
  nue^.sig:=l;
  l:=nue;
end;

procedure cargarLista(var l:lista);
var
  d:integer;
begin
  d:=random(100); // numeros desde el cero al 99
  if (d<>0) then begin
    cargarLista(l);
    agregarAdelante(l, d);
  end
  else
    l:=nil;
end;

procedure imprimirLista(l:lista);
begin
  if (l<>nil) then begin
    writeln('---------');
    writeln(l^.dato);
    // l:=l^.sig;
    imprimirLista(l^.sig);
  end;
end;

procedure minimo (l:lista; var min: integer);
begin
  if (l<>nil) then begin
    if (l^.dato < min) then begin
      min:=l^.dato;
    end;
    minimo(l^.sig, min);
  end;
end;

procedure maximo (l:lista; var max:integer);
begin
  if (l<>nil) then begin
    if (l^.dato > max) then begin
      max:=l^.dato;
    end;
    maximo(l^.sig,max);
  end;
end;

function existe(l:lista; d:integer):boolean;
begin
  if (l<>nil) then begin
    if (l^.dato = d) then
      existe:=true
    else
      existe:=existe(l^.sig,d);
  end;
end;

var
  l:lista;
  max, min, d: integer;
begin
  l:=nil;
  max:=0;
  min:=100;
  randomize;
  cargarLista(l);
  imprimirLista(l);
  minimo(l, min);
  writeln('el numero minimo es: ', min);
  maximo(l, max);
  writeln('el numero maximo es: ', max);
  writeln('----------');
  writeln('Ingrese un numero entero');
  readln(d);
  if existe(l,d) then
    writeln('Se encontro el numero ', d)
  else
    writeln('no se encontro el numero ', d);
end.

