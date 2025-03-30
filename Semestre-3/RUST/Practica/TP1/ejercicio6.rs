// 6- Escribir un programa que defina una variable de tipo entero sin signo, y luego permita al 
// usuario ingresar un número entero por teclado para sumarse con la variable definida. El 
// programa debe imprimir el valor del número elevado al cuadrado.
use std::io;
fn main() {
  let num_base:u32 = 2;
  println!("Ingrese un numero entero: ");
  let mut input = String::new();
  io::stdin().read_line(&mut input).expect("Error al leer la entrada");

  let num_user:u32 = input.trim().parse().expect("Error al leer la entrada");

  let suma = num_base + num_user;
  let cuadrado = suma.pow(2);
  println!("El resultado de ({})^2 es: {}", suma, cuadrado);
}