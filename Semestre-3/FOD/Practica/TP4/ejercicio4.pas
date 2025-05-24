//Dado el siguiente algoritmo de búsqueda en un árbol B: 
procedure buscar(NRR, clave, NRR_encontrado, pos_encontrada, resultado)
var clave_encontrada: boolean;
begin
 if (nodo = null)
  resultado := false; {clave no encontrada}
 else
  posicionarYLeerNodo(A, nodo, NRR);
  claveEncontrada(A, nodo, clave, pos, clave_encontrada);
  if (clave_encontrada) then begin
   NRR_encontrado := NRR; { NRR actual }
   pos_encontrada := pos; { posicion dentro del array }
   resultado := true;
  end
  else
   buscar(nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada, resultado)
end;

// Asuma que el archivo se encuentra abierto y que, para la primera llamada, el parámetro NRR
// contiene la posición de la raíz del árbol. Responda detalladamente: .

// a. PosicionarYLeerNodo():  Indique qué hace y la forma en que deben ser enviados los
// parámetros (valor o referencia). Implemente este módulo en Pascal. 

A