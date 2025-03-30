// 12- Escribir un programa que defina una tupla que contenga una cadena y un arreglo de 
// enteros, y luego imprima la cadena y la suma de los valores en el arreglo.

fn main() {
  let arreglo: [i32; 5] = [1,2,3,4,5];
  let cadena: &str = "hola mundo!";

  let tupla: (&str, [i32; 5]) = (cadena, arreglo);

  let suma: i32 = tupla.1.iter().sum();

  println!("Cadena: {}", tupla.0);
  println!("Suma: {}", suma);
}