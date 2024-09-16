{1. Implementar un programa modularizado para una librería que:

a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.

b. Imprima el contenido del árbol ordenado por código de producto.

c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.

d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.

e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).}


program practica4_1;
type
    ventas = record
        codigoVenta,codigoProducto,unidades:integer;
        precio:real;
    end;
    
    arbol = ^nodo;
    
    nodo = record
        dato:ventas;
        hd:arbol;
        hi:arbol;
    end;
    
procedure leer(var r:ventas);
begin
    writeln;
    writeln('--------LEER-------');
    writeln;
    write('Codigo de venta: ');
    readln(r.codigoVenta);
    if (r.codigoVenta <> -1) then begin
        write('Codigo del producto: ');
        readln(r.codigoProducto);
        write('Unidades vendidas: ');
        readln(r.unidades);
        write('Precio unitario: ');
        readln(r.precio);
    end;
end;

procedure agregar(var a:arbol; r:ventas);
begin
    if (a = nil) then begin
        new(a);
        a^.dato.codigoProducto:=r.codigoProducto; //solo añado lo que me interesa, es irrelevante cualquier otro dato
        a^.dato.unidades:=r.unidades;
        a^.dato.precio:=r.precio*r.unidades;
        a^.hi:=nil;
        a^.hd:=nil;
    end
    else if (r.codigoProducto = a^.dato.codigoProducto) then begin
        a^.dato.unidades:= a^.dato.unidades + r.unidades;
        a^.dato.precio:= a^.dato.precio + (r.precio*r.unidades);
    end
    else if (r.codigoProducto < a^.dato.codigoProducto) then
        agregar(a^.hi,r)
    else
        agregar(a^.hd,r)
end;

procedure imprimir(a:arbol);

    procedure impresionRecursiva(aux:arbol);
        
    begin
        if (aux <> nil) then begin
            impresionRecursiva(aux^.hi);
            writeln;
            writeln('Producto: ',aux^.dato.codigoProducto);
            writeln('Unidades totales vendidas: ',aux^.dato.unidades);
            writeln('Monto total: ',aux^.dato.precio:0:2);
            impresionRecursiva(aux^.hd);
        end;
    end;
    
var
    aux:arbol;
    
begin
    aux:=a;
    writeln;
    writeln('--------IMPRIMIR-------');
    impresionRecursiva(aux);
end;

procedure mayorVentas(a:arbol);
    procedure mayor(a:arbol; var max:integer; var cod:integer);
    begin
        if (a <> nil) then begin
            mayor(a^.hi,max,cod);
            if (a^.dato.unidades > max) or (max = 0) then begin
                max:= a^.dato.unidades;
                cod:= a^.dato.codigoProducto;
            end;
            mayor(a^.hd,max,cod);
        end;
    end;

var
    max,cod:integer;
    aux:arbol;

begin
    max:=0;
    aux:=a;
    mayor(aux,max,cod);
    writeln; 
    writeln ('--------MAYOR VENTAS--------');
    writeln('El producto ',cod,' es el de mayor unidades vendidas con ',max,' en total');
end;

procedure menorQue(a:arbol);
    procedure menor(a:arbol; var contar:integer; cod:integer);
    begin
        if (a <> nil) then begin
            
            if (a^.dato.codigoProducto < cod) then
                contar:= contar + 1;
            if (a^.dato.codigoProducto < cod) then
                menor(a^.hd,contar,cod);
            menor(a^.hi,contar,cod);
        end;
    end;

var
    cod,contar:integer;
    aux:arbol;

begin
    aux:=a;
    contar:=0;
    writeln; 
    writeln ('--------MENOR QUE--------');
    writeln;
    write('Cantidad de codigos menores que: ');
    readln(cod);
    menor(aux,contar,cod);
    writeln('Hay ',contar,' productos cuyo codigo es menor que el del producto ',cod);
end;

procedure rango(a:arbol);

    procedure ran(a:arbol;x,y:integer;var total:real);
    begin
        if (a <> nil) then begin
            if (a^.dato.codigoProducto > x) and (a^.dato.codigoProducto < y) then
                total:= total + a^.dato.precio;
            if (a^.dato.codigoProducto > x) then
                ran(a^.hi, x, y, total);
            if (a^.dato.codigoProducto < y) then
                ran(a^.hd, x, y, total);
        end;
    end;

var
    aux:arbol;
    x,y:integer;
    total:real;
    
begin
    aux:=a;
    total:=0;
    writeln; 
    writeln ('--------RANGO--------');
    writeln;
    writeln('Establesca un rango de valores [x:y]: ');
    readln(x);
    readln(y);
    ran(aux,x,y,total);
    writeln('En el rango entre ',x,' y ',y, ' todos los montos de ventas de los productos suman en total ',total:0:2);
end;

procedure crearArbol(var a:arbol);
var
    codigo:integer;
    r:ventas;
    
begin
    codigo:=0;
    while (codigo <> -1) do begin
        leer(r);
        codigo:= r.codigoVenta;
        if (codigo <> -1) then
            agregar(a,r);
    end;
end;

////////////// PRINCIPAL /////////////////////
var
    a:arbol;
    
begin
    crearArbol(a); {inciso A}
    imprimir(a);   {inciso B}
    mayorVentas(a); {inciso C}
    menorQue(a); {inciso D}
    rango(a); {inciso E}
end.

