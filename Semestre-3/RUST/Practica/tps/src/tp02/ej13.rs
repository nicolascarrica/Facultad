// 13-Definir una función llamada ordenar_nombres que recibe un arreglo de String y los
// ordena en orden alfabético.

pub fn ordenar_nombres(arr: &mut [String]) {
    arr.sort();
}
#[test]
fn test_ordenar_nombres() {
    let mut nombres = ["Juan".to_string(), "Ana".to_string(), "Pedro".to_string(), "Maria".to_string(), "Luis".to_string()];
    ordenar_nombres(&mut nombres);
    assert_eq!(nombres, ["Ana", "Juan", "Luis", "Maria", "Pedro"]);
}