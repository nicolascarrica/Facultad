
use std::fmt::Display;
impl std::error::Error for ErrorConcesionario {}
use serde::{Deserialize, Serialize};

#[derive(Debug, PartialEq)]
enum ErrorConcesionario {
  Capacidad(u32),
  AgregarEnArchivo,
  EliminarEnArchivo,
  AutoNoEncontrado,
}


impl Display for ErrorConcesionario {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
    match self {
      ErrorConcesionario::Capacidad(c) => write!(f, "Capacidad de {} autos alcanzada", c),
      ErrorConcesionario::AgregarEnArchivo => {
        write!(f, "Error al intentar agregar autos al archivo")
      }
      ErrorConcesionario::EliminarEnArchivo => {
        write!(f, "Error al intentar borrar autos del archivo")
      }
      ErrorConcesionario::AutoNoEncontrado => {
        write!(f, "El auto buscado no se encuentra en el concesionario")
      }
    }
  }
}
#[derive(Debug, Clone, Serialize, Deserialize)]
struct Auto{
  marca: String,
  modelo: String,
  anio: u32,
  precio: f32,
  color: Color,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
enum Color {
  Rojo,
  Verde,
  Azul,
  Amarillo,
  Blanco,
  Negro,

 }
 
#[derive(Debug, Clone, Serialize, Deserialize)]
struct ConcesionarioAuto {
  nombre: String,
  direccion: String,
  autos: Vec<Auto>,
  capacidad_maxima: usize,
  ruta_archivo: String
}

impl Auto {
  fn new(marca: String, modelo: String, anio: u32, precio: f32, color: Color) -> Auto{
    Auto {
      marca,
      modelo,
      anio,
      precio,
      color,
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
      ruta_archivo: "src/tp05/autos.json".to_string(),
    }
  }

  fn agregar_auto(&mut self, auto: Auto) -> Result<(), ErrorConcesionario> {
    if self.autos.len() < self.capacidad_maxima {
      self.autos.push(auto);
      self.guardar_en_archivo()?;
      Ok(())
    } else {
      Err(ErrorConcesionario::Capacidad(self.autos.len() as u32))
    }
  }

  fn eliminar_auto(&mut self, auto: &Auto) -> Result<bool, ErrorConcesionario> {
        let mut posicion = None;
        for (i, a) in self.autos.iter().enumerate() {
            if a.eq(auto) {
                posicion = Some(i);
                break;
            }
        }
        if let Some(i) = posicion {
            self.autos.remove(i);
            self.guardar_en_archivo()?;
            Ok(true)
        } else {
            Ok(false)
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

  fn guardar_en_archivo(&self) -> Result<(), ErrorConcesionario> {
    let json = serde_json::to_string(&self.autos);
    if let Ok(json_string) = json {
        if let Err(_e) = std::fs::write(&self.ruta_archivo,json_string) {
            return Err(ErrorConcesionario::AgregarEnArchivo);  // <--- return aquí
        } else {
            return Ok(());
        }
    } else {
        return Err(ErrorConcesionario::AgregarEnArchivo);
    }
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

    let auto3 = Auto::new(
      String::from("Toyota"), 
      String::from("Corolla"), 
      2023, 
      10000.0, 
      Color::Amarillo
    );
    // Precio inicial: 10000.0
    // Recargo por color primario: 10000.0 * 0.25 = 2500.0
    // Precio final esperado: 12500.0
    assert_eq!(auto3.calcular_precio(),12500.0)
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

    if let Ok(_) = concesionario.agregar_auto(auto1.clone()) {
      assert_eq!(concesionario.autos.len(), 1);
    } else {
      assert!(false, "Error agregando auto1");
    }

    if let Ok(_) = concesionario.agregar_auto(auto2.clone()) {
      assert_eq!(concesionario.autos.len(), 2);
    } else {
      assert!(false, "Error agregando auto2");
    }

    if let Ok(resultado) = concesionario.eliminar_auto(&auto1) {
      assert_eq!(resultado, true);
    } else {
      assert!(false, "Error eliminando auto");
    }
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
        
    let resultado = concesionario.agregar_auto(auto);
    assert!(resultado.is_ok());

    // Ahora accedemos a una posición fuera de rango → esto debería panickear
    let _fuera_de_rango = &concesionario.autos[1];
  }

  #[test]
  fn test_agregar_auto_no_permite() {
    let mut concesionario = ConcesionarioAuto::new(
        String::from("Mi Concesionario"),
        String::from("Calle Falsa 123"),
        0, // capacidad máxima 0
    );

    let auto = Auto::new(
        String::from("Ford"),
        String::from("Focus"),
        2020,
        15000.0,
        Color::Azul,
    );

    let resultado = concesionario.agregar_auto(auto);

    assert!(resultado.is_err());
    if let Err(e) = resultado {
        assert_eq!(e, ErrorConcesionario::Capacidad(0));
    } else {
        panic!("Se esperaba un error, pero no ocurrió");
    }
  }

  #[test]
  fn test_display_error_concesionario() {
    let err1 = ErrorConcesionario::Capacidad(5);
    assert_eq!(format!("{}", err1), "Capacidad de 5 autos alcanzada");

    let err2 = ErrorConcesionario::AgregarEnArchivo;
    assert_eq!(format!("{}", err2), "Error al intentar agregar autos al archivo");

    let err3 = ErrorConcesionario::EliminarEnArchivo;
    assert_eq!(format!("{}", err3), "Error al intentar borrar autos del archivo");

    let err4 = ErrorConcesionario::AutoNoEncontrado;
    assert_eq!(format!("{}", err4), "El auto buscado no se encuentra en el concesionario");
  }
  
  // PERSISTENCIA
  #[test]
fn test_agregar_auto_guarda_en_archivo() -> Result<(), Box<dyn std::error::Error>> {
    use std::fs;
    use std::path::Path;

    // Crear carpeta tests si no existe (solo en test)
    let test_dir = "tests";
    if !Path::new(test_dir).exists() {
        fs::create_dir(test_dir).expect("No se pudo crear la carpeta tests");
    }

    let mut concesionario = ConcesionarioAuto::new(
        "Mi Concesionario".to_string(),
        "Calle Falsa 123".to_string(),
        5,
    );

    concesionario.ruta_archivo = format!("{}/canciones_test.json", test_dir);
    let _ = fs::remove_file(&concesionario.ruta_archivo);

    let auto = Auto::new(
        "Ford".to_string(),
        "Focus".to_string(),
        2020,
        15000.0,
        Color::Azul,
    );

    concesionario.agregar_auto(auto.clone())?;

    let contenido = std::fs::read_to_string(&concesionario.ruta_archivo)?;
    assert!(contenido.contains("Ford"));
    assert!(contenido.contains("Focus"));

    Ok(())
  }
}
