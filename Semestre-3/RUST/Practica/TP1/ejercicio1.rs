// 1- Escribir un programa que defina una variable de tipo flotante con algún valor, y luego
// permita al usuario ingresar un número decimal por teclado para multiplicar, dividir, sumar y
// restar su valor. Se deben imprimir los resultados.


use std::io::stdin;

fn main() {
  // Definir una variable flotante con un valor inicial
  let initial_value: f64 = 10.5;

  // Solicitar al usuario que ingrese un número decimal
  println!("Ingrese un número decimal:");
  let mut input = String::new();
  stdin().read_line(&mut input).expect("Error al leer la entrada del usuario");
  let decimal: f64 = input.trim().parse().expect("Error al convertir la entrada a un número decimal");

  // Realizar operaciones con el número decimal
  let result_sum = initial_value + decimal;
  let result_sub = initial_value - decimal;
  let result_mul = initial_value * decimal;
  let result_div = initial_value / decimal;

  // Imprimir los resultados
  println!("Suma: {}", result_sum);
  println!("Resta: {}", result_sub);
  println!("Multiplicación: {}", result_mul);
  println!("División: {}", result_div);
}