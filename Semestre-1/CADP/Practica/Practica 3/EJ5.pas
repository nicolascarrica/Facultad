program cinco;
type
  auto=record
    marca: string;
    modelo: string;
    precio: real;
  end;


procedure leer(var auto:auto);
begin
write('Introduzca la marca del auto: ');
readln(auto.marca);
if(auto.marca<>'ZZZ') then
  begin
    write('Introduzca el precio del auto: ');
    readln(auto.precio);
    write('Introduzca el modelo del auto: ');
    readln(auto.modelo);
  end;
end;

procedure masCaro(auto: auto; var max:real; var marcaMax:string; var modeloMax:string);
begin
  if (auto.precio>max) then
    begin
      max:=auto.precio;
      marcaMax:=auto.marca;
      modeloMax:=auto.modelo;
    end;
end;

var
  coche: auto;
  max:real;
  marcaMax:string;
  modeloMax:string;
  cantidadXMarca: integer;
  precioXMarca: real;
  actual: string;
  prmedio: real;

begin
  max:=-1;
  leer(coche);
  while (coche.marca<>'ZZZ') do
    begin
      cantidadXMarca:=0;
      actual:=coche.marca;
      precioXMarca:=0;
      while ((coche.marca=actual) and (coche.marca<>'ZZZ')) do
        begin
          cantidadXMarca:=cantidadXMarca+1;
          precioXMarca:=precioXMarca+coche.precio;
          masCaro(coche,max,marcaMax,modeloMax);
          leer(coche);
        end;
      prmedio:=precioXMarca/cantidadXMarca;
      writeln('La marca ',actual,' tiene un promedio de ',prmedio:0:2,'$');
    end;
  writeln('El auto mas caro es el modelo ',modeloMax,' de la marca ',marcaMax, ' con un precio de ',max:0:2,'$');
end.


