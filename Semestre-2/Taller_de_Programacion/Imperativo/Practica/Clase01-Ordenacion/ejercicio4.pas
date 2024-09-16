// 4.-Una librería requiere el procesamiento de la información de sus productos. De cada
// producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
// Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
// a. Lea los datos de los productos y los almacene ordenados por código de producto y
// agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
// cuando se lee el precio 0.
// b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
// c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
// puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
// es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
// d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
// métodos vistos en la teoría.
// e. Muestre los precios del vector resultante del punto d).
// f. Calcule el promedio de los precios del vector resultante del punto d).


program cuatro;

const 
  dimF = 8;
  dimF_r3 = 30;

type
  r_rubro = 1..dimF;

  producto = record
    codigo_producto: integer;
    codigo_rubro: r_rubro;
    precio: integer;
  end;

  lista = ^nodo;
  nodo = record
    dato: producto;
    sig: lista;
  end;

  vector_rubros = array [r_rubro] of lista;
  vector_rubro3 = array [1..dimF_r3] of producto;

procedure IniciarVectorRubros (var vr:vector_rubros);
var 
  i:integer;
begin
  for i:=1 to dimF do
    vr[i]:= nil;
end;

procedure LeerProducto(var p:producto);
begin
  writeln('Ingrese precio del producto');
  readln(p.precio);
  if (p.precio <> 0) then begin
    writeln ('Ingrese Codigo de producto');
    readln (p.codigo_producto);
    writeln('Ingrese Codigo de rubro de 1 a 8');
    readln(p.codigo_rubro);
  end;
  writeln('-------------------------');
end;

procedure InsertarOrdenado(var l:lista; prod:producto);
var
  nue:lista;
  act, ant: lista;
begin
  new(nue);
  nue^.dato:=prod;
  act:=l;
  ant:=l;
  while (act<>nil) and (prod.codigo_producto > act^.dato.codigo_producto) do begin
    ant:=act;
    act:=act^.sig;
  end;
  if (ant=act) then
    l:=nue
  else
    ant^.sig := nue;
  nue^.sig:=act;
end;

procedure CargarProductos (var vr: vector_rubros);
var
  prod: producto;
begin
  LeerProducto(prod);
  while (prod.precio <> 0) do begin
    InsertarOrdenado(vr[prod.codigo_rubro], prod);
    LeerProducto(prod);
  end;
end;

procedure ImprimirProductos (vr: vector_rubros);
var
  i:integer;
  l:lista;
begin
  for i:=1 to dimF do begin
    writeln('Rubro ',i, ':');
    l:=vr[i];
    while l <> nil do begin
      writeln(' Codigo de Producto: ', l^.dato.codigo_producto);
      //writeln(' Precio: ', l^.dato.precio);
      writeln('-------------------------------');
      l:=l^.sig;
    end;
  end;
end;

procedure cargarVectorR3 (vr:vector_rubros; var vr3: vector_rubro3; var dimL: integer);
begin
  dimL:=0;
  while (vr[3]<>nil) and (dimL < dimF_r3) do begin
    dimL:= dimL + 1;
    vr3[dimL] := vr[3]^.dato;
    vr[3]:=vr[3]^.sig;
  end;
end;

procedure OrdenarXPrecio (var vr3:vector_rubro3; dimL:integer);
var
  i,j, pos: integer;
  item: producto;
begin
  for i:=1 to dimL - 1 do begin
    pos:=i;
    for j:=i+1 to dimL do
      if(vr3[j].precio < vr3[pos].precio) then
        pos:=j;
    item:=vr3[pos];
    vr3[pos]:=vr3[i];
    vr3[i]:=item;
  end;
end;

procedure ImprimirPreciosR3 (vr3:vector_rubro3; dimL:integer);
var
  i:integer;
begin
  for i:=1 to dimL do begin
    writeln('Los precios del rubro 3 son: ', vr3[i].precio);
  end;
end;

function CalcularPromedio (vr3:vector_rubro3; dimL:integer): real;
var
  i, suma:integer;
begin
  suma:=0;
  for i:=1 to dimL do
    suma:=suma + vr3[i].precio;
  if (dimL > 0) then 
    CalcularPromedio := suma / dimL
  else
    CalcularPromedio:=0;
end;



var
  vr: vector_rubros;
  vr3:vector_rubro3;
  dimL:integer;
  promedio:real;
begin
  IniciarVectorRubros(vr);
  CargarProductos(vr);
  ImprimirProductos(vr);
  cargarVectorR3(vr, vr3, dimL);
  OrdenarXPrecio(vr3, dimL);
  ImprimirPreciosR3(vr3, dimL);
  writeln('---------------------');
  promedio:=CalcularPromedio(vr3, dimL);
  writeln('el primedio de precios es: ', promedio:0:2);
end.
