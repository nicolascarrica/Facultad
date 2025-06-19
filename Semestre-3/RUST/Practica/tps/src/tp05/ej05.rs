use std::{fmt, fs};
use std::collections::HashMap;
use serde::{Serialize, Deserialize};
use crate::tp05::fecha::Fecha;
use std::mem::discriminant;

#[derive(Debug)]
enum ErrorPlataforma {
    UsuarioYaExiste,
    UsuarioNoEncontrado,
    SinSuscripcion,
    YaEsSuper,
    EscrituraFallida,
    LecturaFallida,
    FormatoInvalido,
}

impl fmt::Display for ErrorPlataforma {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            ErrorPlataforma::UsuarioYaExiste => write!(f, "Ya existe un usuario con ese ID"),
            ErrorPlataforma::UsuarioNoEncontrado => write!(f, "Usuario no encontrado"),
            ErrorPlataforma::SinSuscripcion => write!(f, "El usuario no tiene una suscripción activa"),
            ErrorPlataforma::YaEsSuper => write!(f, "El usuario ya tiene la suscripción Super"),
            ErrorPlataforma::EscrituraFallida => write!(f, "No se pudo escribir el archivo"),
            ErrorPlataforma::LecturaFallida => write!(f, "No se pudo leer el archivo"),
            ErrorPlataforma::FormatoInvalido => write!(f, "El formato del JSON es inválido"),
        }
    }
}

#[derive(Debug, Clone, Eq, Hash, Serialize, Deserialize)]
enum MedioDePago {
    Efectivo,
    MercadoPago {cvu: String},
    TarjetaDeCredito {numero: String, cvv: String},
    TransferenciaBancaria {cbu: String},
    Cripto {direccion: String},
}

impl PartialEq for MedioDePago {
    fn eq(&self, other: &Self) -> bool {
        discriminant(self) == discriminant(other)
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Serialize, Deserialize)]
enum TipoSuscripcion {
    Basic,
    Clasic,
    Super,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Suscripcion {
    tipo: TipoSuscripcion,
    costo_mensual: f32,
    meses: u8,
    inicio: Fecha,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct Usuario {
    id: u32,
    suscripcion: Option<Suscripcion>,
    pago: MedioDePago,
}

impl Usuario { // preferi implementar esto en un struc de usuario, luego desde la plataforma al llamar al usuario aplicarle los metedos corresponditnes.
    fn new(id: u32, suscripcion: Option<Suscripcion>, pago: MedioDePago) -> Self {
        Usuario {
            id,
            suscripcion,
            pago,
        }
    }
}

struct Plataforma {
    usuarios: Vec<Usuario>,
    path: String,
}


impl Plataforma {
    fn new() -> Self {
        Plataforma {
            usuarios: Vec::new(),
            path: "src/tp05/plataforma.json".to_string(),
        }
    }

    fn agregar_usuario(&mut self, id: u32, suscripcion: Option<Suscripcion>, pago: MedioDePago) -> Result<(), ErrorPlataforma> {
        if self.usuarios.iter().any(|u| u.id == id) {
            Err(ErrorPlataforma::UsuarioYaExiste)
        } else {
            self.usuarios.push(Usuario::new(id, suscripcion, pago));
            Ok(())
        }
    }

    fn obtener_usuario(&mut self, id: u32) -> Option<&mut Usuario> {
        self.usuarios.iter_mut().find(|u| u.id == id)
    }

    // Métodos para manejar suscripciones desde la plataforma
    fn upgrade_usuario(&mut self, id: u32) -> Result<(), ErrorPlataforma> {
        let usuario = self.obtener_usuario(id).ok_or(ErrorPlataforma::UsuarioNoEncontrado)?;
        if let Some(ref mut susc) = usuario.suscripcion {
            match susc.tipo {
                TipoSuscripcion::Basic => {
                    susc.tipo = TipoSuscripcion::Clasic;
                    self.guardar_en_json(&self.path)?;
                    Ok(())
                },
                TipoSuscripcion::Clasic => {
                    susc.tipo = TipoSuscripcion::Super;
                    self.guardar_en_json(&self.path)?;
                    Ok(())
                },
                TipoSuscripcion::Super => Err(ErrorPlataforma::YaEsSuper),
            }
        } else {
            Err(ErrorPlataforma::SinSuscripcion)
        }
    }   

    fn downgrade_usuario(&mut self, id: u32) -> Result<(), ErrorPlataforma> {
        let usuario = self.obtener_usuario(id).ok_or(ErrorPlataforma::UsuarioNoEncontrado)?;
        
        if let Some(ref mut susc) = usuario.suscripcion {
            susc.tipo = match susc.tipo {
                TipoSuscripcion::Super => TipoSuscripcion::Clasic,
                TipoSuscripcion::Clasic => TipoSuscripcion::Basic,
                TipoSuscripcion::Basic => {
                    usuario.suscripcion = None;
                    self.guardar_en_json(&self.path)?;
                    return Ok(());
                },
            };
            self.guardar_en_json(&self.path)?;
            Ok(())
        } else {
            Err(ErrorPlataforma::SinSuscripcion)
        }
    }

    fn cancelar_suscripcion_usuario(&mut self, id: u32) -> Result<(), ErrorPlataforma> {
        let usuario = self.obtener_usuario(id).ok_or(ErrorPlataforma::UsuarioNoEncontrado)?;
        
        if usuario.suscripcion.is_some() {
            usuario.suscripcion = None;
            self.guardar_en_json(&self.path)?;
            Ok(())
        } else {
            Err(ErrorPlataforma::SinSuscripcion)
        }
    }


// el uso de hashmap es para poder contar la cantidad de veces que aparece un elemento en un vector.
    fn medio_pago_mas_usado_activo(&self) -> Option<MedioDePago> {
        let mut contador = HashMap::new();
        for usuario in &self.usuarios {
            if usuario.suscripcion.is_some() {
                *contador.entry(usuario.pago.clone()).or_insert(0) += 1;
            }
        }
        contador.into_iter().max_by_key(|(_, v)| *v).map(|(k, _)| k)
    }

    fn suscripcion_activa_mas_contradada(&self) -> Option<TipoSuscripcion> {
        let mut contador = HashMap::new();
        for usuario in &self.usuarios {
            if let Some(susc) = &usuario.suscripcion {
                *contador.entry(susc.tipo.clone()).or_insert(0) += 1;
            }
        }
        contador.into_iter().max_by_key(|(_, v)| *v).map(|(k, _)| k)
    }

    fn medio_pago_mas_usado_total(&self) -> Option<MedioDePago> {
        let mut contador = HashMap::new();
        for user in &self.usuarios {
            *contador.entry(user.pago.clone()).or_insert(0) += 1;
        }
        contador.into_iter().max_by_key(|(_, v)| *v).map(|(k, _)| k)
    }

    fn suscripcion_mas_contratada_total(&self) -> Option<TipoSuscripcion> {
        let mut contador = HashMap::new();
        for user in &self.usuarios {
            if let Some(s) = &user.suscripcion {
                *contador.entry(s.tipo.clone()).or_insert(0) += 1;
            }
        }
        contador.into_iter().max_by_key(|(_, v)| *v).map(|(k, _)| k)
    }

    fn guardar_en_json(&self, path: &str) -> Result<(), ErrorPlataforma> {
        let json = serde_json::to_string_pretty(&self.usuarios).map_err(|_| ErrorPlataforma::FormatoInvalido)?;
        fs::write(path, json).map_err(|_| ErrorPlataforma::EscrituraFallida)?;
        Ok(())
    }

    fn cargar_de_json(&mut self) -> Result<(), ErrorPlataforma> {
        if !std::path::Path::new(&self.path).exists() {
            // Si el archivo no existe, empezamos con una lista vacía
            return Ok(());
        }

        let contenido = fs::read_to_string(&self.path)
            .map_err(|_| ErrorPlataforma::LecturaFallida)?;

        self.usuarios = serde_json::from_str(&contenido)
            .map_err(|_| ErrorPlataforma::FormatoInvalido)?;

        Ok(())
    }

}

#[cfg(test)]
mod test {
    use super::*;
    fn suscripcion_basic() -> Suscripcion {
        Suscripcion {
            tipo: TipoSuscripcion::Basic,
            costo_mensual: 1000.0,
            meses: 3,
            inicio: Fecha::new(22, 05, 2025),
        }
    }

    fn suscripcion_clasic() -> Suscripcion {
        Suscripcion {
            tipo: TipoSuscripcion::Clasic,
            costo_mensual: 2000.0,
            meses: 6,
            inicio: Fecha::new(22, 05, 2025),
        }
    }

    fn suscripcion_super() -> Suscripcion {
        Suscripcion {
            tipo: TipoSuscripcion::Super,
            costo_mensual: 3000.0,
            meses: 12,
            inicio: Fecha::new(22, 05, 2025),
        }
    }

    fn crear_plataforma() -> Plataforma {
        Plataforma { usuarios: (Vec::new()), path: "src/tp05/plataforma.json".to_string() }
    }


    #[test]
    fn test_upgrade() {
        let mut plataforma = crear_plataforma();
        plataforma.agregar_usuario(1, Some(suscripcion_basic()), MedioDePago::Efectivo);
        
        // 1° act Basic → Clasic
        assert!(plataforma.upgrade_usuario(1).is_ok());

        if let Some(usuario) = plataforma.obtener_usuario(1) {
            if let Some(sub) = &usuario.suscripcion {
                assert_eq!(sub.tipo, TipoSuscripcion::Clasic);
            } else {
                panic!("Se esperaba una suscripción Clasic");
            }
        } else {
            panic!("Usuario no encontrado");
        }

        // 2° act Clasic → Super
        assert!(plataforma.upgrade_usuario(1).is_ok());

        if let Some(usuario) = plataforma.obtener_usuario(1) {
            if let Some(sub) = &usuario.suscripcion {
             assert_eq!(sub.tipo, TipoSuscripcion::Super);
            } else {
                panic!("Se esperaba una suscripción Super");
            }
        } else {
            panic!("Usuario no encontrado");
        }

        // 3° act Super → Super
        assert!(plataforma.upgrade_usuario(1).is_err());

    }

    #[test]
    fn test_downgrade() {
        let mut plataforma = crear_plataforma();
        plataforma.agregar_usuario(1, Some(suscripcion_super()), MedioDePago::Efectivo);

        // 1° act Super → clasic
        assert!(plataforma.downgrade_usuario(1).is_ok());

        if let Some(usuario) = plataforma.obtener_usuario(1) {
            if let Some(sub) = &usuario.suscripcion {
                assert_eq!(sub.tipo, TipoSuscripcion::Clasic);
            } else {
                panic!("Se esperaba una suscripción Clasic");
            }
        } else {
            panic!("Usuario no encontrado");
        }

    // 2° downgrade: clasic → absic
        assert!(plataforma.downgrade_usuario(1).is_ok());

        if let Some(usuario) = plataforma.obtener_usuario(1) {
            if let Some(sub) = &usuario.suscripcion {
             assert_eq!(sub.tipo, TipoSuscripcion::Basic);
            } else {
                panic!("Se esperaba una suscripción Basic");
            }
        } else {
            panic!("Usuario no encontrado");
        }

    // 3° downgrade: Basic a nada
        assert!(plataforma.downgrade_usuario(1).is_ok());

        if let Some(usuario) = plataforma.obtener_usuario(1) {
        assert!(usuario.suscripcion.is_none());
        } else {
            panic!("Usuario no encontrado");
        }
    }

    #[test]
    fn test_cancelar_suscripcion() {
        let mut plataforma = crear_plataforma();
        plataforma.agregar_usuario(1, Some(suscripcion_super()), MedioDePago::Efectivo);

        assert!(plataforma.cancelar_suscripcion_usuario(1).is_ok());

        if let Some(mut usuario) =  plataforma.obtener_usuario(1) {
            assert!(usuario.suscripcion.is_none());            
        } else {
            panic!("Usuario no econtrado");
        }     
    }

    #[test]
    fn testar_plataforma(){
        let mut plataforma = crear_plataforma();
        plataforma.agregar_usuario(1, Some(suscripcion_basic()), MedioDePago::Efectivo);
        plataforma.agregar_usuario(2, Some(suscripcion_clasic()), MedioDePago::TarjetaDeCredito { numero: "123".into(), cvv: "123".into() });
        plataforma.agregar_usuario(3, Some(suscripcion_super()), MedioDePago::Efectivo);
        plataforma.agregar_usuario(4, Some(suscripcion_basic()), MedioDePago::Efectivo);
        plataforma.agregar_usuario(5, Some(suscripcion_basic()), MedioDePago::MercadoPago { cvu: "123".into() });

        if let Some(usuario) = plataforma.obtener_usuario(4) {
            if let Some(mpago) = plataforma.medio_pago_mas_usado_activo() {
                assert_eq!(mpago, MedioDePago::Efectivo);
            }

            if let Some(tipo) = plataforma.suscripcion_activa_mas_contradada(){
                assert_eq!(tipo, TipoSuscripcion::Basic);
            }

            if let Some(mpago) = plataforma.medio_pago_mas_usado_total() {
                assert_eq!(mpago, MedioDePago::Efectivo);
            }

            if let Some(tipo) = plataforma.suscripcion_mas_contratada_total(){
                assert_eq!(tipo, TipoSuscripcion::Basic);
            }
            
        } else {
            panic!("Usuario no econtrado");
        }

        

    }

    #[test]
    fn test_plataforma_vacia(){
        let mut plataforma = crear_plataforma();

        assert!(plataforma.medio_pago_mas_usado_activo().is_none());
        assert!(plataforma.suscripcion_activa_mas_contradada().is_none());
        assert!(plataforma.medio_pago_mas_usado_total().is_none());
        assert!(plataforma.suscripcion_mas_contratada_total().is_none());
    }

    #[test]
    fn test_usuario_repetido() {
        let mut plataforma = crear_plataforma();

        let resultado1 = plataforma.agregar_usuario(1, Some(suscripcion_basic()), MedioDePago::Efectivo);
        assert!(resultado1.is_ok());
    
    // Segundo usuario con mismo ID debe fallar
        let resultado2 = plataforma.agregar_usuario(1, Some(suscripcion_clasic()), MedioDePago::TarjetaDeCredito { 
            numero: "123".into(), 
            cvv: "123".into() 
        });
    
        if let Err(mensaje) = resultado2 {
            assert_eq!(mensaje.to_string(), "Ya existe un usuario con ese ID");
        } else {
            panic!("Se esperaba un error pero el resultado fue Ok");
        }
    }

    #[test]
    fn test_nueva_paltaforma() {
        let plataforma = Plataforma::new();
        assert!(plataforma.usuarios.is_empty());
    }

    // Archivos

    #[test]
    fn test_guardar_y_cargar_json() {
        use std::fs;
        use std::path::Path;

        let test_dir = "tests";
        if !Path::new(test_dir).exists() {
            fs::create_dir(test_dir).expect("No se pudo crear la carpeta tests");
        }

        let path_temporal = format!("{}/path_test.json", test_dir);
        let _ = fs::remove_file(&path_temporal); // pasamos referencia para no mover

        // Crear plataforma con archivo temporal
        let mut plataforma = Plataforma {
            usuarios: Vec::new(),
            path: path_temporal.clone(), // clonamos para usar más adelante
        };

        // Agregar usuario
        let usuario = Usuario::new(
            1,
            Some(Suscripcion {
            tipo: TipoSuscripcion::Basic,
            costo_mensual: 100.0,
            meses: 3,
            inicio: Fecha::new(2025, 6, 17),
        }),
        MedioDePago::Efectivo,
        );
        plataforma.usuarios.push(usuario);

        // Guardar en JSON (pasamos la ruta explícitamente)
        assert!(plataforma.guardar_en_json(&path_temporal).is_ok());

        // Crear nueva plataforma con misma ruta
        let mut plataforma_cargada = Plataforma {
            usuarios: Vec::new(),
            path: path_temporal.clone(),
        };
        assert!(plataforma_cargada.cargar_de_json().is_ok());

        // Verificar que se cargó el usuario
        assert_eq!(plataforma_cargada.usuarios.len(), 1);
        assert_eq!(plataforma_cargada.usuarios[0].id, 1);
        assert!(plataforma_cargada.usuarios[0].suscripcion.is_some());
        assert_eq!(plataforma_cargada.usuarios[0].pago, MedioDePago::Efectivo);

        let _ = fs::remove_file(&path_temporal);
    }


     #[test]
     fn test_display_error() {
        use super::ErrorPlataforma;

        let usuario_existente = ErrorPlataforma::UsuarioYaExiste;
        let usuario_no_encontrado = ErrorPlataforma::UsuarioNoEncontrado;
        let sin_suscripcion = ErrorPlataforma::SinSuscripcion;
        let ya_es_super = ErrorPlataforma::YaEsSuper;
        let escritura_fallida = ErrorPlataforma::EscrituraFallida;
        let lectura_fallida = ErrorPlataforma::LecturaFallida;
        let formato_invalido = ErrorPlataforma::FormatoInvalido;


        assert_eq!(format!("{}", usuario_existente), "Ya existe un usuario con ese ID");
        assert_eq!(format!("{}", usuario_no_encontrado), "Usuario no encontrado");
        assert_eq!(format!("{}", sin_suscripcion), "El usuario no tiene una suscripción activa");
        assert_eq!(format!("{}", ya_es_super), "El usuario ya tiene la suscripción Super");
        assert_eq!(format!("{}", escritura_fallida), "No se pudo escribir el archivo");
        assert_eq!(format!("{}", lectura_fallida), "No se pudo leer el archivo");
        assert_eq!(format!("{}", formato_invalido), "El formato del JSON es inválido");
    }

}