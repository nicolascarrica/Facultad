// 8- Defina la estructura Cancion con campos para el título, el artista y el género. El género 
// puede ser rock, pop, rap,  jazz, otros. Luego modele una playlist. La playlist está compuesta 
// por una lista de canciones y un nombre, y se permiten hacer las siguientes acciones sobre 
// ella: 
// ➔  agregar canción. 
// ➔  eliminar canción. 
// ➔  mover canción // mueve la canción a una determinada posición de la playlist. 
// ➔  buscar canción por nombre. 
// ➔  obtener las canciones de un determinado género. 
// ➔  obtener las canciones de un determinado artista. 
// ➔  modificar título de la playlist. 
// ➔  eliminar todas las canciones

#[derive(Debug, Clone)]
enum Genero {
  Rock,
  Pop,
  Rap,
  Jazz,
  Otros,
}

// impl Genero {
//   fn to_string(&self) -> String {
//     match self {
//       Genero::Rock => "Rock".to_string(),
//       Genero::Pop => "Pop".to_string(),
//       Genero::Rap => "Rap".to_string(),
//       Genero::Jazz => "Jazz".to_string(),
//       Genero::Otros => "Otros".to_string(),
//     }
//   }
// }
impl Genero {
  fn to_string(&self) -> String {
    format!("{:?}", self)
  }
  fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }
}

#[derive(Debug, Clone)]
struct Cancion {
  titulo: String,
  artista: String,
  genero: Genero,
}

#[derive(Debug)]
struct Playlist {
  canciones: Vec<Cancion>,
  nombre: String,
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
    }
  }

  fn agregar_cancion(&mut self, cancion: Cancion) {
    self.canciones.push(cancion);
  }

  fn eliminar_cancion(&mut self, titulo: &str) -> bool {
    let posicion = self.encontrar_pos_cancion(titulo);
    if let Some(pos) = posicion {
      self.canciones.remove(pos);
      true
    } else {
      false
    }
  }

  fn encontrar_pos_cancion(&self, titulo: &str) -> Option<usize> {
    self.canciones.iter().position(|c| c.titulo.to_lowercase() == titulo.to_lowercase())
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
      return true;
    } else {
      return false
    }  
  }

  fn buscar_cancion(&self, titulo: &str) -> Option<&Cancion> {
    self.canciones.iter().find(|&c| c.titulo.to_lowercase() == titulo.to_lowercase())
  }

  fn obtener_canciones_por_genero(&self, genero: &Genero) -> Vec<&Cancion> { //&Cancion para no tomar la propiedad
    self.canciones.iter()
    .filter(|c| c.genero.eq(genero)) // filter coleccion las canciones
    .collect()// collect convierte el iterator en un vector
  }

  fn obtener_canciones_por_artista(&self, artista: &str) -> Vec<&Cancion> {
    self.canciones.iter()
    .filter(|c| c.artista.to_lowercase() == artista.to_lowercase())
    .collect()
  }

  fn modificar_titulo(&mut self, nuevo_titulo: &str) {
    self.nombre = nuevo_titulo.to_string();
  }

  fn eliminar_todas_las_canciones(&mut self) {
    self.canciones.clear();
  }

}

#[cfg(test)]
mod tests {
  use std::result;

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









}

