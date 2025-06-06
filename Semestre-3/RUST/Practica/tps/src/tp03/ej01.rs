// 1- Escribir un programa que defina una estructura Persona que tenga campos para el
// nombre, la edad y la dirección(que puede ser nulo al momento de la creación de una
// persona). Para dicha estructura implemente los siguientes métodos:
// ➢ new: que pasando los parámetros correspondientes, crea una Persona y la retorna.
// ➢ to_string: que retorna un string con los datos de la persona concatenados sobre el
// mensaje ejecutado por ej:
// person.to_string() , donde person es una variable del tipo Persona.
// ➢ obtener_edad: retorna la edad de la persona.
// ➢ actualizar_direccion(nueva_direccion)


struct Persona {
  nombre: String,
  edad: u32,
  direccion: Option<String>, // La dirección puede ser nula al momento de la creación de una persona.
}

impl Persona {
  fn new (nombre: String, edad: u32, direccion: Option<String>) -> Persona{
    Persona {
      nombre,
      edad,
      direccion,
    }
  }

  fn to_string(&self) -> String {
     let mut result: String = format!("nombre: {}, Edad: {}", self.nombre, self.edad);
     match &self.direccion { //& es para tomar la referencia de la dirección
        Some(dir) => result += &format!(", Direccion: {}", dir),
        None => result += ", Direccion: No especificada",
     }
      result
  }

  fn obtener_edad(&self) -> u32 {
    return self.edad
  }

  fn actualizar_direccion(&mut self, nueva_direccion: String) {
    self.direccion = Some(nueva_direccion);
  }
}

#[cfg(test)]
mod persona_tests {
  use super::Persona;
  #[test]
  fn test_new_persona(){
    let persona = Persona::new(
      "Nicolas".to_string(),
      35,
      Some("Calle 41 682".to_string()),
    );

    assert_eq!(persona.nombre, "Nicolas".to_string());
    assert_eq!(persona.edad, 35);
    assert_eq!(persona.direccion, Some("Calle 41 682".to_string()));

  }

  #[test]
  fn test_new_persona_sin_direccion() {
    let persona = Persona::new(
      "Nicolas Carrica".to_string(),
      35,
      None,
    );
    
    assert_eq!(persona.nombre, "Nicolas Carrica");
    assert_eq!(persona.edad, 35);
    assert_eq!(persona.direccion, None);
  }
  #[test]
  fn test_to_string_con_direccion() {
    let persona = Persona::new(
      "Nico Carrica".to_string(),
      34,
      Some("Calle 119 43".to_string()),
    );
      
    let salida = "nombre: Nico Carrica, Edad: 34, Direccion: Calle 119 43";
    assert_eq!(persona.to_string(), salida);
  }

  #[test]
  fn test_obtener_edad(){
    let persona = Persona {
      nombre: "Nicolas".to_string(),
      edad: 34,
      direccion: None,
    };

    let edad = persona.obtener_edad();
    assert_eq!(edad,34)
  }
  #[test]
  fn test_actualizar_direccion_none(){
    let mut persona = Persona {
      nombre: "Nicolas".to_string(),
      edad: 34,
      direccion: None,
    };
    persona.actualizar_direccion("Calle 119".to_string());

    assert_eq!(persona.direccion, Some("Calle 119".to_string()));
  }

  #[test]
  fn test_actualizar_direccion_existente(){
    let mut persona = Persona {
      nombre: "Nicolas".to_string(),
      edad:34,
      direccion: Some("Calle 41".to_string()),
    };

    persona.actualizar_direccion("Calle 119".to_string());
    assert_eq!(persona.direccion, Some("Calle 119".to_string()));
  }


 
}
