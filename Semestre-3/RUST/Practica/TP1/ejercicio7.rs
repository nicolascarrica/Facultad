// 7- Escribir un programa que defina una variable de tipo arreglo que contenga seis números 
// enteros, y luego multiplique cada valor del arreglo por un valor constante definido, 
// modificando el contenido del arreglo. 

fn main() {
  let mut array = [1, 2, 3, 4, 5, 6];
  let constant = 2;

  for i in 0..array.len() {
    array[i] *= constant;
  }

  for i in 0..array.len() {
    println!("{}", array[i]);
  }
}