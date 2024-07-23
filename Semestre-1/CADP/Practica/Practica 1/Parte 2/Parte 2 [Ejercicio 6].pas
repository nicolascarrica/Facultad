program ejercicio6;
var
  cod,i,codBarato1,codBarato2,aux:integer;
  precio,precio1,precio2:real;
begin
    precio1:=MaxInt;
    precio2:=MaxInt;
    for i:= 0 to 4 do begin
        writeln('Codigo del producto: ');
        readln(cod);
        if (cod<1) or (cod>200) then
            repeat
                writeln('Introduzca un codigo valido: ');
                readln(cod);
            until (cod>=1) and (cod<=200);
        writeln('Introduzca precio ');
        readln(precio);
        if (precio<precio1) then begin
            codBarato2:=codBarato1;
            codBarato1:=cod;
            precio2:=precio1;
            precio1:=precio;
        end
        else if (precio<precio2) then begin
            codBarato2:=cod;
            precio2:=precio;
        end;
        if (precio>16) and (cod mod 2=0) then
            aux:=aux+1;
    end;
    writeln();
    writeln('Los codigos de los productos mas baratos son: ',codBarato1, ' y ',codBarato2);
    writeln('Hay ',aux,' productos con codigo par que cuestan mas de 16 pesos');
end.