// 9- Escribir un programa que defina un arreglo de 5 números enteros, y luego imprima la 
// suma de los valores del  arreglo

fn main() {
  let arr = [1,2,3,4,5];
  let mut suma = 0;

  for i in 0..arr.len() {
    suma += arr[i];
  }

  println!("La suma de los valores del arreglo es: {}", suma);
}