// 5- Escribir un programa que defina una variable de tipo cadena, y luego permita al usuario
// ingresar una cadena por teclado para concatenar su valor. El programa debe imprimir la
// cadena en mayúsculas

fn main() {
  let my_string:&str = "Mi nombre es: ";
  println!("Ingrese su nombre: ");
  let mut input = String::new();
  std::io::stdin().read_line(&mut input).expect("Error al leer la entrada");

  println!("{}{}", my_string.to_uppercase(), input.to_uppercase());
}