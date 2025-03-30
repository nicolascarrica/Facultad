// 2- Escribir un programa que defina una variable de tipo entero sin signo, y luego imprima su
// valor en hexadecimal.

fn main() {
  // Definir una variable de tipo entero sin signo
  let num: u32 = 42;

  // Imprimir el valor de la variable en hexadecimal
  println!("El valor de la variable es: {:x}", num); //{:x} para imprimir en hexadecimal
}