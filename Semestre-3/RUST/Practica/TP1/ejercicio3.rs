// 3- Escribir un programa que defina una variable de tipo booleano, y luego permita al usuario
// ingresar un valor booleano por teclado para actualizar su valor haciendo las operaciones
// and y or. Se deben imprimir ambos resultados.

fn main() {
  let valor_inicial: bool = true;

  println!("Ingrese un valor booleano: ");
  let mut input = String::new();
  std::io::stdin().read_line(&mut input).expect("Error al leer la entrada");

  let valor_user = input.trim().to_lowercase();
  let valor_user = match valor_user.as_str() {
    "true" => true,
    "false" => false,
    _ =>{ println!("entrada invalida, se usa el valor por defecto: false."); 
          false
        }
  };

  println!("El valor inicial es: {}", valor_inicial);
  println!("El valor ingresado es: {}", valor_user);

  let resultado_and = valor_inicial && valor_user;
  let resultado_or = valor_inicial || valor_user;

  println!("\nresultados");
  println!("{} AND {} = {}", valor_inicial, valor_user, resultado_and);
  println!("{} OR {} = {}", valor_inicial, valor_user, resultado_or);
}
