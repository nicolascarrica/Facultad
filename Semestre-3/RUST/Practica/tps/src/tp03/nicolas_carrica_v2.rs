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

struct Informe {
  id_estudiante: u32,
  nombre_estudiante: String,
  examenes_rendidos: u32,
  promedio_notas: f32,
  nota_mas_alta: f32,
  materia_mas_alta: String,
  nota_mas_baja: f32,
  materia_mas_baja: String,
}

impl Informe {
  fn new(id_estudiante: u32, nombre_estudiante: String, examenes_rendidos: u32, promedio_notas: f32, nota_mas_alta: f32, materia_mas_alta: String, nota_mas_baja: f32, materia_mas_baja: String) -> Informe{
    Informe {
      id_estudiante,
      nombre_estudiante,
      examenes_rendidos,
      promedio_notas,
      nota_mas_alta,
      materia_mas_alta,
      nota_mas_baja,
      materia_mas_baja
    }

  }
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
  
  fn generar_informe(&self) -> Option<Informe> {
    if self.calificaciones.is_empty() {
      return None
    }

    let promedio = match self.obtener_promedio() {
      Some(valor) => valor,
      None => return None
    };

    
    let mut nota_min: f32 = self.calificaciones[0].nota;
    let mut nota_max: f32 = self.calificaciones[0].nota;

    let mut nombre_materia_max = self.calificaciones[0].nombre_de_materia.clone();
    let mut nombre_materia_min = self.calificaciones[0].nombre_de_materia.clone();
  

    for examen in &self.calificaciones{
      if examen.nota > nota_max {
        nota_max = examen.nota;
        nombre_materia_max = examen.nombre_de_materia.clone();
      }
      if examen.nota < nota_min {
        nota_min = examen.nota;
        nombre_materia_min = examen.nombre_de_materia.clone();
      }
    }

    let informe_est = Informe::new(
      self.id,
      self.nombre_estudiante.clone(),
      self.calificaciones.len() as u32,
      promedio,
      nota_max,
      nombre_materia_max,
      nota_min,
      nombre_materia_min
    );
    

    return Some(informe_est);
    // Agegue el id del estsudiante al informe, me lo habia comido en el examen.
    // en lugar de iniciar el informe con datos vacios y luego asignarlos, inicie el informe con los datos correspondientes luego de obtenerlos.
    // termine de agregar los test al final
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

  #[test]
  fn test_generar_informe(){
    let calificaciones = vec! [
      Examen::new("Matematica".to_string(), 7.0),
      Examen::new("Programcion".to_string(), 8.0),
      Examen::new("Ingles".to_string(), 7.0),
      Examen::new("Seminario Rust".to_string(), 6.0)
    ];
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones
    );

    match estudiante.generar_informe(){
      Some(informe) => {
        assert_eq!(informe.nota_mas_alta, 8.0);
        assert_eq!(informe.nota_mas_baja, 6.0);
        assert_eq!(informe.nombre_estudiante, "Nicolas");
        assert_eq!(informe.id_estudiante, 25458);
        assert_eq!(informe.materia_mas_alta, "Programcion");
        assert_eq!(informe.materia_mas_baja, "Seminario Rust");
        assert_eq!(informe.promedio_notas, 7.0);
        assert_eq!(informe.examenes_rendidos, 4);
      }
      None => panic!("Este informe debería ser None")
    }
     
  }

  #[test]
  fn test_generar_informe_vacio(){
    let calificaciones = Vec::new();
    let estudiante = Estudiante::new(
      "Nicolas".to_string(),
      25458, 
      calificaciones
    );

    let informe_vacio = estudiante.generar_informe();
    assert!(informe_vacio.is_none());
  }

}