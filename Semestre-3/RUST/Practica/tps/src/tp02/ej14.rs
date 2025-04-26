// 14-Definir una función llamada incrementar que recibe como parámetro un número flotante
// e incrementa en 1 su valor.

pub fn incrementar(numero :f32 ) -> f32 {
    numero + 1.0
}

#[test]
fn test_incrementar() {
    let numero = 5.0;
    let resultado = incrementar(numero);
    assert_eq!(resultado, 6.0);
}