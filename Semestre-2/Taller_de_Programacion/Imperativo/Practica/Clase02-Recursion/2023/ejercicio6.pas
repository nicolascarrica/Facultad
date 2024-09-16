// Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
// equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
// el número 0 (cero).
// Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
// ¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la
// próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.
// 

program ejercicio6;

procedure decimalABinario(decimal:integer; var bits:string);
begin
  if(decimal<>0) then begin
    if (decimal mod 2 = 0) then
      bits:='0' + bits
    else
      bits:='1' + bits;
    decimal:=decimal div 2;
    decimalABinario(decimal, bits);
  end;
end;

var 
  decimal: integer;
  bits: string;
begin
  decimal:=-1;
  while (decimal<>0) do begin
	writeln('Ingrese numero decimal: ');
	readln(decimal);
	if (decimal <> 0) then begin
		bits := ('');
		decimalABinario(decimal, bits);
		writeln(bits, ' es el valor en binario de ', decimal)
	end;
end;
end.
  
