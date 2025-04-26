// 5-Defina la función llamada duplicar_valores que recibe un arreglo de números flotantes y
// retorna un arreglo nuevo con los valores duplicados del parámetro

pub fn duplicar_valores(arr: &[f32]) -> [f32; 5] {
  let mut nuevo_arr = [0.0;5];
  for i in 0..arr.len() {
    nuevo_arr[i] = arr[i]*2.00;
  }
  nuevo_arr
}

#[test]
fn test_duplicar_valores() {
  let numeros = [1.0, 2.0, 3.0, 4.0, 5.0];
  let duplicados = duplicar_valores(&numeros);
  assert_eq!(duplicados, [2.0, 4.0, 6.0, 8.0, 10.0]);
}