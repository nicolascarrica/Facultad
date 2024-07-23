{Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la
información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de
los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.),
cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en
nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de
forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con 0 cores (que no
debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa
importadora e informe:
    
● Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.

● Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.

● Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de
al menos 2 Ghz.}


program ejercicio6;
type
    proc=record
        marca,linea:string;
        cores:integer;
        ghz,nm:real;
    end;
procedure marcas(var p:proc);
begin
    writeln('¿Cual marca buscas?');
    readln(p.marca);
    
end;
procedure leer(var p:proc);
begin
    writeln('¿linea y cores?');
    readln(p.linea);
    readln(p.cores);
    writeln('¿velocidad de reloj y tamaño de los transistores');
    readln(p.ghz);
    readln(p.nm);
end;
procedure contador(p:proc;var aux,aux1,aux2,aux3:integer;var marca1,marca2:string);
begin
    if (p.cores>2) and (p.nm>=22) then
        writeln('Este procesador de la marca ',p.marca,' y de la linea ',p.linea,' tiene mas de 2 cores y transistores de ',p.nm);
    if (p.nm>14) then begin
        aux:=aux+1;
        if (aux>aux1) or (aux1=0) then begin
            aux2:=aux1;
            aux1:=aux;
            marca2:=marca1;
            marca1:=p.marca;
        end
        else if (aux>aux2) or (aux2=0) then begin
            aux2:=aux;
            marca2:=p.marca;
        end;
    end;
    if (p.cores>1) and ((p.marca='amd') or (p.marca='intel')) and (p.ghz>=2) then
        aux3:=aux3+1;
end;
var
    p:proc;
    marca1,marca2,marcaActual:string;
    aux,aux1,aux2,aux3,coreActual:integer;
begin
    marcas(p);
    leer(p);
    marcaActual:=p.marca;
    while (p.cores <> 0) do begin
        while (marcaActual=p.marca) and (p.cores<>0) do begin
            contador(p,aux,aux1,aux2,aux3,marca1,marca2);
            marcas(p);
            leer(p);
            if (marcaActual<>p.marca) or (p.cores=0) then begin
                writeln;
                writeln('Procesador marca ',p.marca,' de la linea ',p.linea,' con ',p.cores,' cores y un reloj de ',p.ghz:0:2,'Ghz de vlocidad. Con transistores de ',p.nm:0:2,'nm.');
                writeln;
                break;
            end;
        end;
        marcaActual:=p.marca;
        coreActual:=p.cores;
    end;
    writeln;
    writeln('Las marcas ',marca1,' y ',marca2,' son las que tienen mas procesadores con transistores de mas de 14nm con ',aux1,' y ',aux2,' cores respectivamente');
    writeln;
    writeln('Hay al menos ',aux3,' porcesadores AMD o Intel multicores y con un reloj superior a 2Ghz.');
end.