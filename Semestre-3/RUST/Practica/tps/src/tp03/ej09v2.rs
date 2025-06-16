

// 9.-Dada una cadena de veterinarias se desea implementar un sistema de atención de 
// pacientes para cada veterinaria, de la veterinaria se conoce el nombre, la dirección y un id. 
// Para la atención de mascotas se requiere administrar una cola de atención. De la mascota 
// se conoce el nombre, la edad, el tipo de animal(perro, gato, caballo, otros) y su dueño. Del 
// dueño se conoce el nombre, la dirección y un teléfono de contacto. Luego de la atención se 
// desea tener un registro de las atenciones realizadas guardando los datos de la mascota, el 
// diagnóstico final, tratamiento y fecha de la próxima visita si es que se requiere. 
// Dado todo lo mencionado anteriormente implemente los métodos para realizar las 
// siguientes acciones: 
// ➔  crear una veterinaria. 
// ➔  agregar una nueva mascota a la cola de atención de la veterinaria. 
// ➔  agregar una nueva mascota a la cola de atención pero que sea la siguiente 
// en atender porque tiene la máxima prioridad. 
// ➔  atender la próxima mascota de la cola. 
// ➔  eliminar una mascota específica de la cola de atención dado que se retira. 
// ➔  registrar una atención. 
// ➔  buscar una atención dado el nombre de la mascota, el nombre del dueño y el 
// teléfono. 
// ➔  modificar el diagnóstico de una determinada atención. 
// ➔  modificar la fecha de la próxima visita de una determinada atención. 
// ➔  eliminar una determinada atención. 
 
// Nota: para la fecha utilice lo implementado en el punto 3
use crate::tp03::ej03::Fecha;
use std::collections::VecDeque;

#[derive(Debug, Clone)]
enum TipoAnimal {
  Perro,
  Gato,
  Caballo,
  Otros(String),
}

#[derive(Debug, Clone)]
struct Duenio {
  nombre: String,
  direccion: String,
  telefono: u32,
}

#[derive(Debug, Clone)]
struct Mascota {
  nombre: String,
  edad: u32,
  tipo: TipoAnimal,
  duenio: Duenio,
}

impl Mascota {
  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

#[derive(Debug, Clone)]
struct Atencion {
  mascota: Mascota,
  diagnostico: String,
  tratamiento: String,
  proxima_visita:Option<Fecha>,
}
struct Veterinaria {
  nombre_vet: String,
  direccion: String,
  id: u32,
  cola: VecDeque<Mascota>,
  atenciones : Vec<Atencion>
}

impl Veterinaria {
  fn new(nombre_vet: String, direccion: String, id: u32)-> Self{
    Veterinaria {
      nombre_vet,
      direccion,
      id,
      cola: VecDeque::new(),
      atenciones: Vec::new()
    }
  }

  fn agregar_mascota(&mut self, mascota: Mascota){
    self.cola.push_back(mascota);
  }

  fn agregar_mascota_prioridad(&mut self, mascota: Mascota){
    self.cola.push_front(mascota);
  }

  fn atender_proxima_mascota(&mut self)-> Option<Mascota>{
    self.cola.pop_front()
  }

  fn eliminar_mascota(&mut self, nombre_mascota: &str, nombre_duenio: &str)-> bool{

    let posicion = self.encontrar_mascota(nombre_mascota, nombre_duenio);
    if let Some(pos) = posicion {
      self.cola.remove(pos);
      true
    } else {
      false
    }
  }

  fn encontrar_mascota(&self, nombre_mascota: &str, nombre_duenio: &str)-> Option<usize>{
    for i in 0..self.cola.len() {
      if self.cola[i].duenio.nombre.to_lowercase() == nombre_duenio.to_lowercase() && self.cola[i].nombre.to_lowercase() == nombre_mascota.to_lowercase() {
        return Some(i);
      }
    }
    None
  }

  fn registrar_atencion(&mut self, atencion: Atencion){
    self.atenciones.push(atencion);
  }

  fn buscar_atencion(&mut self, nombre_mascota: &str, nombre_duenio: &str, telefono_duenio: u32)-> Option<&mut Atencion>{
    for i in 0..self.atenciones.len() {
      if self.atenciones[i].mascota.duenio.telefono == telefono_duenio &&
        self.atenciones[i].mascota.duenio.nombre.to_lowercase() == nombre_duenio.to_lowercase() &&
        self.atenciones[i].mascota.nombre.to_lowercase() == nombre_mascota.to_lowercase() {
          return Some(&mut self.atenciones[i]);
      }
    }
    None
  }

  fn modificar_diagnostico(&mut self, nombre_mascota: &str, nombre_duenio: &str, telefono_duenio: u32, diagnostico: &str){
    if let Some(atencion) = self.buscar_atencion(nombre_mascota, nombre_duenio, telefono_duenio){
      atencion.diagnostico = diagnostico.to_string();
    }
  }
  
  fn modificar_fecha_proxima_visita(&mut self, nombre_mascota: &str, nombre_duenio: &str, telefono_duenio: u32, nueva_fecha: Option<Fecha>) {
    if let Some(atencion) = self.buscar_atencion(nombre_mascota, nombre_duenio, telefono_duenio) {
        if let Some(f) =&nueva_fecha{
          if f.es_fecha_valida(){
            atencion.proxima_visita =Some(f.clone());
          }
        } else {
          atencion.proxima_visita = None;
        }
    }
  }

  fn eliminar_atencion(&mut self, nombre_mascota: &str, nombre_duenio: &str, telefono_duenio: u32) -> bool {
    for i in 0..self.atenciones.len() {
      if self.atenciones[i].mascota.duenio.telefono == telefono_duenio &&
        self.atenciones[i].mascota.duenio.nombre.to_lowercase() == nombre_duenio.to_lowercase() && 
        self.atenciones[i].mascota.nombre.to_lowercase() == nombre_mascota.to_lowercase(){
        self.atenciones.remove(i);
          return true
      }
    } 
    false
  }
}

#[cfg(test)]
mod tests {


use super::*;
  use crate::tp03::ej03::Fecha;

  fn crear_mascota(nombre: &str,nombre_duenio: &str, telefono_duenio:u32 )-> Mascota{
    Mascota {
      nombre: nombre.to_string(),
      edad: 3,
      tipo: TipoAnimal::Perro,
      duenio : Duenio {
        nombre: nombre_duenio.to_string(),
        direccion: "Una direccion".to_string(),
        telefono: telefono_duenio
      }
    }
  }

  fn crear_atencion(mascota: Mascota) -> Atencion{
    Atencion {
      mascota,
      diagnostico: "Un diagnostico".to_string(),
      tratamiento: "Un tratamiento".to_string(),
      proxima_visita: Some(Fecha::new(17,12,2023))
    }
  }

  fn crear_veterinaria() -> Veterinaria{
    Veterinaria::new("Mi veterinaria".to_string(), "Mi direccion".to_string(), 1)
  }

  #[test]
  fn test_atender_mascota(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Apo", "Nicolas", 123456);
    vet.agregar_mascota(mascota.clone());
    
    let atendida = vet.atender_proxima_mascota();

    // Verificar que atendida sea Some y luego comparar el contenido manualmente
    assert!(atendida.is_some());
    if let Some(m) = atendida {
      assert!(m.eq(&mascota));
    }
    
    assert_eq!(vet.cola.len(), 0);
    
  }

  #[test]
  fn test_atender_mascota_prioridad(){
    let mut vet = crear_veterinaria();
    let normal = crear_mascota("Apo", "Nicolas", 123456);
    let prioridad = crear_mascota("Tato", "Florencia", 12556);
    vet.agregar_mascota_prioridad(prioridad.clone());
    vet.agregar_mascota(normal.clone());
    
    let primero = vet.atender_proxima_mascota();

    assert!(primero.is_some());
    if let Some(m) = primero {
      assert!(m.eq(&prioridad));
      assert!(!m.eq(&normal));
    }

    assert_eq!(vet.cola.len(), 1);
  }

  #[test]
  fn test_eliminar_mascota(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Apo", "Nicolas", 123456);
    vet.agregar_mascota(mascota.clone());
    let eliminada = vet.eliminar_mascota("Apo", "Nicolas");
    assert_eq!(eliminada, true);
    assert_eq!(vet.cola.len(), 0);
  }

  #[test]
  fn test_eliminar_mascota_no_existente(){
    let mut vet = crear_veterinaria(); // veterina con 0 mascotas
    let eliminada = vet.eliminar_mascota("Apo", "Nicolas");
    assert_eq!(eliminada, false);
    assert_eq!(vet.cola.len(), 0);
  }

  #[test]
  fn test_registrar_atencion(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Sombra", "Carlos", 4585);
    let atencion = crear_atencion(mascota.clone()); // se pone clone para que no se borre la mascota
    vet.registrar_atencion(atencion);
    assert_eq!(vet.atenciones.len(), 1);

    
  }

  #[test]
  fn test_buscar_atencion(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Sombra", "Carlos", 4585);

    let atencion = crear_atencion(mascota.clone());
    vet.registrar_atencion(atencion);

    let encontrada = vet.buscar_atencion("Sombra", "Carlos", 4585);
    assert!(encontrada.is_some());

    //atencion que no existe
    let no_encontrada = vet.buscar_atencion("Sombra", "Carlos", 123456);
    assert!(no_encontrada.is_none());
  }

  #[test]
  fn test_modificar_diagnostico(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Sombra", "Carlos", 4585);
    let atencion = crear_atencion(mascota.clone());
    vet.registrar_atencion(atencion);
    vet.modificar_diagnostico("Sombra", "Carlos", 4585, "Curado");
    assert_eq!(vet.atenciones[0].diagnostico, "Curado");

    // se pasan mal los nombres en la funcion y debe fallar
    vet.modificar_diagnostico("Sombraaaa", "Carlos", 4585, "Diagnóstico mal aplicado");
    assert_eq!(vet.atenciones[0].diagnostico, "Curado");
  }

  #[test]
  fn test_modificar_fecha_proxima_visita(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Sombra", "Carlos", 4585);
    let atencion = crear_atencion(mascota.clone());
    vet.registrar_atencion(atencion);

    vet.modificar_fecha_proxima_visita("Sombra", "Carlos", 4585, Some(Fecha::new(15,01,2024)));
    assert!(vet.atenciones[0].proxima_visita.is_some());

    // Suponiendo que no se pasa fecha  
    vet.modificar_fecha_proxima_visita("Sombra", "Carlos", 4585, None);
    assert!(vet.atenciones[0].proxima_visita.is_none());

    //suponiendo fecha invalida
    vet.modificar_fecha_proxima_visita("Sombra", "Carlos", 4585, Some(Fecha::new(32,13,2024)));
    assert!(vet.atenciones[0].proxima_visita.is_none());
    

  }

  #[test]
  fn test_eliminar_atencion(){
    let mut vet = crear_veterinaria();
    let mascota = crear_mascota("Sombra", "Carlos", 4585);
    let mascota2 = crear_mascota("Apo", "Nicolas", 458555);
    
    let atencion = crear_atencion(mascota.clone());
    let atencion2 = crear_atencion(mascota2.clone());
   
    vet.registrar_atencion(atencion);
    vet.registrar_atencion(atencion2);

    let eliminada = vet.eliminar_atencion("Sombra", "Carlos", 4585);
    assert_eq!(eliminada, true);
    assert_eq!(vet.atenciones.len(), 1);

    let eliminada_inexistente = vet.eliminar_atencion("Sombra", "Carlos", 4585);
    assert_eq!(eliminada_inexistente, false);
    assert_eq!(vet.atenciones.len(), 1);
  }

}