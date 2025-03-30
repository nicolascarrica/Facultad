// 8- Escribir un programa que defina una constante de tipo cadena, y luego imprima el 
// número de veces que un caracter específico ingresado por el usuario aparece en la cadena. 
// Se debe imprimir el resultado.

use std::io;

fn main() {
  let str_fija:&str = "hola mundo!";
  println!("Ingrese un caracter: ");
  let mut input = String::new();
  io::stdin().read_line(&mut input).expect("Error al leer la entrada");

  let str_user:char = input.trim().parse().expect("Error al leer la entrada");

  let count = str_fija.chars().filter(|&c| c == str_user).count();
  println!("El caracter {} aparece {} veces en la cadena", str_user, count);
}