{Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de
consumo ilimitados (clientes que pagan por lo que consumen). Para cada cliente se conoce su código de cliente y
cantidad de líneas a su nombre. De cada línea se tiene el número de teléfono, la cantidad de minutos consumidos
y la cantidad de MB consumidos en el mes. Se pide implementar un programa que lea los datos de los clientes de
la compañía e informe el monto total a facturar para cada uno. Para ello, se requiere:

a. Realizar un módulo que lea la información de una línea de teléfono.

b. Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el
módulo desarrollado en el inciso a. ) y retorne la cantidad total de minutos y la cantidad total de MB a facturar
del cliente.

Nota: para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.}


program ejercicio4;
const
    costoMin=3.4;
    costoMb=1.35;
    pre='+54 9 22 ';
type
    str8=string[8];
    cliente=record
        codigo:string;
        lineas:integer;
    end;
    linea=record
        tlf:string;
        minutos,mb:real;
    end;
procedure leerLineas(var c:cliente);
begin
    writeln('Introduzca los datos del cleinte; codigo y cantidad de lineas a su nombre: ');
    readln(c.codigo);
    readln(c.lineas);
end;
procedure factura(i:integer;c:cliente;var l:linea;var tMin,tMb,fact:real);
begin
    writeln('Cliente encontrado. Posee ',c.lineas,' lineas a su nombre');
    for i:=1 to c.lineas do begin
        writeln('Linea ',i,'. Por favor introduce; numero telefonico, minutos consumidos y MB consumidos');
        readln(l.tlf);
        readln(l.minutos);
        readln(l.mb);
        tMin:=tMin+l.minutos;
        tMb:=tMb+l.mb;
        writeln('Linea ',pre,l.tlf,' ha consumido ',l.minutos:0:2,' minutos y ',l.mb:0:2,' MB en total');
        writeln;
    end;
        fact:=(tMin*costoMin)+(tMb+costoMb);
end;
var
    c:cliente;
    l:linea;
    tMin,tMb,fact:real;
    i:integer;
begin
    for i:=1 to 2 do begin
    leerLineas(c);
    factura(i,c,l,tMin,tMb,fact);
    writeln('Cliente ',c.codigo,' posee ',c.lineas,' lineas');
    writeln('Cliente ',c.codigo,' debe pagar en total ',fact:0:2,'$ pesos');
    writeln;
    end;
end.