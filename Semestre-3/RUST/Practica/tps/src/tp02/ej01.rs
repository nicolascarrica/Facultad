// 1-Definir la función llamada es_par que recibe como parámetro un número entero y retorna
// true si el número es par, false caso contrario
pub fn es_par(num: i32) -> bool {
  let resultado = num % 2 == 0;
  resultado
}


#[test]
fn test_es_par() {
    assert_eq!(es_par(2), true);
    assert_eq!(es_par(3), false);
}