  
  // #[test]
  // fn test_consecionario_archivos(){
  //   let path = "test_autos.json";
  //   std::fs::remove_file(path).ok();

  //   let mut concesionario_archivo = ConcesionarioAuto::new(
  //     String::from("Autitos"),
  //     String::from("Av. Principal"),
  //     3,
  //     path.to_string(),
  //   );

  //   let autos = vec![
  //     Auto::new(
  //       "Marca1".to_string(),
  //       "Modelo1".to_string(),
  //       1998,
  //       800.0,
  //       Color::Amarillo,
  //     ),
  //     Auto::new(
  //       "Marca2".to_string(),
  //       "Modelo2".to_string(),
  //       2020,
  //       1264.0,
  //       Color::Negro,
  //     ),
  //     Auto::new(
  //       "Marca3".to_string(),
  //       "Modelo3".to_string(),
  //       2021,
  //       1032.2,
  //       Color::Blanco,
  //     ),
  //     Auto::new(
  //       "Marca4".to_string(),
  //       "Modelo4".to_string(),
  //       2025,
  //       1443.0,
  //       Color::Rojo,
  //     ),
  //   ];

  //   for a in autos {
  //       match concesionario_archivo.agregar_auto(a) {
  //           Ok(_) => (),
  //           Err(e) => assert_eq!(e, ErrorConcesionario::Capacidad(3)),
  //       }
  //   }

  //   let auto_inexistente = Auto::new(
  //     "fiat uno".to_string(),
  //     "Modelo3".to_string(),
  //     1997,
  //     688.2,
  //     Color::Blanco,
  //   );

  //   assert_eq!(
  //     concesionario_archivo.eliminar_auto(&auto_inexistente),
  //     Err(ErrorConcesionario::AutoNoEncontrado)
  //   );

  //   let file = File::open("test_autos.json");
  //   if let Ok(mut f) = file {
  //       let mut buf = String::new();
  //       if let Err(e) = f.read_to_string(&mut buf) {
  //           panic!("No se pudo leer el archivo: {}", e);
  //       }

  //       let autos: Result<Vec<Auto>, serde_json::Error> = serde_json::from_str(&buf);
  //       match autos {
  //           Ok(a) => {
  //               if let Some(auto) = a.first() {
  //                   assert_eq!(auto.marca, "Marca1");
  //               } else {
  //                   panic!("La lista de autos está vacía");
  //               }
  //           }
  //           Err(e) => panic!("Error al parsear el JSON: {}", e),
  //       }
  //   } else {
  //       panic!("No se pudo abrir el archivo test_files/autos.json");
  //   }

  //   // Reintenta eliminar el auto, debe fallar con AutoNoEncontrado

  //   match concesionario_archivo.eliminar_auto(&auto_inexistente) {
  //       Ok(_) => panic!("El auto no debería existir más"),
  //       Err(e) => assert_eq!(e, ErrorConcesionario::AutoNoEncontrado),
  //   }
  // }
  // #[test]
// fn test_consecionario_archivos() {
//     // Asegura que el archivo de prueba esté limpio antes de comenzar
//     let path = "test_autos.json";
//     std::fs::remove_file(path).ok();

//     let mut concesionario_archivo = ConcesionarioAuto::new(
//         "Autitos".to_string(),
//         "Av. Principal".to_string(),
//         3,
//         path.to_string(),
//     );

//     let autos = vec![
//         Auto::new("Marca1".to_string(), "Modelo1".to_string(), 1988, 1000.0, Color::Amarillo),
//         Auto::new("Marca2".to_string(), "Modelo2".to_string(), 2020, 8764.75, Color::Negro),
//         Auto::new("Marca3".to_string(), "Modelo3".to_string(), 1997, 6432.2, Color::Blanco),
//         Auto::new("Marca4".to_string(), "Modelo4".to_string(), 2008, 1333.33, Color::Rojo), // Este debería fallar por capacidad
//     ];

//     for (i, a) in autos.iter().cloned().enumerate() {
//         let res = concesionario_archivo.agregar_auto(a.clone());
//         if i < 3 {
//             assert!(res.is_ok(), "El auto {} debería agregarse correctamente", i + 1);
//         } else {
//             assert_eq!(res, Err(ErrorConcesionario::Capacidad(3)), "El auto {} debería fallar por capacidad", i + 1);
//         }
//     }

//     // Verifica que el archivo contenga exactamente los 3 autos agregados
//     let contenido = std::fs::read_to_string(path).expect("No se pudo leer el archivo JSON");
//     let autos_en_archivo: Vec<Auto> = serde_json::from_str(&contenido).expect("Error al parsear el JSON");

//     assert_eq!(autos_en_archivo.len(), 3);
//     assert_eq!(autos_en_archivo[0].marca, "Marca1");
//     assert_eq!(autos_en_archivo[1].modelo, "Modelo2");
//     assert_eq!(autos_en_archivo[2].marca, "Marca3");

//     // Intenta eliminar un auto que no está en el archivo
//     let auto_inexistente = Auto::new(
//         "Fiat Uno".to_string(),
//         "ModeloX".to_string(),
//         1997,
//         688.2,
//         Color::Blanco,
//     );

//     assert_eq!(
//         concesionario_archivo.eliminar_auto(&auto_inexistente),
//         Err(ErrorConcesionario::AutoNoEncontrado),
//         "Eliminar un auto inexistente debería devolver AutoNoEncontrado"
//     );

//     // Asegura que los autos originales no hayan sido modificados tras el intento fallido
//     let contenido_final = std::fs::read_to_string(path).expect("No se pudo leer el archivo JSON final");
//     let autos_finales: Vec<Auto> = serde_json::from_str(&contenido_final).expect("Error al parsear el JSON final");

//     assert_eq!(autos_finales.len(), 3, "La cantidad de autos no debería haber cambiado");

//     assert!(concesionario_archivo.buscar_auto(&auto_inexistente).is_none());
//   }


  // #[test]
  // fn test_agregar_auto_falla_en_serializacion() {
  //   struct AutoInvalido; // no implementa Serialize
  //   let mut concesionario = ConcesionarioAuto::new(
  //       "Test".to_string(),
  //       "Direccion".to_string(),
  //       1,
  //       "/ruta/invalida".to_string(), // nombre inválido simula fallo
  //   );
  //   let auto = Auto::new("Marca".to_string(), "Modelo".to_string(), 2000, 5000.0, Color::Negro);
  //   let _ = std::fs::remove_file("/ruta/invalida");
  //   // Esto debería forzar el Err(AgregarEnArchivo)
  //   let res = concesionario.agregar_auto(auto);
  //   assert_eq!(res, Err(ErrorConcesionario::AgregarEnArchivo));
  // }
  // #[test]
  // fn test_eliminar_auto_falla_archivo() {
  //   let mut concesionario = ConcesionarioAuto::new(
  //       "Test".to_string(),
  //       "Direccion".to_string(),
  //       1,
  //       "/ruta/invalida.json".to_string(), // nombre inválido
  //   );
  //   let auto = Auto::new("Marca".to_string(), "Modelo".to_string(), 2000, 5000.0, Color::Negro);
  //   concesionario.autos.push(auto.clone());
  //   let res = concesionario.eliminar_auto(&auto);
  //   assert_eq!(res, Err(ErrorConcesionario::EliminarEnArchivo));
  // }

  // #[test]
  // fn test_buscar_auto_encontrado() {
  //   let auto = Auto::new("Peugeot".to_string(), "208".to_string(), 2022, 17000.0, Color::Verde);
  //   let mut concesionario = ConcesionarioAuto::new(
  //       "Concesionario".to_string(),
  //       "Av. Siempre Viva".to_string(),
  //       5,
  //       "buscar_test.json".to_string(),
  //   );
  //   concesionario.agregar_auto(auto.clone()).unwrap();
    
  // }



//   fn test_consecionario_archivos() {
//     // Asegura que el archivo de prueba esté limpio antes de comenzar
//     let path = "test_autos.json";
//     std::fs::remove_file(path).ok();

//     let mut concesionario_archivo = ConcesionarioAuto::new(
//         "Autitos".to_string(),
//         "Av. Principal".to_string(),
//         3, // capacidad máxima
//         path.to_string(),
//     );

//     let autos = vec![
//         Auto::new("Marca1".to_string(), "Modelo1".to_string(), 1988, 1000.0, Color::Amarillo),
//         Auto::new("Marca2".to_string(), "Modelo2".to_string(), 2020, 8764.75, Color::Negro),
//         Auto::new("Marca3".to_string(), "Modelo3".to_string(), 1997, 6432.2, Color::Blanco),
//         Auto::new("Marca4".to_string(), "Modelo4".to_string(), 2008, 1333.33, Color::Rojo), // Este debería fallar
//     ];

//     for (i, auto) in autos.iter().enumerate() {
//         let resultado = concesionario_archivo.agregar_auto(auto.clone());
//         if i < 3 {
//             assert!(resultado.is_ok(), "El auto {} debería agregarse", i + 1);
//         } else {
//             assert!(resultado.is_err(), "El auto {} debería fallar por capacidad", i + 1);
//             assert_eq!(resultado, Err(ErrorConcesionario::Capacidad(3)));
//         }
//     }

//     // Auto que no existe
//     let auto_inexistente = Auto::new(
//         "MarcaX".to_string(),
//         "ModeloX".to_string(),
//         1990,
//         9999.99,
//         Color::Rojo,
//     );

//     let eliminar_resultado = concesionario_archivo.eliminar_auto(&auto_inexistente);
//     assert_eq!(eliminar_resultado, Err(ErrorConcesionario::AutoNoEncontrado));

//     // Leer el archivo y verificar contenido
//     match File::open(path) {
//         Ok(mut file) => {
//             let mut contenido = String::new();
//             match file.read_to_string(&mut contenido) {
//                 Ok(_) => {
//                     let autos_desde_archivo: Result<Vec<Auto>, _> = serde_json::from_str(&contenido);
//                     match autos_desde_archivo {
//                         Ok(autos_json) => {
//                             assert_eq!(autos_json.len(), 3);
//                             assert_eq!(autos_json[0].marca, "Marca1");
//                         }
//                         Err(e) => panic!("Error al parsear JSON: {}", e),
//                     }
//                 }
//                 Err(e) => panic!("No se pudo leer el archivo: {}", e),
//             }
//         }
//         Err(e) => panic!("No se pudo abrir el archivo: {}", e),
//     }

//     // Reintento de eliminar un auto inexistente (verificación doble)
//     match concesionario_archivo.eliminar_auto(&auto_inexistente) {
//         Ok(_) => panic!("El auto no debería existir y no debería eliminarse"),
//         Err(e) => assert_eq!(e, ErrorConcesionario::AutoNoEncontrado),
//     }
// }












 // fn agregar_auto(&mut self, auto: Auto) -> Result<(), ErrorConcesionario> {
  //   if self.autos.len() < self.capacidad_maxima {
  //     self.autos.push(auto);

  //     let file = OpenOptions::new()
  //       .write(true)
  //       .create(true)
  //       .truncate(true)
  //       .open(&self.path_file);
        
  //       match file {
  //         Ok(mut f) => {
  //           let Ok(a) = serde_json::to_string(&self.autos) else {
  //             return Err(ErrorConcesionario::AgregarEnArchivo);
  //           };

  //           let Ok(_) = f.write_all(&a.as_bytes()) else {
  //             return Err(ErrorConcesionario::AgregarEnArchivo);
  //           };

  //           return Ok(());
  //         }
  //         Err(_) => return Err(ErrorConcesionario::AgregarEnArchivo),
  //       }
  //     }

  //     Err(ErrorConcesionario::Capacidad(self.autos.len() as u32))
    
  // }

  // fn eliminar_auto(&mut self, auto: &Auto) -> Result<(), ErrorConcesionario> {
  //   // Usamos una referencia (&Auto) en lugar del valor completo para no copiar todo el Auto
  //   if let Some(index) = self.autos.iter().position(|a| a.eq(auto)){
  //     self.autos.remove(index);

  //     let file = OpenOptions::new()
  //       .write(true)
  //       .create(true)
  //       .truncate(true)
  //       .open(&self.path_file);
        
  //       match file {
  //         Ok(mut f) => {
  //           let Ok(a) = serde_json::to_string(&self.autos) else {
  //             return Err(ErrorConcesionario::EliminarEnArchivo);
  //           };

  //           let Ok(_) = f.write_all(&a.as_bytes()) else {
  //             return Err(ErrorConcesionario::EliminarEnArchivo);
  //           };

  //           return Ok(());
  //         }
  //         Err(_) => return Err(ErrorConcesionario::EliminarEnArchivo),
            
  //       }

  //   } else {
  //     return Err(ErrorConcesionario::AutoNoEncontrado);
  //   }