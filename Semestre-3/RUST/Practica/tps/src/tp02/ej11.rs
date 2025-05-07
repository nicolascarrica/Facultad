// 11-Definir la función llamada multiplicar_valores que recibe como parámetro un arreglo de
// enteros y otro número entero llamado factor. Esta función multiplica los valores del arreglo
// por el parámetro factor modificándolo.

pub fn multiplicar_valores(arr: &mut [i32], factor: i32) {
    for elemento in arr.iter_mut() {
        *elemento *= factor; // * significa que estamos desreferenciando el puntero para acceder al valor;
    }
}

#[test]
fn test_multiplicar_valores() {
    let mut numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    let factor = 2;
    multiplicar_valores(&mut numeros, factor);
    assert_eq!(numeros, [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]);
    assert_ne!(numeros, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
}