// -Definir la función llamada cantidad_de_mayores que recibe como parámetro un arreglo
// de números enteros y un número entero llamado límite. Esta función retorna la cantidad de
// números mayores al límite que tiene el arreglo.

pub fn cantidad_de_mayores(arr: &[i32], limite: i32) -> i32 {
  let mut cantidad = 0;
  for elemento in arr {
    if *elemento > limite { // el asterisco es para desreferenciar y comparar con el limite, ya que el array es una referencia
      cantidad += 1;
    }
  }
  cantidad
}

#[test]
fn test_cantidad_de_mayores() {
  let numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  let limite = 5;
  let cantidad = cantidad_de_mayores(&numeros, limite);
  assert_eq!(cantidad, 5);
}