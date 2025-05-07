// 4- Escribir un programa que defina la estructura Triángulo que tenga campos para las 
// longitudes de sus tres lados. Para dicha estructura implemente los siguientes métodos: 
 
// ➢  new: que pasando los parámetros correspondientes, crea un Triángulo y lo retorna. 
// ➢  determinar_tipo: retorna el tipo del triángulo, los tipos pueden ser equilátero, 
// isósceles o escaleno. 
// ➢  calcular_area: calcular el área y la retorna. 
// ➢  calcular_perimetro: calcula el perímetro y lo retorna.


#[derive(Debug, PartialEq)]
enum Tipo {
  Equilatero,
  Isosceles,
  Escaleno,
}

struct Triangulo{
  lado1: f32,
  lado2: f32,
  lado3: f32,
}

impl Triangulo {
  fn new(lado1: f32, lado2: f32, lado3:f32)-> Triangulo {
    Triangulo { lado1, lado2, lado3 }
  }

  fn determinar_tipo(&self) -> Tipo {
    if self.lado1==self.lado2 && self.lado2==self.lado3{
      Tipo::Equilatero
    }
    else if self.lado1 == self.lado2 || self.lado1==self.lado3 || self.lado2==self.lado3{
      Tipo::Isosceles
    }
    else {
      Tipo::Escaleno
    }
  }

  fn calcular_area(&self) -> f32 {
    let semi_perimetro = (self.lado1 + self.lado2 + self.lado3) / 2.0;

    let area = (semi_perimetro * (semi_perimetro - self.lado1) * (semi_perimetro - self.lado2) * (semi_perimetro - self.lado3)).sqrt();

    return area;
  }

  fn calcular_perimetro(&self) -> f32 {
    return self.lado1 + self.lado2 + self.lado3;
  }
}



#[cfg(test)]
mod test_triangulo {
  use super::*;
  #[test]
  fn test_new(){
    let triangulo = Triangulo::new(3.0, 4.0, 5.0);
    assert_eq!(triangulo.lado1, 3.0);
    assert_eq!(triangulo.lado2, 4.0);
    assert_eq!(triangulo.lado3, 5.0);
  }

  #[test]
  fn test_determinar_tipo(){
    let triangulo1 = Triangulo::new(5.0, 5.0, 5.0);
    assert_eq!(triangulo1.determinar_tipo(), Tipo::Equilatero);

    let triangulo2 = Triangulo::new(5.0, 5.0, 8.0);
    assert_eq!(triangulo2.determinar_tipo(), Tipo::Isosceles);

    let triangulo3 = Triangulo::new(5.0, 3.0, 8.0);
    assert_eq!(triangulo3.determinar_tipo(), Tipo::Escaleno);

  }

  #[test]
  fn test_calcular_area(){
    let triangulo = Triangulo::new(3.0, 4.0, 5.0);
    assert_eq!(triangulo.calcular_area(), 6.0)
  }

  #[test]
  fn test_calcular_perimetro(){
    let triangulo = Triangulo::new(3.0, 4.0, 5.0);
    assert_eq!(triangulo.calcular_perimetro(), 12.0);
  }
}