// 3 -La plataforma de streaming "StreamingRust" ofrece distintos tipos de suscripciones 
// (Basic, Clasic, Super) a sus usuarios. Cada suscripción tiene un costo mensual y una 
// duración de meses y una fecha de inicio, además los usuarios pueden pagar por sus 
// suscripciones con distintos medios de pago que son Efectivo, MercadoPago, Tarjeta de 
// Crédito, Transferencia Bancaria, Cripto. Cada medio de pago tiene sus datos 
// correspondientes a excepción de Efectivo. 
// Los usuarios solo pueden tener una suscripción activa a la vez. 
 
// Implemente las estructuras, funciones asociadas y traits necesarios para resolver las 
// siguientes acciones: 
 
// ➢  Crear un usuario con una determinada suscripción y medio de pago. 
// ➢  Dado un usuario hacer un upgrade sobre la suscripción. Es decir si está a Basic 
// pasa a Clasic y si está en Clasic pasa a Super. 
// ➢  Dado un determinado usuario, hacer un downgrade sobre una suscripción, si la 
// suscripción es del tipo Basic al hacerlo se cancelará la suscripción. 
// ➢  Dado un usuario cancelar la suscripción. 
// ➢  Saber el medio de pago que es más utilizado por los usuarios sobre las 
// suscripciones activas 
// ➢  Saber cual es la suscripción más contratada por los usuarios sobre las suscripciones 
// activas. 
// ➢  Saber cuál fue el medio de pago más utilizado. 
// ➢  Saber cuál fue la suscripción más contratada.
use std::collections::HashMap;

use crate::tp03::ej03::Fecha;
use std::mem::discriminant;
#[derive(Debug, Clone, Eq, Hash)]
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

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
enum TipoSuscripcion {
    Basic,
    Clasic,
    Super,
}

#[derive(Debug, Clone)]
struct Suscripcion {
    tipo: TipoSuscripcion,
    costo_mensual: f32,
    meses: u8,
    inicio: Fecha,
}
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
}


impl Plataforma {
    fn new() -> Self {
        Plataforma {
            usuarios: Vec::new(),
        }
    }

    fn agregar_usuario(&mut self, id: u32, suscripcion: Option<Suscripcion>, pago: MedioDePago) -> Result<(), String> {
        if self.usuarios.iter().any(|u| u.id == id) {
            Err(format!("Ya existe un usuario con el ID {}", id))
        } else {
            self.usuarios.push(Usuario::new(id, suscripcion, pago));
            Ok(())
        }
    }

    fn obtener_usuario(&mut self, id: u32) -> Option<&mut Usuario> {
        self.usuarios.iter_mut().find(|u| u.id == id)
    }

    // Métodos para manejar suscripciones desde la plataforma
    fn upgrade_usuario(&mut self, id: u32) -> Result<(), String> {
        let usuario = self.obtener_usuario(id).ok_or("Usuario no encontrado")?;

        if let Some(ref mut susc) = usuario.suscripcion {
            match susc.tipo {
                TipoSuscripcion::Basic => {
                    susc.tipo = TipoSuscripcion::Clasic;
                    Ok(())
                },
                TipoSuscripcion::Clasic => {
                    susc.tipo = TipoSuscripcion::Super;
                    Ok(())
                },
                TipoSuscripcion::Super => Err(format!("El usuario {} ya tiene la suscripción Super (máxima)", id)),
            }
        } else {
            Err(format!("El usuario {} no tiene suscripción activa para hacer upgrade", id))
        }
    }   

    fn downgrade_usuario(&mut self, id: u32) -> Result<(), String> {
        let usuario = self.obtener_usuario(id).ok_or("Usuario no encontrado")?;
        
        if let Some(ref mut susc) = usuario.suscripcion {
            susc.tipo = match susc.tipo {
                TipoSuscripcion::Super => TipoSuscripcion::Clasic,
                TipoSuscripcion::Clasic => TipoSuscripcion::Basic,
                TipoSuscripcion::Basic => {
                    usuario.suscripcion = None;
                    return Ok(());
                },
            };
            Ok(())
        } else {
            Err(format!("El usuario {} no tiene suscripción activa para hacer downgrade", id))
        }
    }

    fn cancelar_suscripcion_usuario(&mut self, id: u32) -> Result<(), String> {
        let usuario = self.obtener_usuario(id).ok_or("Usuario no encontrado")?;
        
        if usuario.suscripcion.is_some() {
            usuario.suscripcion = None;
            Ok(())
        } else {
            Err(format!("El usuario {} no tiene suscripción activa para cancelar", id))
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

    #[test]
    fn test_upgrade() {
        let mut plataforma = Plataforma::new();
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
        let mut plataforma = Plataforma::new();
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
        let mut plataforma = Plataforma::new();
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
        let mut plataforma = Plataforma::new();
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
        let plataforma = Plataforma::new();

        assert!(plataforma.medio_pago_mas_usado_activo().is_none());
        assert!(plataforma.suscripcion_activa_mas_contradada().is_none());
        assert!(plataforma.medio_pago_mas_usado_total().is_none());
        assert!(plataforma.suscripcion_mas_contratada_total().is_none());
    }

    #[test]
    fn test_usuario_repetido() {
        let mut plataforma = Plataforma::new();
    
    
        let resultado1 = plataforma.agregar_usuario(1, Some(suscripcion_basic()), MedioDePago::Efectivo);
        assert!(resultado1.is_ok());
    
    // Segundo usuario con mismo ID debe fallar
        let resultado2 = plataforma.agregar_usuario(1, Some(suscripcion_clasic()), MedioDePago::TarjetaDeCredito { 
            numero: "123".into(), 
            cvv: "123".into() 
        });
    
        if let Err(mensaje) = resultado2 {
            assert_eq!(mensaje, "Ya existe un usuario con el ID 1");
        } else {
            panic!("Se esperaba un error pero el resultado fue Ok");
        }
    }

}
