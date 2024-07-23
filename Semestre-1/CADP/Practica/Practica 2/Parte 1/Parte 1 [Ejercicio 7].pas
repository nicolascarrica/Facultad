{7. Dado el siguiente programa:

program alcanceYFunciones;
var
suma, cant : integer;
function calcularPromedio : real
var
prom : real;
begin
if (cant = 0) then
prom := -1
else
prom := suma / cant;
end;

begin
readln(suma);
readln(cant);
if (calcularPromedio <> -1) then begin
cant := 0;
writeln(‘El promedio es: ’ , calcularPromedio)
end;
else
writeln(‘Dividir por cero no parece ser una buena idea’);
end.}

{Programa correcto}

program alcanceYFunciones;
var
suma, cant : integer;
prom:real;

{funcion}

function calcularPromedio : real;
begin
if (cant = 0) then begin
prom := -1;
end
else
prom:= suma / cant;
end;

{ programa principal }

begin 
readln(suma);
readln(cant);
calcularPromedio;
if (prom <> -1) then begin
cant := 0;
writeln('El promedio es: ' , prom:2:0);
end
else
writeln('Dividir por cero no parece ser una buena idea');
end.

{a) La función calcularPromedio calcula y retorna el promedio entre las variables globales suma y cant, pero
parece incompleta. ¿qué debería agregarle para que funcione correctamente?


        Pasando la variable prom a global, el valor se da en la funcion llamada en la linea 24, el valor se mantiene y la evaluacion de la linea 25 funciona correctamente


b) En el programa principal, la función calcularPromedio es invocada dos veces, pero esto podría mejorarse.
¿cómo debería modificarse el programa principal para invocar a dicha función una única vez?


        Llama la funcion antes del if para obtener el resultado, asi el if evalua el resultado y el write lo imprime. Solo se llama a la funcion una unica vez


c) Si se leen por teclado los valores 48 (variable suma) y 6 (variable cant), ¿qué resultado imprime el
programa? Considere las tres posibilidades:

    i) El programa original
    
        Tiene errores y no corre. Falta ";" en la funcion. ";" en el end del if previo al else 
            
    ii) El programa luego de realizar la modificación del inciso a)
    
        Existe un error y no corre. ";" en el end del if previo al else  
    
    iii) El programa luego de realizar las modificaciones de los incisos a) y b)
    
        "El promedio es: 8"
}
    
    
    



