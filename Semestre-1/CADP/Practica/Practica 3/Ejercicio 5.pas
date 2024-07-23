{Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee:
marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La
información se ingresa ordenada por marca. Se pide calcular e informar:

a. El precio promedio por marca.

b. Marca y modelo del auto más caro.}


program ejercicio5;
type
    auto=record
        marca,modelo:string;
        precio:real;
    end;
procedure marca(var a:auto);
begin  
    writeln('¿Sobre cuál marca buscabas?');
    readln(a.marca);
end;
procedure leer(var a:auto);
begin
    writeln('TENEMOS! Introduzca los datos del auto; modelo y precio: ');
    readln(a.modelo);
    readln(a.precio);
end;

procedure promedio(a:auto;var prom,precioT:real;var aux:integer);
begin
    aux:=aux+1;
    precioT:=precioT+a.precio;
    prom:=precioT/aux;
end;
procedure masCaro(a:auto;var marca1,marca2,modelo1,modelo:string; var precio1,precio2:real);
begin
    if (a.precio>precio1) or (precio1=0) then begin
        marca1:=a.marca;
        modelo1:=a.modelo;
        precio1:=a.precio;
    end;
end;
var
    a:auto;
    MActual,marca1,marca2,modelo1,modelo2:string;
    prom,precioT,precio1,precio2:real;
    aux:integer;
begin
    marca(a);
    MActual:=a.marca;
    while (MActual<>'zzz') do begin
        while (a.marca=MActual) do begin
            leer(a);
            promedio(a,prom,precioT,aux);
            masCaro(a,marca1,marca2,modelo1,modelo2,precio1,precio2);
            marca(a);
            if (a.marca<>MActual) then begin
                writeln;
                writeln('Datos sobre la marca anterior: ');
                writeln;
                writeln('El auto mas caro es el modelo ',modelo1,' de la marca ',marca1);
                writeln('El precio promedio de ',MActual,' es de ',prom:0:2,'$ pesos.');
                writeln;
                break;
            end;
        end;
        MActual:=a.marca;
    end;
    writeln('El auto mas caro es el modelo ',modelo1,' de la marca ',marca1);
end.