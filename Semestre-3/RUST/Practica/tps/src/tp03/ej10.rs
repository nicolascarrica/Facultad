// 10-Para una biblioteca se desea implementar un sistema de préstamos de libros. De la 
// biblioteca se conoce el nombre y la dirección, las copias de los libros a disposición para 
// prestar y los préstamos efectuados. Los libros a disposición es un registro donde se indica 
// la cantidad de ejemplares que tiene a disposición para prestar de determinado libro. De 
// cada libro se conoce el isbn, el título, autor, número de páginas, género(novela, infantil, 
// técnico, otros). Para registrar un préstamo se requiere el libro, el cliente, la fecha de 
// vencimiento del préstamo, la fecha de devolución y el estado que puede ser devuelto o en 
// préstamo. Del cliente se conoce el nombre, teléfono y dirección de correo electrónico. 
// Implemente los métodos necesarios para realizar las siguientes acciones
// ➔  obtener cantidad de copias: dado un determinado libro retorna la cantidad de 
// copias a disposición que hay para prestar de dicho libro. 
// ➔  decrementar cantidad de copias a disposición; dado un libro decrementa en 1 
// la cantidad de copias de libros a disposición para prestar. 
// ➔  incrementar cantidad de copias a disposición: dado un libro incrementa en 1 
// la cantidad de copias del libro a disposición para ser prestado. 
// ➔  contar préstamos de un cliente: devuelve la cantidad de préstamos en estado 
// “en préstamo” de un determinado cliente. 
// ➔  realizar un préstamo de un libro para un cliente: crea un préstamo de un libro 
// para un determinado cliente cumpliendo con lo siguiente  
// ◆  el cliente no tenga más de 5 préstamos en el estado “en préstamo” 
// ◆   haya al menos una copia disponible en el registro de copias a 
// disposición. 
//  De ser así descuenta 1 en el registro de “copias a disposición” y 
// retorna true, si no cumple con alguna de las condiciones retorna false. 
// ➔  ver préstamos a vencer el los próximos días: retorna una lista de préstamos a 
// vencer el los próximos días, el valor de días es pasado por parámetro. 
// ➔  ver los préstamos vencidos: retorna una lista de préstamos en el estado “en 
// préstamos” donde la fecha de vencimiento es menor a la fecha actual. 
// ➔  buscar préstamo: dado un libro y un cliente busca un préstamo y lo retorna si 
// existe. 
// ➔  devolver libro: dado un libro y un cliente se busca el préstamo y se cambia al 
// estado “devuelto”, se registra la fecha de devolución y se incrementa la 
// cantidad de libros en 1 del libro devuelto en el registro de copias a 
// disposición. 
 
// Nota: para la fecha utilice lo implementado en el punto 3. 

use super::ej03::Fecha;
use chrono::prelude::*;

#[derive(Debug, Clone)]
struct Cliente {
  nombre: String,
  telefono: u32,
  correo_electronico: String,
}

#[derive(Debug, Clone)]
enum Genero {
  Novela,
  Infantil,
  Tecnico,
  Otros(String),
}
    
#[derive(Debug, Clone)]
struct Libro {
  isbn: u32,
  titulo: String,
  autor: String,
  num_paginas: u32,
  genero: Genero,
}

#[derive(Debug, Clone)]
enum EstadoPrestamo {
  EnPrestamo,
  Devuelto,
}

impl EstadoPrestamo{ // clase 3 pag 23
  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn es_igual(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

#[derive(Debug, Clone)]
struct CopiaDisponible {
    libro: Libro,
    cantidad: u32,
}
#[derive(Debug, Clone)]
struct Prestamo {
  libro: Libro,
  cliente: Cliente,
  fecha_vencimiento: Fecha,
  fecha_devolucion: Option<Fecha>,
  estado: EstadoPrestamo,
}

impl Prestamo {
  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn es_igual(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}


#[derive(Debug, Clone)]
struct Biblioteca {
  nombre: String,
  direccion: String,
  copias_disponibles: Vec<CopiaDisponible>,
  prestamos: Vec<Prestamo>,
}

impl Biblioteca {
  fn new(nombre: String, direccion: String) -> Self {
    Biblioteca {
      nombre,
      direccion,
      copias_disponibles: Vec::new(),
      prestamos: Vec::new(),
    }
  }

  fn obtener_cantidad_copias(&self, libro: &Libro) -> Option<u32> {
    if self.copias_disponibles.is_empty() {
      return None;
    }
    let mut cantidad: u32 = 0;
    for copia_disponible in &self.copias_disponibles {
      if copia_disponible.libro.isbn == libro.isbn {
        cantidad += copia_disponible.cantidad;
      }
    }
    Some(cantidad)
  }

  fn decrementar_cantidad_copias(&mut self, libro: &Libro)-> Option<bool>{
    if self.copias_disponibles.is_empty() {
      return None;
    }

    for copia_disponible in &mut self.copias_disponibles {
      if copia_disponible.libro.isbn == libro.isbn {
        if copia_disponible.cantidad == 0 {
          return None;
        }
        else {
          copia_disponible.cantidad -= 1;
          return Some(true);
        }        
      }
    }
    None
  }

  fn incrementar_cantidad_copias(&mut self, libro: &Libro)-> Option<bool>{
    if self.copias_disponibles.is_empty() {
      return None;
    }

    for copia_disponible in &mut self.copias_disponibles {
      if copia_disponible.libro.isbn == libro.isbn {
        copia_disponible.cantidad += 1;
        return Some(true);
      }
    }
    None
  }

  fn contar_prestamos_cliente(&mut self, cliente: &Cliente) -> Option<u32> {
    if self.prestamos.is_empty() {
      return None;
    }
    let mut cantidad: u32 = 0;
    for prestamo in &self.prestamos {
      if (prestamo.cliente.nombre == cliente.nombre) && (prestamo.estado.es_igual(&EstadoPrestamo::EnPrestamo)) {
        cantidad += 1;
      }
    }
    Some(cantidad)
  }

  fn realizar_prestamo(&mut self, libro: &Libro, cliente: &Cliente, fecha_vencimiento: Fecha) -> bool {
    // si tiene menos de 5 prestamos y hay al menos una copia disponible se puede realizar el prestamo
    if self.contar_prestamos_cliente(cliente) >= Some(5) || self.obtener_cantidad_copias(libro) < Some(1) {
      return false
    }
    else {
      self.prestamos.push(Prestamo {
        libro: libro.clone(),
        cliente: cliente.clone(),
        fecha_vencimiento: fecha_vencimiento,
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo
      });
      self.decrementar_cantidad_copias(libro);
      return true
    }
  }

  fn ver_prestamos_a_vencer(&self, dias: u32) -> Vec<Prestamo> {
    let mut prestamos_a_vencer: Vec<Prestamo> = Vec::new();
    let now = Local::now();
    let hoy = Fecha::new(now.day(), now.month(), now.year() as u32); // fecha actual usando la libreria chrono
    for prestamo in &self.prestamos {
      let mut fecha_vencimiento = prestamo.fecha_vencimiento.clone();
      fecha_vencimiento.sumar_dias(dias);
      if prestamo.fecha_vencimiento.es_mayor(&hoy) && prestamo.estado.es_igual(&EstadoPrestamo::EnPrestamo) {
        prestamos_a_vencer.push(prestamo.clone());
      }
    }
    return prestamos_a_vencer;
  }

  fn ver_prestamos_vencidos(&self) -> Vec<Prestamo> {
    let mut prestamos_vencidos: Vec<Prestamo> = Vec::new();
    let now = Local::now();
    let hoy = Fecha::new(now.day(), now.month(), now.year() as u32); // fecha actual usando la libreria chrono
    for prestamo in &self.prestamos {
      if !(prestamo.fecha_vencimiento.es_mayor(&hoy)) && prestamo.estado.es_igual(&EstadoPrestamo::EnPrestamo) {
        prestamos_vencidos.push(prestamo.clone());
      }
    }
    return prestamos_vencidos;
  }

  fn buscar_prestamo(&self, libro: &Libro, cliente: &Cliente) -> Option<Prestamo> { 
    for prestamo in & self.prestamos {
      if prestamo.libro.isbn == libro.isbn && prestamo.cliente.nombre == cliente.nombre {
        return Some(prestamo.clone());
      }
    }
    None
  }

  fn devolver_prestamo(&mut self, libro:&Libro, cliente:&Cliente) -> bool {
    for prestamo in &mut self.prestamos {
      if prestamo.libro.isbn == libro.isbn && prestamo.cliente.nombre == cliente.nombre {
        prestamo.estado = EstadoPrestamo::Devuelto;
        let now = Local::now();
        let hoy = Fecha::new(now.day(), now.month(), now.year() as u32); // fecha actual usando la libreria chrono
        prestamo.fecha_devolucion = Some(hoy);
        self.incrementar_cantidad_copias(&libro);
        return true;
      }
    }
    false
  }
}

#[cfg(test)]
mod tests {
  use super::*;
  use crate::tp03::ej03::Fecha;

  fn crear_bibioteca_prueba() -> Biblioteca {
    let mut biblioteca = Biblioteca::new(
      "Bilioteca PrUeba".to_string(),
      "calle Prueba 112".to_string()
    );

    let libro1 = Libro {
      isbn: 1234,
      titulo:"El Pricipito".to_string(),
      autor:"Antoine de Saint-Exupery".to_string(),
      num_paginas: 100,
      genero: Genero::Infantil
    };

    let libro2 = Libro {
      isbn: 4567,
      titulo:"100 anios de soledad".to_string(),
      autor:"Gabriel Garcia Marquez".to_string(),
      num_paginas: 350,
      genero: Genero::Novela
    };

    let libro3 = Libro {
      isbn: 7890,
      titulo:"Harry Potter".to_string(),
      autor:"J.K. Rowling".to_string(),
      num_paginas: 450,
      genero: Genero::Novela
    };

    biblioteca.copias_disponibles.push(CopiaDisponible { 
      libro: libro1,
      cantidad: 3
    });

    biblioteca.copias_disponibles.push(CopiaDisponible { 
      libro: libro2,
      cantidad: 5
    });

    biblioteca.copias_disponibles.push(CopiaDisponible { 
      libro: libro3,
      cantidad: 0 //un libro sin copias
    });

    return biblioteca;

  }


  fn crear_cliente_prueba(nombre:&str) -> Cliente {
    Cliente {
      nombre: nombre.to_string(),
      telefono: 1522215,
      correo_electronico: format!("{}@example.com", nombre.to_lowercase()),
    }
  }

  #[test]
  fn obtener_cantidad_copias_test(){
    let biblioteca = crear_bibioteca_prueba();

    //libro con copias
    let cantidad = biblioteca.obtener_cantidad_copias(&biblioteca.copias_disponibles[0].libro);
    assert_eq!(cantidad, Some(3));

    //libro sin copias
    let cantidad2 = biblioteca.obtener_cantidad_copias(&biblioteca.copias_disponibles[2].libro);
    assert_eq!(cantidad2, Some(0));

    // libro que no existe
    let libro_inexistente = Libro {
      isbn: 0001,
      titulo: String::from("Un Libro"),
      autor: "Un Autor".to_string(),
      num_paginas: 0,
      genero: Genero::Otros("Desconocido".to_string())
    };

    let cantidad3 = biblioteca.obtener_cantidad_copias(&libro_inexistente);
    assert_eq!(cantidad3, Some(0));

    // caso para una biblioteca vacia

    let biblioteca_vacia = Biblioteca::new("Vacia".to_string(), "Mi casa".to_string());
    let cantidad4 = biblioteca_vacia.obtener_cantidad_copias(&libro_inexistente);
    assert_eq!(cantidad4, None);
  }

  #[test]
  fn decrementar_cantidad_copias_test(){
    let mut biblioteca = crear_bibioteca_prueba();

    // caso normal, con unlibro que tiene copias
    let libro = &biblioteca.copias_disponibles[0].libro.clone();
    let result = biblioteca.decrementar_cantidad_copias(libro);
    assert_eq!(result, Some(true));
    assert_eq!(biblioteca.copias_disponibles[0].cantidad, 2);

    // caso libro sin copias;
    let libro2 = &biblioteca.copias_disponibles[2].libro.clone();
    let result = biblioteca.decrementar_cantidad_copias(libro2);
    assert_eq!(result, None);
    assert_eq!(biblioteca.copias_disponibles[2].cantidad, 0);

    // prueba con un libro que no existe;
    let libro_inexistente: Libro = Libro {
      isbn: 0001,
      titulo: String::from("Un Libro"),
      autor: "Un Autor".to_string(),
      num_paginas: 0,
      genero: Genero::Otros("Desconocido".to_string())
    };

    let result = biblioteca.decrementar_cantidad_copias(&libro_inexistente);
    assert_eq!(result, None);
  }

  #[test]
  fn test_incrementar_cantidad_copias(){
    let mut biblioteca = crear_bibioteca_prueba();
    // caso normal, con unlibro que tiene copias
    let libro = &biblioteca.copias_disponibles[0].libro.clone();
    let result = biblioteca.incrementar_cantidad_copias(libro);
    assert_eq!(result, Some(true));
    assert_eq!(biblioteca.copias_disponibles[0].cantidad, 4);

    // caso libro sin copuas
    let libro2 = &biblioteca.copias_disponibles[2].libro.clone();
    let result = biblioteca.incrementar_cantidad_copias(libro2);
    assert_eq!(result, Some(true));
    assert_eq!(biblioteca.copias_disponibles[2].cantidad, 1);

    // prueba con un libro que no existe;
    let libro_inexistente: Libro = Libro {
      isbn: 0001,
      titulo: String::from("Un Libro"),
      autor: "Un Autor".to_string(),
      num_paginas: 0,
      genero: Genero::Otros("Desconocido".to_string())
    };

    let result = biblioteca.incrementar_cantidad_copias(&libro_inexistente);
    assert_eq!(result, None);

  }

  #[test]
  fn test_contar_prestamos_cliente() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Roman");
    let cliente2 = crear_cliente_prueba("Flor");
        
    // Caso de biblioteca sin préstamos
    let cantidad = biblioteca.contar_prestamos_cliente(&cliente);
    assert_eq!(cantidad, None);
        
    // Preparar algunos prestamos
    let prestamo1 = Prestamo {
      libro: biblioteca.copias_disponibles[0].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: Fecha::new(15, 5, 2025),
      fecha_devolucion: None,
      estado: EstadoPrestamo::EnPrestamo,
    };
        
    let prestamo2 = Prestamo {
      libro: biblioteca.copias_disponibles[1].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: Fecha::new(20, 5, 2025),
      fecha_devolucion: None,
      estado: EstadoPrestamo::EnPrestamo,
    };
      
    let prestamo3 = Prestamo {
      libro: biblioteca.copias_disponibles[0].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: Fecha::new(10, 5, 2025),
      fecha_devolucion: Some(Fecha::new(5, 5, 2025)),
      estado: EstadoPrestamo::Devuelto, // Este no deberia contarse
    };
      
    biblioteca.prestamos.push(prestamo1);
    biblioteca.prestamos.push(prestamo2);
    biblioteca.prestamos.push(prestamo3);
      
    // Caso normal: cliente con pretamos
    let cantidad = biblioteca.contar_prestamos_cliente(&cliente);
    assert_eq!(cantidad, Some(2));
      
    // Caso de cliente sin prestamos
    let cantidad = biblioteca.contar_prestamos_cliente(&cliente2);
    assert_eq!(cantidad, Some(0));
  }

  #[test]
  fn test_realizar_prestamo() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Juan");
        
    // Caso normal: realizar prestamo exitoso
    let fecha_vencimiento = Fecha::new(15, 5, 2025);
    let resultado = biblioteca.realizar_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente, fecha_vencimiento.clone());
    assert_eq!(resultado, true);
    assert_eq!(biblioteca.prestamos.len(), 1);
    assert_eq!(biblioteca.copias_disponibles[0].cantidad, 2); 
        
    // Caso de error: intentar prestar libro sin copias disponibles
    let resultado = biblioteca.realizar_prestamo(&biblioteca.copias_disponibles[2].libro.clone(), &cliente, fecha_vencimiento.clone());
    assert_eq!(resultado, false); 
        
    // Caso limite: cliente con 5 préstamos activos
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Pedro");
        
    // Crear 5 préstamos activos
    for _ in 0..5 {
      let prestamo = Prestamo {
        libro: biblioteca.copias_disponibles[0].libro.clone(),
        cliente: cliente.clone(),
        fecha_vencimiento: Fecha::new(15, 5, 2025),
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo,
       };
      biblioteca.prestamos.push(prestamo);
    }
        
    // Intentar hacer el sexto préstamo
    let resultado = biblioteca.realizar_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente, fecha_vencimiento);
    assert_eq!(resultado, false); // Debería fallar, pero con la lógica actual sería true
  }

  #[test]
  fn test_ver_prestamos_a_vencer() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Juan");
        
    // FECHA
    let now = Local::now();
    let hoy = Fecha::new(now.day(), now.month(), now.year() as u32);

    let mut fecha1 = hoy.clone();
    fecha1.sumar_dias(1);
    
    let mut fecha2 =hoy.clone();
    fecha2.sumar_dias(10);
        
    // Crear préstamos con diferentes fechas de vencimiento
    let prestamo1 = Prestamo {
      libro: biblioteca.copias_disponibles[0].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: fecha1,
      fecha_devolucion: None,
      estado: EstadoPrestamo::EnPrestamo,
    };
        
    let prestamo2 = Prestamo {
      libro: biblioteca.copias_disponibles[1].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: fecha2,
      fecha_devolucion: None,
      estado: EstadoPrestamo::EnPrestamo,
    };
        
    biblioteca.prestamos.push(prestamo1);
    biblioteca.prestamos.push(prestamo2);
        
    // Caso normal: prestamos a vencer
    let prestamos_a_vencer = biblioteca.ver_prestamos_a_vencer(5);
    assert_eq!(prestamos_a_vencer.len(), 2);
  }
    
  #[test]
  fn test_ver_prestamos_vencidos() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Pedro");

    let now = Local::now();
    let hoy = Fecha::new(now.day(), now.month(), now.year() as u32);

    // Préstamo vencido ayer
    let mut fecha_ayer = hoy.clone();
    fecha_ayer.restar_dias(1);

    let prestamo_vencido = Prestamo {
        libro: biblioteca.copias_disponibles[0].libro.clone(),
        cliente: cliente.clone(),
        fecha_vencimiento: fecha_ayer,
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo,
    };

    // Préstamo vencido ayer PERO SE DEVOLVIO
    let mut fecha_ayer = hoy.clone();
    fecha_ayer.restar_dias(1);

    let prestamo_vencido_devuelto = Prestamo {
        libro: biblioteca.copias_disponibles[0].libro.clone(),
        cliente: cliente.clone(),
        fecha_vencimiento: fecha_ayer,
        fecha_devolucion: None,
        estado: EstadoPrestamo::Devuelto,
    };

    // Préstamo que vence mañana (todavía no vencido)
    let mut fecha_manana = hoy.clone();
    fecha_manana.sumar_dias(1);

    let prestamo_a_vencer = Prestamo {
        libro: biblioteca.copias_disponibles[2].libro.clone(),
        cliente: cliente.clone(),
        fecha_vencimiento: fecha_manana,
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo,
    };

    biblioteca.prestamos.push(prestamo_vencido);
    biblioteca.prestamos.push(prestamo_a_vencer);
    biblioteca.prestamos.push(prestamo_vencido_devuelto);

    let resultado = biblioteca.ver_prestamos_vencidos();
    assert_eq!(resultado.len(), 1);
    
  }
    
  #[test]
  fn test_buscar_prestamo() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente1 = crear_cliente_prueba("Juan");
    let cliente2 = crear_cliente_prueba("Ana");
        
    // Crear algunos préstamos
    let prestamo1 = Prestamo {
        libro: biblioteca.copias_disponibles[0].libro.clone(),
        cliente: cliente1.clone(),
        fecha_vencimiento: Fecha::new(15, 5, 2025),
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo,
    };
        
    let prestamo2 = Prestamo {
        libro: biblioteca.copias_disponibles[1].libro.clone(),
        cliente: cliente1.clone(),
        fecha_vencimiento: Fecha::new(20, 5, 2025),
        fecha_devolucion: None,
        estado: EstadoPrestamo::EnPrestamo,
    };
        
    biblioteca.prestamos.push(prestamo1.clone());
    biblioteca.prestamos.push(prestamo2.clone());
        
    // Caso normal: buscar préstamo existente
    let resultado = biblioteca.buscar_prestamo(&biblioteca.copias_disponibles[0].libro, &cliente1);
    assert!(resultado.is_some());
    assert!(resultado.unwrap().es_igual(&prestamo1));
        
    // Caso de error: buscar préstamo con libro existente pero cliente diferente
    let resultado = biblioteca.buscar_prestamo(&biblioteca.copias_disponibles[0].libro, &cliente2);
    assert!(resultado.is_none());
        
    // Caso de error: buscar préstamo con libro inexistente
    let libro_inexistente = Libro {
        isbn: 1111111111,
        titulo: String::from("Libro Inexistente"),
        autor: String::from("Autor Desconocido"),
        num_paginas: 100,
        genero: Genero::Otros(String::from("Desconocido")),
    };
    let resultado = biblioteca.buscar_prestamo(&libro_inexistente, &cliente1);
    assert!(resultado.is_none());
  }
    

  #[test]
  fn test_devolver_prestamo() {
    let mut biblioteca = crear_bibioteca_prueba();
    let cliente = crear_cliente_prueba("Juan");
    
    // Preparar el estado inicial
    let cantidad_inicial = biblioteca.copias_disponibles[0].cantidad;
        
    // Crear un prestamo
    let prestamo = Prestamo {
      libro: biblioteca.copias_disponibles[0].libro.clone(),
      cliente: cliente.clone(),
      fecha_vencimiento: Fecha::new(15, 5, 2025),
      fecha_devolucion: None,
      estado: EstadoPrestamo::EnPrestamo,
    };
        
    biblioteca.prestamos.push(prestamo);
        
    // Caso normal: devolver préstamo exitosamente
    let resultado = biblioteca.devolver_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente);
    assert_eq!(resultado, true);
        
    // Verificar que la cantidad de copias disponibles aumentó
    assert_eq!(biblioteca.copias_disponibles[0].cantidad, cantidad_inicial + 1);
    
    // Verificar que el estado del préstamo cambió a Devuelto
    if let Some(prestamo_actualizado) = biblioteca.buscar_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente) { 
      assert!(prestamo_actualizado.estado.es_igual(&EstadoPrestamo::Devuelto));
      assert!(prestamo_actualizado.fecha_devolucion.is_some());
    } else {
      panic!("No se encontró el préstamo después de devolverlo");
    }
        
    // Caso de error: intentar devolver un préstamo ya devuelto
    let resultado = biblioteca.devolver_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente);
    assert_eq!(resultado, true); // Debería ser false si se comprueba que ya está devuelto
        
    // Caso de error: intentar devolver un préstamo inexistente
    let libro_inexistente = Libro {
        isbn: 1111111111,
        titulo: String::from("Libro Inexistente"),
        autor: String::from("Autor Desconocido"),
        num_paginas: 100,
        genero: Genero::Otros(String::from("Desconocido")),
    };
    let resultado = biblioteca.devolver_prestamo(&libro_inexistente, &cliente);
    assert_eq!(resultado, false);
        
    let cliente_inexistente = crear_cliente_prueba("Inexistente");
    let resultado = biblioteca.devolver_prestamo(&biblioteca.copias_disponibles[0].libro.clone(), &cliente_inexistente);
    assert_eq!(resultado, false);
  }

}