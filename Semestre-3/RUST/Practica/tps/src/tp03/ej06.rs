// Escribir un programa que defina una estructura Estudiante que tenga campos para el 
// nombre, el número de identificación y las calificaciones de exámenes. De cada Examen se 
// conoce el nombre de la materia y la nota. Para dichas estructuras implemente los siguientes 
// métodos: 
 
// ❖  Examen: 
// ➢  new: que pasando los parámetros correspondientes, crea un Examen y lo 
// retorna. 
// ❖  Estudiante: 
// ➢  new: que pasando los parámetros correspondientes, crea un Estudiante y lo 
// retorna. 
// ➢  obtener_promedio: retorna el promedio de las notas. 
// ➢  obtener_calificacion_mas_alta: retorna la nota más alta. 
// ➢  obtener_calificacion_mas_baja: retorna la nota más baja. 
 
// Nota: Tenga en cuenta que el Estudiante puede tener entre 0 y n notas de examen.

struct Examen {
  nombre_de_materia: String,
  nota: f32,
}

impl Examen {
  fn new (nombre_de_materia: String, nota: f32) -> Examen{
    Examen {
      nombre_de_materia,
      nota,
    }
  }
} 
struct Estudiante{
  nombre_estudiante: String,
  id: u32,
  calificaciones: Vec<Examen>
}

impl Estudiante{
  fn new(nombre_estudiante: String, id: u32, calificaciones: Vec<Examen>)-> Estudiante {
    Estudiante{
      nombre_estudiante,
      id,
      calificaciones,
    }
  }

  fn obtener_promedio(&self) -> Option<f32> {
    if self.calificaciones.is_empty() {
      return None;
    }
    let mut suma: f32 = 0.0;
    for examen in &self.calificaciones{
      suma+=examen.nota;
    }
    let dim_f = self.calificaciones.len();
    Some(suma/dim_f as f32)
  }

  fn obtener_calificacion_mas_alta(&self) -> Option<f32> {
    
    if self.calificaciones.is_empty() {
      return None;
    }
    let mut max:f32 = self.calificaciones[0].nota;
    for examen in &self.calificaciones{
      if examen.nota > max {
        max = examen.nota;
      }
    }
    return Some(max);
  }

  fn obtener_calificacion_mas_baja(&self) -> Option<f32> {
    if self.calificaciones.is_empty() {
      return None;
    }
    let mut min:f32 = self.calificaciones[0].nota;
    for examen in &self.calificaciones{
      if examen.nota < min {
        min = examen.nota;
      }
    }
    return Some(min);
  }
    
}

#[cfg(test)]
mod estudiante_tests{
  use super::*;
  #[test]
  fn test_new(){
    let calificaciones = vec! [
      Examen::new("Matematica".to_string(), 7.0),
      Examen::new("Programcion".to_string(), 8.0),
      Examen::new("Ingles".to_string(), 7.0)
    ];
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones,
    );

    assert_eq!(estudiante.nombre_estudiante, "Nicolas");
    assert_eq!(estudiante.id, 25458);
    assert_eq!(estudiante.calificaciones.len(), 3);
  }

  #[test]
  fn test_obtener_promedio(){
    let calificaciones = vec! [
      Examen::new("Matematica".to_string(), 7.0),
      Examen::new("Programcion".to_string(), 7.0),
      Examen::new("Ingles".to_string(), 7.0)
    ];
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones
    );

    assert_eq!(estudiante.obtener_promedio(), Some(7.0));

    //caso vector vacio

    let est2 = Estudiante::new(
      "Nicolas".to_string(),
      67890,
      Vec::new()
    );
    assert_eq!(est2.obtener_promedio(),None);
  }

  #[test]
  fn test_obtener_calificacion_mas_alta(){
    let calificaciones = vec! [
      Examen::new("Matematica".to_string(), 8.0),
      Examen::new("Programcion".to_string(), 7.0),
      Examen::new("Ingles".to_string(), 7.0)
    ];
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones
    );

    assert_eq!(estudiante.obtener_calificacion_mas_alta(), Some(8.0));

    let est2 = Estudiante::new(
      "Nicolas".to_string(),
      67890,
      Vec::new()
    );
    assert_eq!(est2.obtener_calificacion_mas_alta(), None);
  }

  #[test]
  fn test_obtener_calificacion_mas_baja(){
    let calificaciones = vec! [
      Examen::new("Matematica".to_string(), 5.0),
      Examen::new("Programcion".to_string(), 9.0),
      Examen::new("Ingles".to_string(), 7.0)
    ];
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones
    );

    assert_eq!(estudiante.obtener_calificacion_mas_baja(), Some(5.0));

    let est2 = Estudiante::new(
      "Nicolas".to_string(),
      67890,
      Vec::new()
    );
    assert_eq!(est2.obtener_calificacion_mas_baja(), None);
  }

}