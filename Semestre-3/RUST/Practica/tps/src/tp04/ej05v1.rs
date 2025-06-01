use std::{borrow::Borrow, cmp::Ordering, collections::HashMap};
use rand::prelude::*;
use chrono::prelude::*;

use crate::tp03::ej03::Fecha;

trait Validador {
    fn validar(&mut self) -> bool;
    fn esta_validado(&self) -> bool;
}

trait Financiero {
    fn agregar_fiat(&mut self, monto: f64);
    fn debitar_fiat(&mut self, monto: f64) -> bool;
    fn tiene_balance_cripto(&self, cripto: &Prefijo, monto: f64) -> bool;
    fn agregar_cripto(&mut self, cripto: &Prefijo, monto: f64);
    fn debitar_cripto(&mut self, cripto: &Prefijo, monto: f64) -> bool;
}


#[derive(Clone, PartialEq)]
struct Blockchain {
    nombre: String,
    prefijo: String,
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub enum Prefijo {
    BTC,
    ETH,
    SOL, 
    DODGE,
    XLM, 
    USDT,
}

#[derive(Clone)]
pub struct CriptoMoneda {
    valor: f64,
    blockchains: Vec<Blockchain>
}

#[derive(Clone, Debug)]
struct Usuario {
    nombre: String,
    apellido: String,
    email: String,
    dni: String,
    validado: bool,
    fiat: f64,
    balances: HashMap<Prefijo, f64>
}

#[derive(Debug)]
pub enum Medio {
    MercadoPago,
    TransferenciaBancaria
}

#[derive(Debug)]
enum Transaccion {
    IngresoDinero { fecha: Fecha, dni: String, monto: f64 },
    CompraCripto { fecha: Fecha, dni: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    VentaCripto { fecha: Fecha, dni: String, cripto: Prefijo, cotizacion: f64, monto: f64 },
    RetiroCripto { fecha: Fecha, dni: String, blockchain: String, hash: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    RecepcionCripto { fecha: Fecha, dni: String, blockchain: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    RetiroFiat { fecha: Fecha, dni: String, monto: f64, medio: Medio } // Cotizacion esta dentro de cripto
}

pub struct XYZ {
    usuarios: Vec<Usuario>,
    transacciones: Vec<Transaccion>
}

fn get_fecha_actual() -> Fecha {
    let actual: DateTime<Utc> = Utc::now(); 
    Fecha::new(actual.day(), actual.month(), actual.year() as u32)
}

impl Validador for Usuario {
  fn validar(&mut self) -> bool {
    if !self.validado {
      self.validado = true;
      true
    } else {
      false 
    }
  }

  fn esta_validado(&self) -> bool {
    self.validado
  }
}

impl Financiero for Usuario {
    fn agregar_fiat(&mut self, monto: f64) {
        self.fiat += monto;
    }

    fn debitar_fiat(&mut self, monto: f64) -> bool {
        if self.fiat >= monto {
            self.fiat -= monto;
            true
        } else {
            false
        }
    }

    fn tiene_balance_cripto(&self, cripto: &Prefijo, monto: f64) -> bool {
        if let Some(b) = self.balances.get(cripto) {
            *b >= monto
        } else {
            false
        }
    }

    fn agregar_cripto(&mut self, cripto: &Prefijo, monto: f64) {
        if let Some(b) = self.balances.get_mut(cripto) {
            *b += monto;
        } else {
            self.balances.insert(cripto.clone(), monto);
        }
    }

    fn debitar_cripto(&mut self, cripto: &Prefijo, monto: f64) -> bool {
        if let Some(b) = self.balances.get_mut(cripto) {
            if *b >= monto {
                *b -= monto;
                true
            } else {
                false
            }
        } else {
            false
        }
    }
}

impl XYZ {
    pub fn new() -> XYZ {
        XYZ {
            usuarios: Vec::new(),
            transacciones: Vec::new()
        }
    }

    pub fn crear_usuario(&mut self, nombre: String, apellido: String, email: String, dni: String) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if user.is_some() {
            false // Usuario ya existe
        } else {
            self.usuarios.push(Usuario::new(nombre, apellido, email, dni));
            true
        }
    }

    fn validar_usuario(&mut self, dni: String) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            u.validar();
            true
        } else {
            false
        }
    }

    pub fn ingresar_dinero(&mut self, dni: String, monto: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);
        
        if let Some(u) = user {
            if !u.validado {
               return false // No esta validado
            }

            u.agregar_fiat(monto);
            self.transacciones.push(Transaccion::IngresoDinero { fecha: get_fecha_actual(), dni: u.dni.clone(), monto });
            true
        } else {
            false // No esta el usuario
        }
    }

    pub fn comprar_cripto(&mut self, dni: String, cripto: Prefijo, monto_cripto: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            if !u.esta_validado() {
                return false;
            }

            let info = cripto.get_info();
            let precio_total = monto_cripto * info.valor;
            //println!("Usuario validado? {}", u.esta_validado());
            //println!("Saldo fiat antes de comprar: {}", u.fiat);
            //println!("Precio total de la compra: {}", precio_total);

            if !u.debitar_fiat(precio_total) {
                return false;
            }

            u.agregar_cripto(&cripto, monto_cripto);
            self.transacciones.push(Transaccion::CompraCripto { fecha: get_fecha_actual(), dni:u.dni.clone(), cripto, cotizacion: info.valor, monto: monto_cripto });
            true
        } else {
            false
        }
        
    }

    pub fn vender_cripto(&mut self, dni: String, cripto: Prefijo, monto_cripto: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            if !u.esta_validado() {
                return false;
            }

            if !u.debitar_cripto(&cripto, monto_cripto){
                return false;
            }

            let info= cripto.get_info();
            let valor_total = monto_cripto * info.valor;

            u.agregar_fiat(valor_total);

            self.transacciones.push(Transaccion::VentaCripto { 
                fecha: get_fecha_actual(),
                dni: u.dni.clone(),
                cripto,
                cotizacion: info.valor,
                monto: monto_cripto,
            });

            true
        }else {
            false
        }
    }

    pub fn retirar_blockchain(&mut self, dni: String, cripto: Prefijo, blockchain: String, monto_cripto: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            if !u.validado {
                return false;
            }

            let info= cripto.get_info();

            if let Some(bl) = info.blockchains.iter().find(|x| x.nombre == blockchain) {
                if !u.debitar_cripto(&cripto, monto_cripto) {
                    return false; // No tiene suficiente
                }

                let hash = format!("{}#{}", bl.nombre, rand::random::<u32>());
                self.transacciones.push(Transaccion::RetiroCripto {
                    fecha: get_fecha_actual(),
                    dni: u.dni.clone(),
                    blockchain: bl.nombre.clone(),
                    hash,
                    cripto,
                    cotizacion: info.valor,
                    monto: monto_cripto,
                });
                true

            } else {
                false // Blockchain no válida
            }

        } else {
            false // Usuario no encontrado
        }
        
    }

    pub fn recepcion_blockchain(&mut self, dni: String, cripto: Prefijo, blockchain: String, monto_cripto: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            if !u.validado {
                return false;
            }

            let info = cripto.get_info();
            u.agregar_cripto(&cripto, monto_cripto);

            self.transacciones.push(Transaccion::RecepcionCripto {
                fecha: get_fecha_actual(),
                dni: u.dni.clone(),
                blockchain,
                cripto,
                cotizacion: info.valor,
                monto: monto_cripto,
            });

            true
        } else {
            false 
        }
    }

    pub fn retirar_fiat(&mut self, dni: String, medio: Medio, monto_fiat: f64) -> bool {
        let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

        if let Some(u) = user {
            if !u.validado {
                return false;
            }

            if !u.debitar_fiat(monto_fiat) {
            return false; // No tiene saldo suficiente
            }

            self.transacciones.push(Transaccion::RetiroFiat {
                fecha: get_fecha_actual(),
                dni: u.dni.clone(),
                monto: monto_fiat,
                medio,
            });

            true
        } else {
        false
        }
    }

    pub fn top_cripto_ventas(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, u32> = HashMap::new();
            
            for t in &self.transacciones {
                match t {
                    Transaccion::VentaCripto { cripto, .. } => *map.entry(cripto.clone()).or_insert(0) += 1,
                    _ => ()
                }
            }

            map.into_iter().max_by_key(|&(_, count)| count).map(|(pr, _)| pr) 
    }

    pub fn top_cripto_compras(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, u32> = HashMap::new();
            
            for t in &self.transacciones {
                match t {
                    Transaccion::CompraCripto { cripto, ..} => *map.entry(cripto.clone()).or_insert(0) += 1,
                    _ => ()
                }
            }

            map.into_iter().max_by_key(|&(_, count)| count).map(|(pr, _)| pr) 
    }

    pub fn top_volumen_ventas(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, f64> = HashMap::new();
            
        for t in &self.transacciones {
            match t {
                Transaccion::VentaCripto { cripto, monto, ..} => *map.entry(cripto.clone()).or_insert(0.0) += monto,
                _ => ()
            }
        }

        map.into_iter().max_by(|(_, totala), (_, totalb)| {
            match totala.partial_cmp(totalb) {
                Some(ordering) => ordering,
                None => std::cmp::Ordering::Equal,
            }
        }).map(|(pr,_)| pr)
    }

    pub fn top_volumen_compras(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, f64> = HashMap::new();
            
        for t in &self.transacciones {
            match t {
                Transaccion::CompraCripto { cripto, monto, ..} => *map.entry(cripto.clone()).or_insert(0.0) += monto,
                _ => ()
            }
        }

        map.into_iter().max_by(|(_, totala), (_, totalb)| {
            match totala.partial_cmp(totalb) {
                Some(ordering) => ordering,
                None => std::cmp::Ordering::Equal,
            }
        }).map(|(pr,_)| pr)
    }
}


impl Prefijo {
    fn cotizacion(&self) -> f64 {
        match  self {
            Prefijo::BTC => 107000.0,
            Prefijo::ETH => 2600.0,
            Prefijo::SOL => 179.0,
            Prefijo::DODGE => 0.22,
            Prefijo::XLM => 0.28,
            Prefijo::USDT => 1.0
        }
    } 

    fn get_info(&self) -> CriptoMoneda {
        match self {
            Prefijo::BTC => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "Bitcoin".to_string(), prefijo: "BTC".to_string()}]},
            Prefijo::ETH => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "Ethereum".to_string(), prefijo: "ETH".to_string()}]},
            Prefijo::SOL => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "Solana".to_string(), prefijo: "SOL".to_string()}]},
            Prefijo::DODGE => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "DodgeCoin".to_string(), prefijo: "DODGE".to_string()}]},
            Prefijo::XLM => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "Lumen".to_string(), prefijo: "XLM".to_string()}]},
            Prefijo::USDT => CriptoMoneda { valor: self.cotizacion(), blockchains: vec![Blockchain{nombre: "Tether".to_string(), prefijo: "USDT".to_string()}]},
    }
    }
}

impl Usuario {
    pub fn new(nombre: String, apellido: String, email: String, dni: String) -> Usuario {
        Usuario {
            nombre,
            apellido,
            email,
            dni,
            validado: false,
            fiat: 0.0,
            balances: HashMap::new()
        }
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_usuario_new() {
        let user = Usuario::new("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert_eq!("Nico".to_string(), user.nombre);
        assert_eq!("Carri".to_string(), user.apellido);
        assert_eq!("nc@gmail.com".to_string(), user.email);
        assert_eq!("123123123".to_string(), user.dni);
    }

    #[test]
    fn test_xyz_new() {
        let plataforma = XYZ::new();

        assert!(plataforma.transacciones.is_empty());
        assert!(plataforma.usuarios.is_empty());

    }

    #[test]
    fn test_xyz_crear_usuario() {
        let mut plataforma = XYZ::new();

        assert!(plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string()));

        assert_eq!(1, plataforma.usuarios.len());
        assert_eq!("Nico".to_string(), plataforma.usuarios[0].nombre);
        assert_eq!(false, plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string()));
    }

    #[test]
    fn test_xyz_validar_usuario() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert!(plataforma.validar_usuario("123123123".to_string()));
        assert!(plataforma.usuarios[0].validado);
        assert!(!plataforma.validar_usuario("no existe".to_string()));
    }

    #[test]
    fn test_xyz_ingresar_dinero() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert_eq!(false, plataforma.ingresar_dinero("123123123".to_string(), 200.0));
        plataforma.validar_usuario("123123123".to_string());
        assert!(plataforma.ingresar_dinero("123123123".to_string(), 200.0));

        match plataforma.transacciones[0] {
            Transaccion::IngresoDinero { .. } => assert!(true),
            _ => assert!(false)
        }

        assert_eq!(200.0, plataforma.usuarios[0].fiat);

        assert_eq!(false, plataforma.ingresar_dinero("no existe".to_string(), 200.0));

    }

    #[test]
    fn test_xyz_comprar_cripto() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert_eq!(false, plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 5000000.0);

        
        //println!("Saldo fiat usuario: {}", plataforma.usuarios[0].fiat);
        //println!("¿Está validado?: {:?}", plataforma.usuarios[0].esta_validado());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));

        println!("{:?}", plataforma.transacciones[0]);

        match plataforma.transacciones[1] {
            Transaccion::CompraCripto { .. } => assert!(true),
            _ => assert!(false)
        }

        let Some(balance) = plataforma.usuarios[0].balances.get(&Prefijo::BTC) else {
            panic!("No se encontró el balance de BTC");
        };
        assert_eq!(&0.1, balance);

        assert_eq!(false, plataforma.comprar_cripto("no existe".to_string(), Prefijo::BTC, 0.1));
    }

    #[test]
    fn test_xyz_vender_cripto() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        assert_eq!(false, plataforma.vender_cripto("no existe".to_string(), Prefijo::BTC, 1.0)); // no existe
    
        assert_eq!(false, plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 1.0)); // sin validar
        plataforma.validar_usuario("123123123".to_string());
        assert_eq!(false, plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 1.0)); // sin cripto

        plataforma.ingresar_dinero("123123123".to_string(), 9000000.0);
        plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1);

        assert_eq!(false, plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 5.0)); // sin balance suficiente

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.05));

        match plataforma.transacciones[2] {
            Transaccion::VentaCripto { .. } => assert!(true),
            _ => assert!(false)
        }


        let Some(balance) = plataforma.usuarios[0].balances.get(&Prefijo::BTC) else {
            panic!("No se encontró el balance de BTC");
        };
        assert_eq!(&0.05, balance);
    }

    #[test]
    fn test_xyz_retirar_blockchain() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        assert_eq!(false, plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2)); // sin validar
        assert_eq!(false, plataforma.retirar_blockchain("no existe".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2)); // no existe usuario
    

        plataforma.validar_usuario("123123123".to_string());
        assert_eq!(false, plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2)); // sin cripto

        plataforma.ingresar_dinero("123123123".to_string(), 10000000.0);
        plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 1.5);

        assert_eq!(false, plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "No existe".to_string(), 0.2));
        assert_eq!(false, plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 10.0));
        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2));

        match plataforma.transacciones[2] {
            Transaccion::RetiroCripto { .. } => assert!(true),
            _ => assert!(false)
        }


        let Some(balance) = plataforma.usuarios[0].balances.get(&Prefijo::BTC) else {
            panic!("No se encontró el balance de BTC");
        };
        assert_eq!(&1.3, balance);
    }

    #[test]
    fn test_xyz_recepcion_blockchain() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        assert_eq!(false, plataforma.recepcion_blockchain("no existe".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03)); // sin validar
        assert_eq!(false, plataforma.recepcion_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03)); // sin validar

        plataforma.validar_usuario("123123123".to_string());

        assert!(plataforma.recepcion_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03));

        match plataforma.transacciones[0] {
            Transaccion::RecepcionCripto { .. } => assert!(true),
            _ => assert!(false)
        }


        let Some(balance) = plataforma.usuarios[0].balances.get(&Prefijo::BTC) else {
            panic!("No se encontró el balance de BTC");
        };
        assert_eq!(&0.03, balance);
    }

    #[test]
    fn test_xyz_retirar_fiat() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 100000.0);
    
        assert!(plataforma.retirar_fiat("123123123".to_string(), Medio::TransferenciaBancaria, 75000.0));

        match plataforma.transacciones[1] {
            Transaccion::RetiroFiat { .. } => assert!(true),
            _ => assert!(false)
        }


        assert_eq!(25000.0, plataforma.usuarios[0].fiat);
    }

    #[test]
    fn test_xyz_top_cripto_compras() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 1000000.0);
    
        assert_eq!(None, plataforma.top_cripto_compras());


        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0));

        let Some(top) = plataforma.top_cripto_compras() else {
            panic!("No se obtuvo el top de compras");
        };
        assert_eq!(Prefijo::BTC, top);  
    }

    #[test]
    fn test_xyz_top_cripto_ventas() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 1000000.0);
        
        assert_eq!(None, plataforma.top_cripto_ventas());


        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0));

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 1.0));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.5));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 4.0));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 2.0));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::XLM, 100000.0));


        let Some(top) = plataforma.top_cripto_ventas() else {
            panic!("No se obtuvo el top de ventas");
        };
        assert_eq!(Prefijo::ETH, top);
    }

    #[test]
    fn test_xyz_top_volumen_compras() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 1000000.0);
    
        assert_eq!(None, plataforma.top_volumen_compras());


        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0));

        let Some(top) = plataforma.top_volumen_compras() else {
            panic!("No se obtuvo el top volumen de compras");
        };
        assert_eq!(Prefijo::XLM, top);
    }

    #[test]
    fn test_xyz_top_volumen_ventas() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());
        plataforma.validar_usuario("123123123".to_string());
        plataforma.ingresar_dinero("123123123".to_string(), 1000000.0);
    
        assert_eq!(None, plataforma.top_volumen_ventas());


        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08));
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0));

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 1.0));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.5));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 4.0));
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 2.0));


        let Some(top) = plataforma.top_volumen_ventas() else {
            panic!("No se obtuvo el top volumen de ventas");
        };
        assert_eq!(Prefijo::ETH, top);
    }   




}


















