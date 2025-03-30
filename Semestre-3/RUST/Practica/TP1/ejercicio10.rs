// 10- Escribir un programa que defina dos arreglos de 5 números enteros cada uno, y luego 
// cree un tercer arreglo que contenga la suma de los elementos de los dos arreglos 
// originales.

fn main() {
  let arr1 = [1, 2, 3, 4, 5];
  let arr2 = [6, 7, 8, 9, 10];
  let mut arr3 = [0,0,0,0,0];

  for i in 0..arr1.len() {
    arr3[i] = arr1[i] + arr2[i];
  }

  println!("Arreglo 1: {:?}", arr1);
  println!("Arreglo 2: {:?}", arr2);
  println!("Arreglo 3: {:?}", arr3);
}