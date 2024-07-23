program OperacionesConSecuencia;
var
  operacion: char;
  numero, resultado: integer;
begin
  writeln('Ingrese el operador (+ o -):');
  readln(operacion);

  // Verificar si el operador ingresado es válido
  if (operacion <> '+') and (operacion <> '-') then
  begin
    writeln('Error: operador no válido.');
    exit; // Finalizar el programa si el operador no es válido
  end;

  // Inicializar el resultado
  resultado := 0;

  // Leer la secuencia de números y aplicar la operación
  writeln('Ingrese una secuencia de numeros enteros (finalice con 0):');
  readln(numero);
  while (numero <> 0) do
  begin
    if (operacion = '+') then
      resultado := resultado + numero
    else
      resultado := resultado - numero;

    // Leer el siguiente número de la secuencia
    readln(numero);
  end;

  // Imprimir el resultado final
  writeln('El resultado de aplicar la operacion es: ', resultado);
end.