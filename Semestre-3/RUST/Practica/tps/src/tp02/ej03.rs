// 3- Definir la función llamada suma_pares que recibe como parámetro un arreglo de
// números enteros y retorna la suma de los números pares.

pub fn suma_pares(arr: &[i32]) -> i32 {
  let mut suma = 0;
  for elemento in arr{
    if elemento % 2 == 0{
      suma += elemento;
    }
  }
  suma
}

#[test]
fn test_suma_pares() {
    let numeros = [1,2,3,4,5,6];
    let suma = suma_pares(&numeros);
    assert_eq!(suma, 12);
}
