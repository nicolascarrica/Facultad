// 4- Escribir un programa que defina una tupla que contenga una cadena, un número entero
// con signo y un valor booleano, y luego imprima cada valor de la tupla

fn main() {
  let tupla: (String, i8, bool) = ("hola".to_string(), 10, true);
  println!("Cadena: {}", tupla.0);
  println!("Entero: {}", tupla.1);
  println!("Booleano: {}", tupla.2);
}

