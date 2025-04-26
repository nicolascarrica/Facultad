// 12-Definir una función llamada reemplazar_pares que recibe un arreglo de enteros y
// reemplaza todos los números pares por -1.

pub fn reemplazar_pares(arr: &mut [i32]) {
    for elemento in arr.iter_mut() {
        if *elemento % 2 == 0 {
            *elemento = -1;
        }
    }
}

#[test]
fn test_reemplazar_pares() {
    let mut numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    reemplazar_pares(&mut numeros);
    assert_eq!(numeros, [1, -1, 3, -1, 5, -1, 7, -1, 9, -1]);
}