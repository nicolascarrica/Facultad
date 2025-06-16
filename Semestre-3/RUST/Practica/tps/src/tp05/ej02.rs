use core::fmt;
use std::{fs, io::Write};

use serde::{Deserialize, Serialize};

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

#[derive(Serialize, Deserialize,Debug, Clone)]
enum Genero {
  Rock,
  Pop,
  Rap,
  Jazz,
  Otros,
}

impl Genero {
  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

#[derive(Serialize, Deserialize,Debug, Clone)]
struct Cancion {
  titulo: String,
  artista: String,
  genero: Genero,
}

#[derive(Serialize, Deserialize,Debug)]
struct Playlist {
  canciones: Vec<Cancion>,
  nombre: String,
  path_playlist: String,
  path_logs: String,
}

impl Cancion {
  fn new(titulo: String, artista: String, genero: Genero) -> Cancion {
    Cancion {
      titulo,
      artista,
      genero,
    }
  }

  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

impl Playlist {
  fn new(nombre: String) -> Playlist {
    Playlist {
      canciones: Vec::new(),
      nombre,
      path_playlist: "src/tp05/playlist.json".to_string(),
      path_logs: "src/tp05/log_error_ej02.txt".to_string(),
    }
  }

  fn agregar_cancion(&mut self, cancion: Cancion) {
    self.canciones.push(cancion);
    self.guardar_en_archivo();
  }

  fn eliminar_cancion(&mut self, titulo: &str) -> bool {
    let posicion = self.encontrar_pos_cancion(titulo);
    if let Some(pos) = posicion {
      self.canciones.remove(pos);
      self.guardar_en_archivo();
      true
    } else {
      false
    }
  }

  fn encontrar_pos_cancion(&self, titulo: &str) -> Option<usize> {
    for i in 0..self.canciones.len() {
      if self.canciones[i].titulo.to_lowercase() == titulo.to_lowercase() {
        return Some(i);

      }
    }
    None
  }

  fn mover_cancion(&mut self, titulo: &str, nueva_posicion: usize) -> bool {
    if nueva_posicion >= self.canciones.len() {
      return false;
    }

    let posicion_actual = self.encontrar_pos_cancion(titulo);
    if let Some (pos) = posicion_actual {
      if pos == nueva_posicion {
        return true; // no hacer nada
      }

      let cancion = self.canciones.remove(pos);
      self.canciones.insert(nueva_posicion, cancion);
      self.guardar_en_archivo();
      return true;
    } else {
      return false
    }  
  }

  fn buscar_cancion(&self, titulo: &str) -> Option<&Cancion> {
    for i in 0..self.canciones.len() {
      if self.canciones[i].titulo.to_lowercase() == titulo.to_lowercase() {
        return Some(&self.canciones[i]);
      }
    }
    None
  }

  fn obtener_canciones_por_genero(&self, genero: &Genero) -> Vec<&Cancion> { //&Cancion para no tomar la propiedad
    let mut canciones_filtradas = Vec::new();
    
    for cancion in &self.canciones {
      if cancion.genero.eq(genero) {
        canciones_filtradas.push(cancion);
      }
    }
    
    canciones_filtradas
  }

  fn obtener_canciones_por_artista(&self, artista: &str) -> Vec<&Cancion> {
    let mut canciones_filtradas = Vec::new();
    
    for cancion in &self.canciones {
      if cancion.artista.to_lowercase() == artista.to_lowercase() {
        canciones_filtradas.push(cancion);
      }
    }
    
    canciones_filtradas
  }

  fn modificar_titulo(&mut self, nuevo_titulo: &str) {
    self.nombre = nuevo_titulo.to_string();
    self.guardar_en_archivo();
  }

  fn eliminar_todas_las_canciones(&mut self) {
    self.canciones.clear();
    self.guardar_en_archivo();
  }

  fn guardar_en_archivo(&self) -> Result<(), ErrorPersistencia> {
    let json = serde_json::to_string(&self.canciones);
    if let Ok(json_string) = json {
        if let Err(e) = fs::write(&self.path_playlist, json_string) {
            self.guardar_log(&format!("Error escribiendo archivo JSON: {}", e));
            Err(ErrorPersistencia::EscribirArchivo)
        } else {
            Ok(())
        }
    } else {
        self.guardar_log("Error serializando canciones a JSON");
        Err(ErrorPersistencia::FormatearJson)
    }
  }


  fn cargar_desde_archivo(&mut self) -> Result<(), ErrorPersistencia>{
    let contenido = fs::read_to_string(&self.path_playlist);
    match contenido {
      Ok(texto) => {
        let datos: Result<Vec<Cancion>, _> = serde_json::from_str(&texto);
        match datos {
          Ok(lista) => {
            self.canciones = lista;
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

  fn guardar_log(&self, mensaje: &str) {
    if let Ok(mut archivo) = fs::OpenOptions::new()
      .create(true)
      .append(true)
      .open(&self.path_logs)
    {
      let _ = writeln!(archivo, "{}", mensaje);
    }
  }

}

#[cfg(test)]
mod tests {

use super::*;

  fn crear_playlist_test() -> Playlist {
    let mut playlist = Playlist::new("Mi Playlist".to_string());

    playlist.agregar_cancion(Cancion::new(
      "Champangne Supernova".to_string(),
      "Oasis".to_string(),
      Genero::Rock
    ));

    playlist.agregar_cancion(Cancion::new(
      "Blank Space".to_string(),
      "Taylor Swift".to_string(),
      Genero::Pop
    ));

    playlist.agregar_cancion(Cancion::new(
      "Stand by me".to_string(),
      "Oasis".to_string(),
      Genero::Rock
    ));

    playlist

  }

  #[test]
  fn test_crear_playlist() {
    let playlist = Playlist::new("Mi Playlist".to_string());
    assert_eq!(playlist.nombre, "Mi Playlist");
    assert_eq!(playlist.canciones.len(), 0);
  }

  #[test]
  fn test_agregar_cancion() {
    let mut playlist = Playlist::new("Mi Playlist".to_string());
    let cancion = Cancion::new(
      "Live forever".to_string(),
      "Oasis".to_string(),
      Genero::Rock
    );

    playlist.agregar_cancion(cancion.clone());
    assert_eq!(playlist.canciones.len(), 1);
    assert!(playlist.canciones[0].eq(&cancion));
  }

  #[test]
  fn eliminar_cancion_existente() {
    let mut playlist = crear_playlist_test();
    let resultado = playlist.eliminar_cancion("Blank Space");
    assert_eq!(resultado, true);
    assert_eq!(playlist.canciones.len(), 2);
    assert!(playlist.buscar_cancion("Blank Space").is_none());
  }

  #[test]
  fn eliminar_cancion_inexistente() {
    let mut playlist = crear_playlist_test();
    let resultado = playlist.eliminar_cancion("Cancion Inexistente");
    assert_eq!(resultado, false);
    assert_eq!(playlist.canciones.len(), 3);
  }

  #[test]
  fn test_mover_cancion_caso_normal() {
    let mut playlist = crear_playlist_test();
        
    // Mover "Stand by me" (índice 2) a la posición 0
    let result = playlist.mover_cancion("Stand by me", 0);
        
    assert!(result);
    assert_eq!(playlist.canciones[0].titulo, "Stand by me");
    assert_eq!(playlist.canciones[1].titulo, "Champangne Supernova");
    assert_eq!(playlist.canciones[2].titulo, "Blank Space");
  }

  #[test]
  fn test_mover_cancion_misma_posicion() {
    let mut playlist = crear_playlist_test();
    
    // Mover "Blank Space" (índice 1) a la posición 1 (no debería cambiar)
    let result = playlist.mover_cancion("Blank Space", 1);
    
    assert!(result);
    assert_eq!(playlist.canciones[0].titulo, "Champangne Supernova");
    assert_eq!(playlist.canciones[1].titulo, "Blank Space");
    assert_eq!(playlist.canciones[2].titulo, "Stand by me");
  }

  #[test]
  fn test_mover_cancion_posicion_invalida() {
    let mut playlist = crear_playlist_test();
    
    // Intentar mover a una posición fuera de rango
    let result = playlist.mover_cancion("Blank Space", 10);
    
    assert!(!result);
    // Verificar que el orden no cambió
    assert_eq!(playlist.canciones[1].titulo, "Blank Space");
  }

  #[test]
  fn test_mover_cancion_inexistente() {
    let mut playlist = crear_playlist_test();
    
    let result = playlist.mover_cancion("Canción Inexistente", 0);
    
    assert!(!result);
  }

  #[test]
  fn test_buscar_cancion_existente_case_insensitive() {
    let playlist = crear_playlist_test();
      
    // Buscar con diferente capitalización
    let cancion = playlist.buscar_cancion("blank Space");
      
    assert!(cancion.is_some());
    assert_eq!(cancion.unwrap().titulo, "Blank Space");
  }

  #[test]
  fn test_buscar_cancion_inexistente() {
    let playlist = crear_playlist_test();
      
    let cancion = playlist.buscar_cancion("Canción Inexistente");
      
    assert!(cancion.is_none());
  }

  #[test]
  fn test_canciones_por_genero() {
    let mut playlist = crear_playlist_test();
        
     // Agregamos otra canción de rock
    playlist.agregar_cancion(Cancion::new(
      "We Will Rock You".to_string(),
      "Queen".to_string(),
      Genero::Rock
    ));
        
    let canciones_rock = playlist.obtener_canciones_por_genero(&Genero::Rock);
        
    assert_eq!(canciones_rock.len(), 3);
    assert_eq!(canciones_rock[0].titulo, "Champangne Supernova");
    assert_eq!(canciones_rock[1].titulo, "Stand by me");
    assert_eq!(canciones_rock[2].titulo, "We Will Rock You");
        
    // Género sin canciones
    let canciones_jazz = playlist.obtener_canciones_por_genero(&Genero::Jazz);
    assert_eq!(canciones_jazz.len(), 0);
  }

  #[test]
  fn test_canciones_por_artista() {
    let playlist = crear_playlist_test();
        
    let canciones_oasis = playlist.obtener_canciones_por_artista("Oasis");
        
    assert_eq!(canciones_oasis.len(), 2);
    assert_eq!(canciones_oasis[0].titulo, "Champangne Supernova");
    assert_eq!(canciones_oasis[1].titulo, "Stand by me");

    // Artista sin Canciones
    let canciones_lipa = playlist.obtener_canciones_por_artista("Dua Lipa");
    assert_eq!(canciones_lipa.len(), 0);
  }

  #[test]
  fn test_modificar_titulo() {
    let mut playlist = crear_playlist_test();
    playlist.modificar_titulo("Mi Playlist Modificada");
    assert_eq!(playlist.nombre, "Mi Playlist Modificada");
  }

  // Tests para playlist vacía
  #[test]
  fn test_operaciones_en_playlist_vacia() {
    let mut playlist = Playlist::new("Playlist Vacía".to_string());
      
    // Intentar eliminar de una playlist vacía
    let result = playlist.eliminar_cancion("Cualquier Canción");
    assert!(!result);
      
      // Intentar mover en una playlist vacía
    let result = playlist.mover_cancion("Cualquier Canción", 0);
    assert!(!result);
      
    // Buscar en una playlist vacía
    assert!(playlist.buscar_cancion("Cualquier Canción").is_none());
      
    // Filtrar por género en una playlist vacía
    assert_eq!(playlist.obtener_canciones_por_genero(&Genero::Rock).len(), 0);
      
    // Filtrar por artista en una playlist vacía
    assert_eq!(playlist.obtener_canciones_por_artista("Cualquier Artista").len(), 0);
      
    // Eliminar todas las canciones de una playlist vacía
    playlist.eliminar_todas_las_canciones();
    assert_eq!(playlist.canciones.len(), 0);
  }

  // TEST PARA PERSITNECIA

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

  #[test]
  fn test_guardar_cargar_atenciones() {
    use std::fs;
    use std::path::Path;

    // Crear carpeta tests si no existe (solo en test)
    let test_dir = "tests";
    if !Path::new(test_dir).exists() {
        fs::create_dir(test_dir).expect("No se pudo crear la carpeta tests");
    }

    // Instacio la Playlist con paths dentro de tests
    let mut playlist = Playlist::new("Mi Playlist".to_string());
    playlist.path_playlist = format!("{}/canciones_test.json", test_dir);
    playlist.path_logs = format!("{}/logs_test.log", test_dir);

    // Limpiar archivos antes de test para evitar efectos colaterales
    let _ = fs::remove_file(&playlist.path_playlist);
    let _ = fs::remove_file(&playlist.path_logs);

    let cancion1 = Cancion::new("Cancion 1".to_string(), "Artista 1".to_string(), Genero::Rock);
    let cancion2 = Cancion::new("Cancion 2".to_string(), "Artista 2".to_string(), Genero::Pop);
    let cancion3 = Cancion::new("Cancion 3".to_string(), "Artista 3".to_string(), Genero::Rock);

    playlist.canciones.push(cancion1);
    playlist.canciones.push(cancion2);
    playlist.canciones.push(cancion3);

    playlist.guardar_en_archivo();

    if let Ok(_) = Playlist::cargar_desde_archivo(&mut playlist) {
      assert_eq!(playlist.canciones.len(), 3);
      assert_eq!(playlist.canciones[0].titulo, "Cancion 1");
      assert_eq!(playlist.canciones[1].titulo, "Cancion 2");
      assert_eq!(playlist.canciones[2].titulo, "Cancion 3");
    } else {
      panic!("Error cargando la playlist");
    }

    let _ = fs::remove_file(&playlist.path_playlist);
    let _ = fs::remove_file(&playlist.path_logs);
  }

  #[test]
  fn test_guardar_atenciones_error() {
    let mut playlist = Playlist::new("Mi Playlist".to_string());
    playlist.path_playlist = "/no/existe/archivo.json".into(); // path inválido

    let res = playlist.guardar_en_archivo();
    assert!(matches!(res, Err(ErrorPersistencia::EscribirArchivo)));
  }

  #[test]
  fn test_cargar_atenciones_error() {
    let mut playlist = Playlist::new("Mi Playlist".to_string());
    playlist.path_playlist = "/no/existe/archivo.json".into(); // path inválido

    let res = playlist.cargar_desde_archivo();
    assert!(matches!(res, Err(ErrorPersistencia::LeerArchivo)));
  }
}

