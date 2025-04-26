// 10-Definir la función llamada cantidad_de_cadenas_mayor_a que recibe como parámetros
// un arreglo de String y un entero llamado límite. Esta función retorna la cantidad de Strings
// del arreglo que son de longitud mayor al parámetro límite


pub fn cantidad_de_cadenas_mayor_a(arr: &[String], limite: i32) -> i32 {
  let mut cantidad = 0;
  for elemento in arr {
    if elemento.len() > limite as usize { // Convertir limite a usize para comparar con la longitud de la cadena// consultar.
      cantidad += 1;
    }
  }

  cantidad
}

#[test]
fn test_cantidad_de_cadenas_mayor_a() {
  let cadenas = ["hola".to_string(), "mundo".to_string(), "como".to_string(), "estas".to_string(), "hoy".to_string()];
  let limite = 4;
  let cantidad = cantidad_de_cadenas_mayor_a(&cadenas, limite);
  assert_eq!(cantidad, 2);
}
