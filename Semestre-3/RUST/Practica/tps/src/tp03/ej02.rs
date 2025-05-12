// 2- Escribir un programa que defina la estructura Rectángulo que tenga campos para la 
// longitud y el ancho. Para dicha estructura implemente los siguientes métodos: 
 
// ➢  new: que pasando los parámetros correspondientes, crea un Rectángulo y lo 
// retorna. 
// ➢  calcular_area: calcular el área y la retorna. 
// ➢  calcular_perimetro: calcula el perímetro y lo retorna. 
// ➢  es_cuadrado: retorna true si es cuadrado, false caso contrario
#[derive(PartialEq, Debug)]
struct Rectangulo {
  longitud: f32,
  ancho: f32,
}

impl Rectangulo {
  fn new (longitud: f32, ancho: f32) -> Rectangulo{
    Rectangulo { longitud, ancho}
  }

  fn calcular_area(&self) -> f32 {
    return self.ancho*self.longitud;
  }

  fn calcular_perimetro(&self) -> f32 {
    return (self.ancho*2.0) + (self.longitud*2.0);
  }

  fn es_cuadrado(&self) -> bool {
    return self.ancho == self.longitud;
  }
}

#[cfg(test)]
mod test_rectangulo{
  use super::*;

  #[test]
  fn test_new(){
    let rect = Rectangulo::new(5.0, 3.0);
    assert_eq!(rect.longitud, 5.0);
    assert_eq!(rect.ancho, 3.0);
  }

  #[test]
  fn test_calcular_area(){
    let rect = Rectangulo::new(5.0,3.0);
    assert_eq!(rect.calcular_area(),15.0);
  }

  //test para un triangulo sin lados, debe dar error
  #[test]
  fn test_calcular_area_sin_lados(){
    let rect = Rectangulo::new(0.0,0.0);
    assert_eq!(rect.calcular_area(),0.0);
  }

  #[test]
  fn test_calcular_perimetro(){
    let rect = Rectangulo::new(5.0, 3.0);
    assert_eq!(rect.calcular_perimetro(), 16.0);
  }

  #[test]
  fn test_es_cuadrado(){
    let rect1 = Rectangulo::new(4.0,4.0);
    let rect2 = Rectangulo::new(2.0,5.0);
    assert_eq!(rect1.es_cuadrado(), true);
    assert_eq!(rect2.es_cuadrado(), false);
  }
}

