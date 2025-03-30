// 11- Escribir un programa que defina un arreglo de 5 cadenas, y luego permita al usuario 
// ingresar una cadena por teclado. El programa debe imprimir un mensaje si la cadena 
// ingresada por el usuario se encuentra en el arreglo

use std::io;

fn main() {
  let arra: [&str; 5] = ["hola", "mundo", "ejercicio", "numero", "once"];

  println!("Ingrese una cadena: ");
  let mut input = String::new();
  io::stdin().read_line(&mut input).expect("Error al leer la entrada");

  let str_user:&str = input.trim();

  if arra.contains(&str_user) {
    println!("La cadena {} se encuentra en el arreglo", str_user);
  } else {
    println!("La cadena {} no se encuentra en el arreglo", str_user);
  }
}