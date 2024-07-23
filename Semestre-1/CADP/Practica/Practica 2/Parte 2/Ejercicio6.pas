program seis;
procedure leerCodigos(var precio:real; var codigo:integer; var tipo:string);
  begin
    writeln('Introduzca precio, codigo y tipo de producto: ');
    readln(precio);
    readln(codigo);
    readln(tipo);
  end;

procedure masBaratos(precio:real; codigo: integer; var precioMin1: real; var precioMin2: real; var codMin1: integer; var codMin2: integer);
  begin
    if (precio < precioMin1) then
      begin
        precioMin2:=precioMin1;
        codMin2:=codMin1;
        precioMin1:=precio;
        codMin1:=codigo;
      end
    else if (precio <precioMin2) then
      begin
        precioMin2:=precio;
        codMin2:=codigo;
      end;
  end;

procedure PantalonMasCaro(precio: real; codigo: integer; var precioPantalonMasCaro: real; var codPantalonMasCaro: integer);
  begin
    if (precio > precioPantalonMasCaro) then
      begin
        precioPantalonMasCaro:=precio;
        codPantalonMasCaro:=codigo;
      end;
  end;

var 
  precio, precioMin1,precioMin2,precioPantalonMasCaro: real;
  codigo,codMin1,codMin2,codPantalonMasCaro, i: integer;
  tipo: string;
  sumaTotal: real;
  cantidad: integer;
  promedio: real;

begin
  codPantalonMasCaro:=0;
  precioPantalonMasCaro:=0;
  codMin1:=MaxInt;
  codMin2:=MaxInt;
  precioMin1:=MaxInt;
  precioMin2:=MaxInt;
  sumaTotal:=0;
  cantidad:=0;
  for i:=1 to 5 do
    begin
      leerCodigos(precio,codigo,tipo);
      masBaratos(precio,codigo,precioMin1,precioMin2,codMin1,codMin2);
      if (tipo='pantalon') then
        begin
          PantalonMasCaro(precio,codigo,precioPantalonMasCaro,codPantalonMasCaro);
        end;
      sumaTotal:=sumaTotal+precio;
      cantidad:=cantidad+1;
    end;
  promedio:=sumaTotal/cantidad;
  writeln('El producto mas barato es: ',codMin1,' con valor de: ',precioMin1:0:2,' pesos.');
  writeln('El segundo proyecto mas barato es: ',codMin2,' con valor de: ',precioMin2:0:2,' pesos.');
  writeln('El pantalon mas caro cuesta: ', precioPantalonMasCaro:0:2,' pesos.');
  writeln('El precio promedio de los productos es de: ',promedio:0:2);
end.