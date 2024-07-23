{Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:

● Cantidad total de centros para cada universidad.

● Universidad con mayor cantidad de investigadores en sus centros.

● Los dos centros con menor cantidad de becarios.}


program ejercicio7;
type
    ci=record
        nombre,uni:string;
        invest,becar:integer;
    end;
procedure universidad(var c:ci);
begin
    writeln('Introduzca universidad');
    readln(c.uni);
    
end;
procedure leer(var c:ci);
begin
    writeln('Introduzca el centro de investigacion');
    readln(c.nombre);
    writeln('¿Cuantos investigadores y becarios tiene?');
    readln(c.invest);
    readln(c.becar);
end;
procedure contador(c:ci;var inT,bec1,bec2:integer;var uni1,uni2,nom1,nom2:string);
begin
    bec1:=MaxInt;
    bec2:=MaxInt;
    if (c.invest>inT) or (inT=0) then begin
        uni1:=c.uni;
        inT:=c.invest;
    end;
    if (c.becar<bec1) or (bec1=MaxInt) then begin
        nom2:=nom1;
        nom1:=c.nombre;
        bec2:=bec1;
        bec1:=c.becar;
    end
    else if (c.becar<bec2) or (bec2=MaxInt) then begin
        nom2:=c.nombre;
        bec2:=c.becar;
    end;
end;
var
    c:ci;
    UActual,uni1,uni2,nom1,nom2:string;
    ciT,inT,bec1,bec2,InvestActual:integer;
begin
    ciT:=0;
    universidad(c);
    UActual:=c.uni;
    leer(c);
    while (c.invest <> 0) do begin
        while (UActual=c.uni) and (c.invest <> 0) do begin
            ciT:=ciT+1;
            contador(c,inT,bec1,bec2,uni1,uni2,nom1,nom2);
            universidad(c);
            if (UActual<>c.uni) or (c.invest=0) then begin
                writeln;
                writeln('Esta universidad tiene ',ciT,' centros de investigacion');
                writeln;
                break;
            end;
            leer(c);
        end;
        UActual:=c.uni;
        InvestActual:=c.invest;
        ciT:=0;
    end;
    writeln;
    writeln('La universidad con mas investigadores es ',uni1,' con ',inT,' investigadores');
    writeln;
    writeln('El centro ',nom1,' y ',nom2,' son los que tienen menos becarios, ',bec1,' y ',bec1,' respectivamente');
end.