// 6-Definir la función llamada longitud_de_cadenas que recibe un arreglo de String y retorna
// un arreglo con la longitud de las cadenas del parámetro, correspondiéndose en posición del
// arreglo

pub fn longitud_de_cadenas<const N: usize>(arr: &[String]) -> [usize;N] {
  let mut nuevo_arr = [0; N];
  for i in 0..arr.len() {
    nuevo_arr[i] = arr[i].len();
  }
  nuevo_arr
}

#[test]
fn test_longitud_de_cadenas() {
  let cadenas = ["hola".to_string(), "mundo".to_string(), "como".to_string(), "estas".to_string()];
  let longitudes = longitud_de_cadenas(&cadenas);
  assert_eq!(longitudes, [4, 5, 4, 5]);
}
