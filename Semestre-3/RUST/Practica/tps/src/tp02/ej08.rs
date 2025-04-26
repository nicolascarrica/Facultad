// 8- Definir la función llamada sumar_arreglos que recibe 2 arreglos del mismo tamaño de
// números flotantes y retorna un nuevo arreglo que contiene la suma de los elementos de los
// arreglos pasados por parámetro, correspondiendose el resultado con cada posición de los
// arreglos pasados por parámetro

pub fn sumar_arreglos<const N: usize>(arr1: &[f32], arr2: &[f32]) -> [f32; N] {
  let mut nuevo_arr = [0.0; N];
  for i in 0..arr1.len() {
    nuevo_arr[i] = arr1[i] + arr2[i];
  }
  nuevo_arr
}

#[test]
fn test_sumar_arreglos() {
  let arr1 =[1.0, 2.0, 3.0, 4.0, 5.0];
  let arr2 = [2.0, 3.0, 4.0, 5.0, 6.0];
  let resultado = sumar_arreglos(&arr1, &arr2);
  assert_eq!(resultado, [3.0, 5.0, 7.0, 9.0, 11.0]);
}

