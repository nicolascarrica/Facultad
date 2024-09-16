// Se desea procesar la información de las ventas de productos de un comercio (como máximo 50).
// Implementar un programa que invoque los siguientes módulos:
// a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
// día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
// unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
// ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
// b. Un módulo que muestre el contenido del vector resultante del punto a).
// c. Un módulo que ordene el vector de ventas por código.
// d. Un módulo que muestre el contenido del vector resultante del punto c).
// e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
// valores que se ingresan como parámetros.
// f. Un módulo que muestre el contenido del vector resultante del punto e).
// g. Un módulo que retorne la información (ordenada por código de producto de menor a
// mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
// h. Un módulo que muestre la información obtenida en el punto g).

program ejercicio1;
const dimF = 10;
type 
  r_dias = 0..31;
  r_codigo = 1..15;
  r_cantidad = 0..99;


  venta = record
    dia: r_dias;
    codProducto: r_codigo;
    cantidadVendida: r_cantidad;
  end;

  vector = array [1..dimF] of venta;

  lista = ^nodo;
  nodo = record
    dato: venta;
    sig: lista;
  end;

  procedure LeerVenta (var v: venta);
  begin
    Randomize;
    writeln('Ingrese el dia de la venta');
    v.dia := Random(31) + 1;
    writeln('Ingrese el codigo del producto');
    v.codProducto := Random(15) + 1;
    writeln('Ingrese la cantidad vendida');
    readln(v.cantidadVendida);
  end;

// inciso a
  procedure CargarVector(var a: vector; var dimL: integer);
  var
    v: venta;
  begin
    dimL := 0;
    LeerVenta(v);
    while (v.dia <> 0) and (dimL < dimF) do 
    begin
      dimL := dimL + 1;
      a[dimL] := v;
      LeerVenta(v);
    end;
  end;
// inciso b, d y f
  procedure ImprimirVector (a: vector; dimL: integer);
  var 
    i: integer;
  begin
    for i:= 1 to dimL do
      writeln(
        'Dia: ', a[i].dia, 
        ' Codigo del producto: ', a[i].codProducto, 
        ' Cantidad vendida: ', a[i].cantidadVendida
      );
  end;

// inciso c
  procedure OrdenarVector (var a: vector; dimL: integer);
  var
    i, j, pos: integer;
    item: venta;
  begin
    for i:= 1 to dimL - 1 do begin
      pos:= i;
      for j:= i+1 to dimL do
        if (a[j].codProducto < a[pos].codProducto) then
          pos:= j;
      item:= a[pos];
      a[pos]:= a[i];
      a[i]:= item;
    end;
  end;

// inciso e
  procedure Eliminar(var v: vector; var dimL: integer; valorInferior, valorSuperior: r_codigo);

    function BuscarPosicion(v: vector; dimL: integer; elemABuscar: r_codigo): integer;
    var pos: integer;
    begin
      pos := 1;
      while (pos <= dimL) and (elemABuscar > v[pos].codProducto) do
        pos := pos + 1;
      if (pos > dimL) then 
        BuscarPosicion := 0
      else 
        BuscarPosicion := pos;
    end;
  
    function BuscarPosicionDesde(v: vector; dimL, pos: integer; elemABuscar: r_codigo): integer;
    begin
      while (pos <= dimL) and (elemABuscar >= v[pos].codProducto) do
         pos := pos + 1;
      if (pos > dimL) then 
        BuscarPosicionDesde := dimL
      else 
        BuscarPosicionDesde := pos - 1;
    end;

  var 
    posInferior, posSuperior, i: integer; 
  begin
    posInferior := BuscarPosicion(v, dimL, valorInferior);
    if (posInferior <> 0) then 
    begin
      posSuperior := BuscarPosicionDesde(v, dimL, posInferior, valorSuperior);
      
      if posSuperior < dimL then
      begin
        for i := posSuperior + 1 to dimL do
        begin
          v[i - (posSuperior - posInferior + 1)] := v[i];
        end;
      end;

      dimL := dimL - (posSuperior - posInferior + 1);
    end;
  end;

  procedure AgregarAdelante (var L:lista; v:venta);
  var
    nue: lista;
  begin
    new(nue);
    nue^.dato:=v;
    nue^.sig:=L;
    L:=nue;
  end;

  procedure CargarLista(var L:lista; a:vector);
  var
    v:venta;
    i:integer
  begin
    for i:=1 to dimL do begin
      if(a[i].codProducto mod 2 = 0) then
        AgregarAdelante(L, a);
    end;
  end;

  procedure ImprimirLista (L:lista);
  begin
    while L<>nil do begin
      write(L^.dato.codProducto);
      write(L^.dato.cantidadVendida);
      write('------------');
      L=L^.sig;
    end;
  end;

var 
  v: vector;
  dimL: integer;
  L: lista
  valor1, valor2: r_codigo;

begin
  L:=nue;
  CargarVector(v, dimL);
  writeln('Vector cargado');
  ImprimirVector(v, dimL);
  OrdenarVector(v, dimL);
  writeln('Vector ordenado');
  ImprimirVector(v, dimL);
  write('Ingrese valor inferior');
  readln(valor1);
  write('Ingrese valor superior');
  readln(valor2)
  Eliminar(v, dimL, valor1, valor2);
  writeln('Vector final después de eliminar');
  ImprimirVector(v, dimL);
  CargarLista(L, v);
  ImprimirLista(L);
end.

