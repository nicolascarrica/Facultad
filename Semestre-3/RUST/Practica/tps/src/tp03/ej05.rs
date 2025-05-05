// 5- Escribir un programa que defina una estructura Producto que tenga campos para el 
// nombre, el precio bruto y un número identificatorio. Para dicha estructura implemente los 
// siguientes métodos: 
 
// ➢  new: que pasando los parámetros correspondientes, crea un Producto y lo retorna. 
// ➢  calcular_impuestos(porcentaje_de_impuestos): retorna el valor de impuestos sobre 
// el precio bruto 
// ➢  aplicar_descuento(porcentaje_de_descuento): retorna el valor del porcentaje de 
// descuento sobre el precio bruto 
// ➢  calcular_precio_total(porcentaje_de_impuestos, porcentaje_descuento): retorna el 
// precio total a pagar aplicando impuesto y descuento. Tenga en cuenta que los 
// parámetros son opcionales.

struct Producto {
  nombre: String,
  precio: f32,
  id: u32,
}

impl Producto {
  fn new(nombre: String, precio: f32, id: u32) -> Producto {
    Producto{
      nombre,
      precio,
      id
    }
  }

  fn calcular_impuestos(&self, porcentaje_de_impuestos: f32) -> f32 {
    let valor_impuestos: f32 = (self.precio * porcentaje_de_impuestos)/100.0;
    valor_impuestos
  }

  fn aplicar_descuento(&self, porcentaje_de_descuento: f32) -> f32 {
    return (self.precio * porcentaje_de_descuento)/100.0;
  }

  fn calcular_precio_total(
    &self, 
    porcentaje_de_impuestos: Option<f32>, 
    porcentaje_de_descuento: Option<f32>
  ) -> f32 {
    let mut precio_total: f32 = self.precio;
    if let Some(porcentaje) = porcentaje_de_impuestos {
      precio_total += self.calcular_impuestos(porcentaje);
    } 
    if let Some(porcentaje) = porcentaje_de_descuento {
      precio_total-= self.aplicar_descuento(porcentaje);
    }

    return precio_total;
  }

}


#[cfg(test)]
mod producto_tests {
  use super::*;
  #[test]
  fn test_new() {
    let producto = Producto::new(String::from("Laptop"), 1000.0, 12345);
    assert_eq!(producto.nombre, "Laptop");
    assert_eq!(producto.precio, 1000.0);
    assert_eq!(producto.id, 12345);
  }

  #[test]
  fn test_calcular_impuestos(){
    let producto = Producto::new(String::from("Laptop"), 1000.0, 12345);

    let impuestos = producto.calcular_impuestos(21.0);
    assert_eq!(impuestos, 210.0);
  }

  #[test]
  fn test_aplicar_descuento(){
    let producto = Producto::new(String::from("Laptop"), 1000.0, 12345);

    let descuento = producto.aplicar_descuento(10.0);
    assert_eq!(descuento, 100.0);
  }

  #[test]
  fn test_calcular_precio_total(){
    let producto = Producto::new(String::from("Laptop"), 1000.0, 12345);

    let precio_total = producto.calcular_precio_total(Some(21.0), Some(10.0));
    assert_eq!(precio_total, 1110.0);

    let precio_solo_impuesto = producto.calcular_precio_total(Some(21.0), None);
    assert_eq!(precio_solo_impuesto, 1210.0);
  }
}