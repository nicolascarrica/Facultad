{4. Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son
los dos números mínimos leídos.}

Program ejercicio4;
var
    num,num1,min1,min2,i:integer;
begin
    min1:=MaxInt;
    min2:=MaxInt;
    num1:=0;
    writeln('Introduzca los numeros');
    for i:= 0 to 999 do
    begin
        read(num);
        if (num<min1) then
        begin
            min1:=num;
            if (num1>min1) then
            begin
                min2:=num1;
            end;
            num1:=num;
        end
        else
        begin
            if (num<min2) then
                min2:=num;
        end;
    end;    
    write('Los 2 numeros minimos leidos son: ',min1,' y ',min2);
end.

{a. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
el número 0, el cual debe procesarse.}

Program ejercicio4a;
var
    num,num1,min1,min2,i:integer;
begin
    min1:=MaxInt;
    min2:=MaxInt;
    num1:=0;
    writeln('Introduzca los numeros');
    for i:=0 to 999 do
    begin
        read(num);
        begin
        if (num=0) then
            begin
            if (num<min1) then
            begin
                min1:=num;
                if (num1>min1) then
                begin
                    min2:=num1;
                end;
                num1:=num;
            end
            else
            begin
                if (num<min2) then
                    min2:=num;
            end;
            break;
        end
        else
        begin
            if (num<min1) then
            begin
                min1:=num;
                if (num1>min1) then
                begin
                    min2:=num1;
                end;
                num1:=num;
            end
            else
            begin
                if (num<min2) then
                    min2:=num;
            end;
        end;
        end;
    end;    
    write('Los 2 numeros minimos leidos son: ',min1,' y ',min2);
end.

{b. Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
el número 0, el cual no debe procesarse}

Program ejercicio4;
var
    num,num1,min1,min2,i:integer;
begin
    min1:=MaxInt;
    min2:=MaxInt;
    num1:=0;
    writeln('Introduzca los numeros');
    for i:= 0 to 999 do
    begin
        read(num);
        if (num=0) then
        begin
            break;
        end;
        if (num<min1) then
        begin
            min1:=num;
            if (num1>min1) then
            begin
                min2:=num1;
            end;
            num1:=num;
        end
        else
        begin
            if (num<min2) then
                min2:=num;
        end;
    end;    
    write('Los 2 numeros minimos leidos son: ',min1,' y ',min2);
end.
