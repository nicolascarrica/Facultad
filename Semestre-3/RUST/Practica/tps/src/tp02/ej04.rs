// 4- Definir la función llamada cantidad_impares que recibe como parámetro un arreglo de
// números enteros y retorna la cantidad de números impares

pub fn cantidad_impares(arr: &[i32]) -> i32 {
  let mut cantidad = 0;
  for elemento in arr {
    if elemento % 2 != 0 {
      cantidad += 1;
    }
  }
  cantidad
}

#[test]
fn test_cantidad_impares() {
  let numeros = [1, 2, 3, 4, 5, 6];
  let cantidad = cantidad_impares(&numeros);
  assert_eq!(cantidad, 3);
}
