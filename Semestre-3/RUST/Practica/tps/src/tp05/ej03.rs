use chrono::Local;
use serde::{Serialize, Deserialize};
use crate::{tp05::fecha::Fecha};
use core::fmt;
use std::{collections::VecDeque, fs::{self, OpenOptions}, io::Write};

#[derive(Debug)]
enum ErrorPersistencia {
  AbrirArchivo,
  LeerArchivo,
  FormatearJson,
  EscribirArchivo,
}

impl fmt::Display for ErrorPersistencia {
  fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    match self {
      ErrorPersistencia::AbrirArchivo => write!(f, "Error al abrir el archivo"),
      ErrorPersistencia::LeerArchivo => write!(f, "Error al leer el archivo"),
      ErrorPersistencia::EscribirArchivo => write!(f, "Error al escribir en el archivo"),
      ErrorPersistencia::FormatearJson => write!(f, "Error al parsear el JSON"),
    }
  }
}


#[derive(Debug, Clone, Serialize, Deserialize)]
enum TipoAnimal {
  Perro,
  Gato,
  Caballo,
  Otros(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Duenio {
  nombre: String,
  direccion: String,
  telefono: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
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

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Atencion {
  mascota: Mascota,
  diagnostico: String,
  tratamiento: String,
  proxima_visita:Option<Fecha>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Veterinaria {
  nombre_vet: String,
  direccion: String,
  id: u32,
  cola: VecDeque<Mascota>,
  atenciones : Vec<Atencion>,
  path_atenciones: String,  // ruta del archivo JSON para atenciones
  path_log: String,
}

impl Veterinaria {
  fn new(nombre_vet: String, direccion: String, id: u32)-> Self{
    Veterinaria {
      nombre_vet,
      direccion,
      id,
      cola: VecDeque::new(),
      atenciones: Vec::new(),
      path_atenciones: "src/tp05/atenciones.json".to_string(),
      path_log: "src/tp05/log_error.txt".to_string(),
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
    self.guardar_atenciones();
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
      self.guardar_atenciones();
    }
  }
  
  fn modificar_fecha_proxima_visita(&mut self, nombre_mascota: &str, nombre_duenio: &str, telefono_duenio: u32, nueva_fecha: Option<Fecha>) {
    if let Some(atencion) = self.buscar_atencion(nombre_mascota, nombre_duenio, telefono_duenio) {
        if let Some(f) =&nueva_fecha{
          if f.es_fecha_valida(){
            atencion.proxima_visita =Some(f.clone());
            self.guardar_atenciones();
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
        self.guardar_atenciones();
          return true
      }
    } 
    false
  }

  fn guardar_atenciones(&self) -> Result<(), ErrorPersistencia> {
    let json = serde_json::to_string(&self.atenciones);
    if let Ok(json_string) = json {
        if let Err(e) = fs::write(&self.path_atenciones, json_string) {
            self.guardar_log(&format!("Error escribiendo archivo JSON: {}", e));
            Err(ErrorPersistencia::EscribirArchivo)
        } else {
            Ok(())
        }
    } else {
        self.guardar_log("Error serializando atenciones a JSON");
        Err(ErrorPersistencia::FormatearJson)
    }
  }

  fn cargar_atenciones(&mut self) -> Result<(), ErrorPersistencia> {
    let contenido = fs::read_to_string(&self.path_atenciones);
    match contenido {
      Ok(texto) => {
        let datos: Result<Vec<Atencion>, _> = serde_json::from_str(&texto);
        match datos {
          Ok(lista) => {
            self.atenciones = lista;
            Ok(()) 
          }
          Err(e) => {
            self.guardar_log(&format!("Error parseando JSON: {}", e));
            Err(ErrorPersistencia::FormatearJson)
          }
        }
      }
      Err(e) => {
        self.guardar_log(&format!("Error leyendo archivo JSON: {}", e));
        Err(ErrorPersistencia::LeerArchivo)
      }
    }
  }
    // como los metodos que implementan cargar en archivo no devuelven un result, debo poner los errores en in archivo de logs
  fn guardar_log(&self, mensaje: &str) {
    if let Ok(mut archivo) = fs::OpenOptions::new()
      .create(true)
      .append(true)
      .open(&self.path_log)
    {
      let _ = writeln!(archivo, "{}", mensaje);
    }
  }
}

#[cfg(test)]
mod tests {


use super::*;
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

  // TEST PARA PERSISTENCIA

  #[test]
  fn test_guardar_cargar_atenciones() {
    use std::fs;
    use std::path::Path;

    // Crear carpeta tests si no existe (solo en test)
    let test_dir = "tests";
    if !Path::new(test_dir).exists() {
        fs::create_dir(test_dir).expect("No se pudo crear la carpeta tests");
    }

    // Instanciamos la veterinaria con paths dentro de tests
    let mut vet = Veterinaria::new("Vet Test".to_string(), "Calle Test 123".to_string(), 1);
    vet.path_atenciones = format!("{}/atenciones_test.json", test_dir);
    vet.path_log = format!("{}/logs_test.log", test_dir);

    // Limpiar archivos antes de test para evitar efectos colaterales
    let _ = fs::remove_file(&vet.path_atenciones);
    let _ = fs::remove_file(&vet.path_log);

    // Crear atención para guardar
    let atencion = Atencion {
        mascota: crear_mascota("Apo", "Nicolas", 123456),
        diagnostico: "Vacunas al día".to_string(),
        tratamiento: "Ninguno".to_string(),
        proxima_visita: None,
    };
    vet.atenciones.push(atencion);

    // Guardar atenciones
    vet.guardar_atenciones();

    // Nueva instancia para cargar
    let mut vet2 = Veterinaria::new("Vet Test".to_string(), "Calle Test 123".to_string(), 1);
    vet2.path_atenciones = format!("{}/atenciones_test.json", test_dir);
    vet2.path_log = format!("{}/logs_test.log", test_dir);

    // Cargar atenciones guardadas
    vet2.cargar_atenciones();

    // Verificamos que cargó la atención
    assert_eq!(vet2.atenciones.len(), 1);

   //limpiar archivos después del test
    let _ = fs::remove_file(&vet.path_atenciones);
    let _ = fs::remove_file(&vet.path_log);
  }

  #[test]
  fn test_guardar_atenciones_error() {
    let mut vet = Veterinaria::new("Vet".into(), "Calle".into(), 1);
    vet.path_atenciones = "/no/existe/archivo.json".into(); // path inválido

    let res = vet.guardar_atenciones();
    assert!(matches!(res, Err(ErrorPersistencia::EscribirArchivo)));
  }

  #[test]
  fn test_cargar_atenciones_error() {
    let mut vet = Veterinaria::new("Vet".into(), "Calle".into(), 1);
    vet.path_atenciones = "/no/existe/archivo.json".into(); // path inválido

    let res = vet.cargar_atenciones();
    assert!(matches!(res, Err(ErrorPersistencia::LeerArchivo)));
  }

  #[test]
  fn test_display_error_persistencia() {
    use super::ErrorPersistencia;

    let abrir = ErrorPersistencia::AbrirArchivo;
    let leer = ErrorPersistencia::LeerArchivo;
    let escribir = ErrorPersistencia::EscribirArchivo;
    let json = ErrorPersistencia::FormatearJson;

    assert_eq!(format!("{}", abrir), "Error al abrir el archivo");
    assert_eq!(format!("{}", leer), "Error al leer el archivo");
    assert_eq!(format!("{}", escribir), "Error al escribir en el archivo");
    assert_eq!(format!("{}", json), "Error al parsear el JSON");
  }
}

