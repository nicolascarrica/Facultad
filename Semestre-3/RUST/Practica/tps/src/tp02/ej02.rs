// 2- Definir la función llamada es_primo que recibe un número entero positivo mayor a 1 y
// retorna true si es primo, false caso contrario.

pub fn es_primo(num: i32) -> bool {
  let mut es_primo = true;
  if num <= 1 {
    es_primo = false;
  }

  for i in 2..num {
    if num % i == 0 {
      es_primo = false;
      break;
    }
  }
  es_primo
}

#[test]
fn test_es_primo() {
    assert_eq!(es_primo(2), true);
    assert_eq!(es_primo(3), true);
    assert_eq!(es_primo(4), false);
}