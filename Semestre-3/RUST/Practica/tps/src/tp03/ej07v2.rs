// 7- Defina una estructura llamada ConcesionarioAuto donde se conoce el nombre, la 
// dirección y tiene una capacidad máxima para albergar X cantidad de autos. De los autos se 
// conocen los campos de la marca, modelo, año, precio bruto y  color que pueden ser:rojo, 
// verde, azul, amarillo, blanco o negro. 
 
// Para dichas estructuras implemente los siguientes métodos: 
// ❖      ConcesionarioAuto: 
// ➢  new: que pasando los parámetros correspondientes, crea un 
// ConcesionarioAuto y lo retorna. 
// ➢  agregar_auto(auto): agrega un auto a la lista de autos que tiene sin superar 
// la máxima cantidad para albergarlos y retorna true, en caso de que lo supere 
// no lo agrega y retorna false. 
// ➢  eliminar_auto(auto): elimina un auto de la lista de autos. 
// ➢  buscar_auto(auto): busca un auto y si lo encuentra lo retorna. 
// ❖      Auto: 
// ➢  new: que pasando los parámetros correspondientes, crea un Auto y lo 
// retorna. 
// ➢  calcular_precio: retorna el precio del auto aplicando los siguientes criterios: 
// ■  si es de color primario le aplica un recargo del 25%, sino le aplica un 
// descuento del 10%. 
// ■  si la marca es BMW le aplica un recargo del 15%- 
// ■  si el año es menor a 2000 le aplica un descuento del 5%.

#[derive(Debug, Clone)]
struct Auto{
  marca: String,
  modelo: String,
  anio: u32,
  precio: f32,
  color: Color,
}

#[derive(Debug, Clone)]
enum Color {
  Rojo,
  Verde,
  Azul,
  Amarillo,
  Blanco,
  Negro,

 }
struct ConcesionarioAuto {
  nombre: String,
  direccion: String,
  autos: Vec<Auto>,
  capacidad_maxima: usize,
}

impl Auto {
  fn new(marca: String, modelo: String, anio: u32, precio: f32, color: Color) -> Auto{
    Auto {
      marca,
      modelo,
      anio,
      precio,
      color
    }
  }


  fn calcular_precio(&self) -> f32 {
    let mut precio_adcional = match self.color {
      Color::Rojo => self.precio *1.25,
      Color::Amarillo => self.precio *1.25,
      Color::Azul => self.precio *1.25,
      _ => self.precio *0.9,
        
    };

    if self.marca == "BMW".to_string() {
      precio_adcional+=self.precio*0.15;
    }

    if self.anio < 2000 {
      precio_adcional-=self.precio*0.05;
    }

    return precio_adcional;
  }

  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

impl ConcesionarioAuto {
  fn new(nombre: String, direccion: String, capacidad_maxima: usize) -> ConcesionarioAuto{
    ConcesionarioAuto { 
      nombre, 
      direccion, 
      autos: Vec::new(),
      capacidad_maxima,
    }
  }

  fn agregar_auto(&mut self, auto: Auto) -> bool {
    if self.autos.len() < self.capacidad_maxima {
      self.autos.push(auto);
      true
    } else {
      false
    }
  }

  fn eliminar_auto(&mut self, auto: &Auto) -> bool {
    // Usamos una referencia (&Auto) en lugar del valor completo para no copiar todo el Auto
    let mut posicion = 0;
    for i in 0..self.autos.len() {
      if self.autos[i].eq(auto) {
        posicion = i;
        break;
      }
    }
    if posicion < self.autos.len() {
      self.autos.remove(posicion);
      true
    } else {
      false
    }
  }

  fn buscar_auto(&self, auto: &Auto) -> Option<&Auto> {
    //self.autos.iter().find(|&a| a== auto)
    for i in 0..self.autos.len() {
      if self.autos[i].eq(auto) {
        return Some(&self.autos[i]);
      }
    }
    None
  }
}

#[cfg(test)]
mod test{
  use super::*;

  #[test]
  fn test_new_auto(){
    let auto = Auto::new(
      "Toyota".to_string(), 
      "Corolla".to_string(), 
      2023, 
      10000.0,
      Color::Rojo,
    );
    assert_eq!(auto.marca, "Toyota");
    assert_eq!(auto.modelo, "Corolla");
    assert_eq!(auto.anio, 2023);
    assert_eq!(auto.precio, 10000.0);
    assert!(matches!(&auto.color, Color::Rojo));
  }

  #[test]
  fn test_calcular_precio(){
    let auto1 = Auto::new(
      String::from("Toyota"), 
      String::from("Corolla"), 
      2023, 
      10000.0, 
      Color::Rojo
    );
    // Precio inicial: 10000.0
    // Recargo por color primario: 10000.0 * 0.25 = 2500.0
    // Precio final esperado: 12500.0
    assert_eq!(auto1.calcular_precio(),12500.0);

    // Auto BMW, color no primario (Blanco), año antiguo
    let auto2 = Auto::new(
      String::from("BMW"), 
      String::from("X5"), 
      1999, 
      20000.0, 
      Color::Blanco
    );
  
    // Precio inicial: 20000.0
    // Recargo por BMW: 20000.0 * 0.15 = 3000.0
    // Descuento por año < 2000: 20000.0 * 0.05 = 1000.0
    // Descuento por color no primario: 20000.0 * 0.10 = 2000.0
    // Precio final esperado: 20000.0 + 3000.0 - 1000.0 - 2000.0 = 20000.0
    assert_eq!(auto2.calcular_precio(), 20000.0);
  }

  #[test]
  #[should_panic]
  fn test_calculo_precio_incorrecto() {
    // Auto BMW de color primario (Azul) y año 1990
    let auto = Auto::new(
      String::from("BMW"),
      String::from("Serie 3"),
      1990,
      10000.0,
      Color::Azul
    );
  
    // Precio base: 10000.0
    // Recargo por BMW: 10000.0 * 0.15 = 1500.0
    // Descuento por año < 2000: 10000.0 * 0.05 = 500.0
    // Recargo por color primario: 10000.0 * 0.25 = 2500.0
    // Precio final correcto: 10000.0 + 1500.0 - 500.0 + 2500.0 = 13500.0
  
    // Este test fallará porque el valor esperado es incorrecto
    assert_eq!(auto.calcular_precio(), 12000.0); // Valor incorrecto
  }

  #[test]
  fn test_new_concesionario(){
    let concesionario = ConcesionarioAuto::new(
      String::from("Mi Concesionario"), 
      String::from("Calle Falsa 123"), 
      10
    );
    assert_eq!(concesionario.nombre, "Mi Concesionario");
    assert_eq!(concesionario.direccion, "Calle Falsa 123");
    assert_eq!(concesionario.capacidad_maxima, 10);
    assert_eq!(concesionario.autos.len(), 0);
  }

  #[test]
  fn test_consecionario(){
    let mut concesionario = ConcesionarioAuto::new(
      String::from("Mi Concesionario"), 
      String::from("Calle Falsa 123"), 
      10
    );
    let auto1 = Auto::new(
      String::from("Toyota"), 
      String::from("Corolla"), 
      2023, 
      10000.0, 
      Color::Rojo
    );

    let auto2 = Auto::new(
      String::from("BMW"), 
      String::from("X5"), 
      1999, 
      20000.0, 
      Color::Blanco
    );
    assert_eq!(concesionario.agregar_auto(auto1.clone()), true); // para evitar el owner ship
    assert_eq!(concesionario.autos.len(), 1);

    assert_eq!(concesionario.agregar_auto(auto2.clone()), true);
    assert_eq!(concesionario.autos.len(), 2);

    assert_eq!(concesionario.eliminar_auto(&auto1), true);
    assert_eq!(concesionario.autos.len(), 1);

    assert!(concesionario.buscar_auto(&auto1).is_none()); // devuelve un option la funcion, entonces usamos is_none()
  }

  #[test]
  #[should_panic]
  fn test_acceso_fuera_de_indice() {
    let mut concesionario = ConcesionarioAuto::new(
      String::from("AutoMundo"),
      String::from("Av. Principal 123"),
      2
    );
        
    let auto = Auto::new(
      String::from("Ford"),
      String::from("Focus"),
      2020,
      15000.0,
      Color::Azul
    );
        
    concesionario.agregar_auto(auto);
    let _auto_inexistente = &concesionario.autos[5]; // Índice fuera de rango

    assert!(false);
    
  }

    
}
