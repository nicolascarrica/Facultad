// 9-Definir la función llamada cantidad_en_rango que recibe 3 parámetros: 1 arreglo de
// enteros, un número entero llamado inferior y otro número entero llamado superior. Esta
// función retorna la cantidad de números del arreglo que están entre el rango de los
// parámetros inferior y superior inclusive.

pub fn cantidad_en_rango(arr: &[i32], inferior: i32, superior:i32) -> i32 {
  let mut cantidad = 0;
  for elemento in arr {
    if *elemento >= inferior && *elemento <=superior 
      {
        cantidad += 1;
      }
  }
  cantidad
}

#[test]
fn test_cantidad_en_rango() {
  let numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  let inferior = 5;
  let superior = 8;
  let cantidad = cantidad_en_rango(&numeros, inferior, superior);
  assert_eq!(cantidad, 4);
}