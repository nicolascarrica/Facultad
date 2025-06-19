
use std::{collections::HashMap};
use std::fmt;
use std::fs;
use std::path::Path;
use chrono::prelude::*;
use serde::{Deserialize, Serialize};
use crate::tp05::fecha::Fecha;


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

#[derive(Debug, PartialEq)]
pub enum ErrorXYZ {
    UsuarioNoEncontrado,
    UsuarioYaExiste,
    UsuarioNoValidado,
    SaldoFiatInsuficiente,
    SaldoCriptoInsuficiente,
    BlockchainNoSoportada,
    ErrorSerializacion,
    ErrorLecturaArchivo,
}

impl fmt::Display for ErrorXYZ {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let msg = match self {
            ErrorXYZ::UsuarioNoEncontrado => "Usuario no encontrado",
            ErrorXYZ::UsuarioYaExiste => "Ya existe un usuario con ese DNI",
            ErrorXYZ::UsuarioNoValidado => "El usuario no esta validado",
            ErrorXYZ::SaldoFiatInsuficiente => "Saldo fiat insuficiente",
            ErrorXYZ::SaldoCriptoInsuficiente => "Saldo cripto insuficiente",
            ErrorXYZ::BlockchainNoSoportada => "Blockchain no soportada por esta criptomoneda",
            ErrorXYZ::ErrorSerializacion => "Error de serialización JSON",
            ErrorXYZ::ErrorLecturaArchivo => "Error al leer o escribir archivo",
        };
        write!(f, "{}", msg)
    }
}

// impl std::error::Error for ErrorXYZ {}

impl From<serde_json::Error> for ErrorXYZ {
    fn from(_: serde_json::Error) -> Self {
        ErrorXYZ::ErrorSerializacion
    }
}

impl From<std::io::Error> for ErrorXYZ {
    fn from(_: std::io::Error) -> Self {
        ErrorXYZ::ErrorLecturaArchivo
    }
}

#[derive(Clone, PartialEq, Serialize, Deserialize)]
struct Blockchain {
    nombre: String,
    prefijo: String,
}

#[derive(Debug, PartialEq, Eq, Hash, Clone, Serialize, Deserialize)]
pub enum Prefijo {
    BTC,
    ETH,
    SOL, 
    DODGE,
    XLM, 
    USDT,
}

#[derive(Clone, Serialize, Deserialize)]
pub struct CriptoMoneda {
    valor: f64,
    blockchains: Vec<Blockchain>
}
#[derive(Clone, Debug, Serialize, Deserialize)]
struct Usuario {
    nombre: String,
    apellido: String,
    email: String,
    dni: String,
    validado: bool,
    fiat: f64,
    balances: HashMap<Prefijo, f64>
}

impl PartialEq for Usuario {
    fn eq(&self, other: &Self) -> bool {
        self.dni == other.dni
    }
}

#[derive(Debug, Serialize, Deserialize)]
pub enum Medio {
    MercadoPago,
    TransferenciaBancaria
}

#[derive(Debug, Serialize, Deserialize)]
enum Transaccion {
    IngresoDinero { fecha: Fecha, dni: String, monto: f64 },
    CompraCripto { fecha: Fecha, dni: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    VentaCripto { fecha: Fecha, dni: String, cripto: Prefijo, cotizacion: f64, monto: f64 },
    RetiroCripto { fecha: Fecha, dni: String, blockchain: String, hash: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    RecepcionCripto { fecha: Fecha, dni: String, blockchain: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, // Cotizacion esta dentro de cripto
    RetiroFiat { fecha: Fecha, dni: String, monto: f64, medio: Medio } // Cotizacion esta dentro de cripto
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

pub struct XYZ {
    usuarios: Vec<Usuario>,
    transacciones: Vec<Transaccion>,
    path_usuarios: String,
    path_transacciones: String,
    
}
impl XYZ {
    pub fn new() -> XYZ {
        XYZ {
            usuarios: Vec::new(),
            transacciones: Vec::new(),
            path_usuarios: "src/tp05/usuarios.json".into(),
            path_transacciones: "src/tp05/transacciones.json".into(),
        }
    }

    fn crear_usuario(
        &mut self,
        nombre: String,
        apellido: String,
        email: String,
        dni: String,
        ) -> Result<(), ErrorXYZ> {
        if self.usuarios.iter().any(|u| u.dni == dni) {
            Err(ErrorXYZ::UsuarioYaExiste)
        } else {
            self.usuarios.push(Usuario::new(nombre, apellido, email, dni));
            self.guardar_usuarios(&self.path_usuarios)?;
            Ok(())
        }
    }

    fn validar_usuario(&mut self, dni: String) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                u.validar();
                self.guardar_usuarios(&self.path_usuarios)?;
                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn ingresar_dinero(&mut self, dni: String, monto: f64) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                if !u.validado {
                    return Err(ErrorXYZ::UsuarioNoValidado);
                }
                u.agregar_fiat(monto);
                self.transacciones.push(Transaccion::IngresoDinero {
                    fecha: get_fecha_actual(),
                    dni: u.dni.clone(),
                    monto,
                });
                self.guardar_usuarios(&self.path_usuarios)?;
                self.guardar_transacciones(&self.path_transacciones)?;
                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn comprar_cripto(
        &mut self,
        dni: String,
        cripto: Prefijo,
        monto_cripto: f64,
    ) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                if !u.esta_validado() {
                    return Err(ErrorXYZ::UsuarioNoValidado);
                }

                let info = cripto.get_info();
                let precio_total = monto_cripto * info.valor;

                if !u.debitar_fiat(precio_total) {
                    return Err(ErrorXYZ::SaldoFiatInsuficiente);
                }

                u.agregar_cripto(&cripto, monto_cripto);
                self.transacciones.push(Transaccion::CompraCripto {
                    fecha: get_fecha_actual(),
                    dni: u.dni.clone(),
                    cripto,
                    cotizacion: info.valor,
                    monto: monto_cripto,
                });
                self.guardar_usuarios(&self.path_usuarios)?;
                self.guardar_transacciones(&self.path_transacciones)?;
                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn vender_cripto(
        &mut self,
        dni: String,
        cripto: Prefijo,
        monto_cripto: f64,
    ) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                if !u.esta_validado() {
                    return Err(ErrorXYZ::UsuarioNoValidado);
                }

                if !u.debitar_cripto(&cripto, monto_cripto) {
                    return Err(ErrorXYZ::SaldoCriptoInsuficiente);
                }

                let info = cripto.get_info();
                let valor_total = monto_cripto * info.valor;

                u.agregar_fiat(valor_total);
                    self.transacciones.push(Transaccion::VentaCripto {
                    fecha: get_fecha_actual(),
                    dni: u.dni.clone(),
                    cripto,
                    cotizacion: info.valor,
                    monto: monto_cripto,
                });

                self.guardar_usuarios(&self.path_usuarios)?;
                self.guardar_transacciones(&self.path_transacciones)?;
                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn retirar_blockchain(
        &mut self,
        dni: String,
        cripto: Prefijo,
        blockchain: String,
        monto_cripto: f64,
    ) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                if !u.validado {
                    return Err(ErrorXYZ::UsuarioNoValidado);
                }

                let info = cripto.get_info();

                if let Some(bl) = info.blockchains.iter().find(|x| x.nombre == blockchain) {
                    if !u.debitar_cripto(&cripto, monto_cripto) {
                        return Err(ErrorXYZ::SaldoCriptoInsuficiente);
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
                    self.guardar_usuarios(&self.path_usuarios)?;
                    self.guardar_transacciones(&self.path_transacciones)?;
                    Ok(())
                } else {
                    Err(ErrorXYZ::BlockchainNoSoportada)
                }
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn recepcion_blockchain(
        &mut self,
        dni: String,
        cripto: Prefijo,
        blockchain: String,
        monto_cripto: f64,
    ) -> Result<(), ErrorXYZ> {
        match self.usuarios.iter_mut().find(|u| u.dni == dni) {
            Some(u) => {
                if !u.validado {
                    return Err(ErrorXYZ::UsuarioNoValidado);
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
                self.guardar_usuarios(&self.path_usuarios)?;
                self.guardar_transacciones(&self.path_transacciones)?;
                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }

    fn retirar_fiat(
        &mut self,
        dni: String,
        medio: Medio,
        monto_fiat: f64,
    ) -> Result<(), ErrorXYZ> {
    match self.usuarios.iter_mut().find(|u| u.dni == dni) {
        Some(u) => {
            if !u.validado {
                return Err(ErrorXYZ::UsuarioNoValidado);
            }

            if !u.debitar_fiat(monto_fiat) {
                return Err(ErrorXYZ::SaldoFiatInsuficiente);
            }

            self.transacciones.push(Transaccion::RetiroFiat {
                fecha: get_fecha_actual(),
                dni: u.dni.clone(),
                monto: monto_fiat,
                medio,
            });

                self.guardar_usuarios(&self.path_usuarios)?;
                self.guardar_transacciones(&self.path_transacciones)?;

                Ok(())
            }
            None => Err(ErrorXYZ::UsuarioNoEncontrado),
        }
    }
    

    fn top_cripto_ventas(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, u32> = HashMap::new();
            
            for t in &self.transacciones {
                match t {
                    Transaccion::VentaCripto { cripto, .. } => *map.entry(cripto.clone()).or_insert(0) += 1,
                    _ => ()
                }
            }

            map.into_iter().max_by_key(|&(_, count)| count).map(|(pr, _)| pr) 
    }

    fn top_cripto_compras(&self) -> Option<Prefijo> {
        let mut map: HashMap<Prefijo, u32> = HashMap::new();
            
            for t in &self.transacciones {
                match t {
                    Transaccion::CompraCripto { cripto, ..} => *map.entry(cripto.clone()).or_insert(0) += 1,
                    _ => ()
                }
            }

            map.into_iter().max_by_key(|&(_, count)| count).map(|(pr, _)| pr) 
    }

    fn top_volumen_ventas(&self) -> Option<Prefijo> {
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

    fn top_volumen_compras(&self) -> Option<Prefijo> {
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

    fn guardar_usuarios(&self, path: &str) -> Result<(), ErrorXYZ> {
        let json = serde_json::to_string_pretty(&self.usuarios)?;
         fs::write(path, json)?;
        Ok(())
    }

    fn cargar_usuarios(&mut self, path: &str) -> Result<(), ErrorXYZ> {
        if !Path::new(path).exists() {
            return Ok(()); // No existe archivo, no cargar nada
        }
        let data = fs::read_to_string(path)?;
        self.usuarios = serde_json::from_str(&data)?;
        Ok(())
    }

    fn guardar_transacciones(&self, path: &str) -> Result<(), ErrorXYZ> {
        let json = serde_json::to_string_pretty(&self.transacciones)?;
        fs::write(path, json)?;
        Ok(())
    }

    fn cargar_transacciones(&mut self, path: &str) -> Result<(), ErrorXYZ> {
        if !Path::new(path).exists() {
            return Ok(()); // No existe archivo
        }
        let data = fs::read_to_string(path)?;
        self.transacciones = serde_json::from_str(&data)?;
        Ok(())
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
    use std::{fs::File, io::Write};

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

        let res1 = plataforma.crear_usuario(
            "Nico".to_string(),
            "Carri".to_string(),
            "nc@gmail.com".to_string(),
            "123123123".to_string(),
        );

        assert!(res1.is_ok());
         assert_eq!(plataforma.usuarios.len(), 1);
        assert_eq!(plataforma.usuarios[0].nombre, "Nico");

        let res2 = plataforma.crear_usuario(
            "Nico".to_string(),
            "Carri".to_string(),
            "nc@gmail.com".to_string(),
            "123123123".to_string(),
        );
            assert_eq!("Nico".to_string(), plataforma.usuarios[0].nombre);
            assert_eq!(res2, Err(ErrorXYZ::UsuarioYaExiste));
    }

    #[test]
    fn test_xyz_validar_usuario() {
        let mut plataforma = XYZ::new();

        // Crear usuario y asegurar que fue exitoso
            let crear_usu = plataforma.crear_usuario(
            "Nico".to_string(),
            "Carri".to_string(),
            "nc@gmail.com".to_string(),
            "123123123".to_string(),
        );

        assert!(crear_usu.is_ok());

        // Validar usuario existente
        let res1 = plataforma.validar_usuario("123123123".to_string());
        assert!(res1.is_ok());
        assert!(plataforma.usuarios[0].validado);
        let res2 = plataforma.validar_usuario("no existe".to_string());
        assert_eq!(res2, Err(ErrorXYZ::UsuarioNoEncontrado));
    }

    #[test]
    fn test_xyz_ingresar_dinero() {
        let mut plataforma = XYZ::new();

        // Crear usuario
        let crear = plataforma.crear_usuario(
            "Nico".to_string(),
            "Carri".to_string(),
            "nc@gmail.com".to_string(),
            "123123123".to_string(),
        );
        assert!(crear.is_ok());

        // Ingreso fallido: usuario no validado
        let ingreso1 = plataforma.ingresar_dinero("123123123".to_string(), 200.0);
        assert!(ingreso1.is_err());
        assert_eq!(ingreso1, Err(ErrorXYZ::UsuarioNoValidado));


        // Validar usuario
        let validar = plataforma.validar_usuario("123123123".to_string());
        assert!(validar.is_ok());

        // Ingreso exitoso
        let ingreso2 = plataforma.ingresar_dinero("123123123".to_string(), 200.0);
        assert!(ingreso2.is_ok());

        // Verificar transacción
        assert_eq!(plataforma.transacciones.len(), 1);
        match &plataforma.transacciones[0] {
            Transaccion::IngresoDinero { monto, .. } => assert_eq!(*monto, 200.0),
            _ => panic!("Se esperaba una transacción de ingreso"),
        }

        // Verificar saldo
        assert_eq!(plataforma.usuarios[0].fiat, 200.0);

        // Ingreso con usuario inexistente
        let ingreso3 = plataforma.ingresar_dinero("no existe".to_string(), 200.0);
        assert!(ingreso3.is_err());
        assert_eq!(ingreso3, Err(ErrorXYZ::UsuarioNoEncontrado));
    }

    #[test]
    fn test_xyz_comprar_cripto() {
        let mut plataforma = XYZ::new();

        // Crear usuario
        let crear = plataforma.crear_usuario(
            "Nico".to_string(),
            "Carri".to_string(),
            "nc@gmail.com".to_string(),
            "123123123".to_string(),
        );
        assert!(crear.is_ok());

        // Compra antes de validar: debe fallar
        let compra_invalida = plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1);
        assert!(compra_invalida.is_err());
        assert_eq!(compra_invalida, Err(ErrorXYZ::UsuarioNoValidado));

        // Validar e ingresar dinero
        let validar = plataforma.validar_usuario("123123123".to_string());
        assert!(validar.is_ok());

        let ingreso = plataforma.ingresar_dinero("123123123".to_string(), 5_000_000.0);
        assert!(ingreso.is_ok());

        // Compra válida
        let compra_valida = plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1);
        assert!(compra_valida.is_ok());

        // Ver transacción (índice 1, porque ya hay una de ingreso)
        assert_eq!(plataforma.transacciones.len(), 2);
        match &plataforma.transacciones[1] {
            Transaccion::CompraCripto { cripto, monto, .. } => {
                assert_eq!(*cripto, Prefijo::BTC);
                assert_eq!(*monto, 0.1);
            }
            _ => panic!("Se esperaba una transacción de Compra Cripto"),
        }

        // Verificar balance en BTC
        let balance_btc = plataforma.usuarios[0].balances.get(&Prefijo::BTC);
        assert!(balance_btc.is_some());
        assert_eq!(balance_btc.unwrap(), &0.1); // solo uso unwrap en test controlado sobre Option

        // Compra con usuario inexistente
        let compra_inexistente = plataforma.comprar_cripto("no existe".to_string(), Prefijo::BTC, 0.1);
        assert!(compra_inexistente.is_err());
        assert_eq!(compra_inexistente, Err(ErrorXYZ::UsuarioNoEncontrado));
    }

    #[test]
    fn test_xyz_vender_cripto() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert!(plataforma.vender_cripto("no existe".to_string(), Prefijo::BTC, 1.0).is_err()); // no existe
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 1.0).is_err()); // sin validar

        plataforma.validar_usuario("123123123".to_string());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 1.0).is_err()); // sin cripto

        plataforma.ingresar_dinero("123123123".to_string(), 9000000.0);
        plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1);

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 5.0).is_err()); // sin balance suficiente

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.05).is_ok());

        match plataforma.transacciones[2] {
            Transaccion::VentaCripto { .. } => assert!(true),
            _ => assert!(false),
        }

        let Some(balance) = plataforma.usuarios[0].balances.get(&Prefijo::BTC) else {
            panic!("No se encontró el balance de BTC");
        };
        assert_eq!(&0.05, balance);
    }

    #[test]
    #[test]
    fn test_xyz_retirar_blockchain() {
        let mut plataforma = XYZ::new();
        plataforma.crear_usuario("Nico".to_string(), "Carri".to_string(), "nc@gmail.com".to_string(), "123123123".to_string());

        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2).is_err()); // sin validar
        assert!(plataforma.retirar_blockchain("no existe".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2).is_err()); // no existe usuario

        plataforma.validar_usuario("123123123".to_string());
        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2).is_err()); // sin cripto

        plataforma.ingresar_dinero("123123123".to_string(), 10000000.0);
        plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 1.5);

        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "No existe".to_string(), 0.2).is_err());
        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 10.0).is_err());
        assert!(plataforma.retirar_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.2).is_ok());

        match plataforma.transacciones[2] {
            Transaccion::RetiroCripto { .. } => assert!(true),
            _ => assert!(false),
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

        assert!(plataforma.recepcion_blockchain("no existe".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03).is_err()); // usuario no existe
        assert!(plataforma.recepcion_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03).is_err()); // sin validar

        plataforma.validar_usuario("123123123".to_string());

        assert!(plataforma.recepcion_blockchain("123123123".to_string(), Prefijo::BTC, "Bitcoin".to_string(), 0.03).is_ok());

        match plataforma.transacciones[0] {
            Transaccion::RecepcionCripto { .. } => assert!(true),
            _ => assert!(false),
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

        assert!(plataforma.retirar_fiat("123123123".to_string(), Medio::TransferenciaBancaria, 75000.0).is_ok());

        match plataforma.transacciones[1] {
            Transaccion::RetiroFiat { .. } => assert!(true),
            _ => assert!(false),
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

        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0).is_ok());

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

        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0).is_ok());

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 1.0).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.5).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 4.0).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 2.0).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::XLM, 100000.0).is_ok());

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

        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0).is_ok());

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

        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 2.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::ETH, 10.0).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.1).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.3).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::BTC, 0.08).is_ok());
        assert!(plataforma.comprar_cripto("123123123".to_string(), Prefijo::XLM, 300000.0).is_ok());

        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 1.0).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::BTC, 0.5).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 4.0).is_ok());
        assert!(plataforma.vender_cripto("123123123".to_string(), Prefijo::ETH, 2.0).is_ok());

        if let Some(top) = plataforma.top_volumen_ventas() {
            assert_eq!(Prefijo::ETH, top);
        } else {
            panic!("No se obtuvo el top volumen de ventas");
        }
    } 

    #[test]
fn test_tiene_balance_cripto() {

    let mut usuario = Usuario::new("Mati".into(), "Rodri".into(), "mr@x.com".into(), "154656".into());

    // Agrega 10 BTC
    usuario.agregar_cripto(&Prefijo::BTC, 10.0);

    // Caso 1: tiene suficiente
    assert!(usuario.tiene_balance_cripto(&Prefijo::BTC, 5.0));

    // Caso 2: tiene pero no alcanza
    assert!(!usuario.tiene_balance_cripto(&Prefijo::BTC, 15.0));

    // Caso 3: no tiene esa cripto
    assert!(!usuario.tiene_balance_cripto(&Prefijo::ETH, 1.0));
}

/// test persisntencia en json
/// 
fn crear_usuario_ejemplo() -> Usuario {
    Usuario::new("Ana".into(), "Lopez".into(), "ana@x.com".into(), "123".into())
}

#[test]
fn test_guardar_y_cargar_usuarios_ok() {
    let path = "usuarios_test_ok.json";

    let mut sistema = XYZ::new();
    sistema.usuarios.push(crear_usuario_ejemplo());

    let resultado_guardar = sistema.guardar_usuarios(path);
    assert!(resultado_guardar.is_ok(), "Fallo al guardar usuarios");

    let mut nuevo = XYZ::new();
    let resultado_cargar = nuevo.cargar_usuarios(path);
    assert!(resultado_cargar.is_ok(), "Fallo al cargar usuarios");

    assert_eq!(nuevo.usuarios.len(), 1);
    assert_eq!(nuevo.usuarios[0].dni, "123");

    let _ = fs::remove_file(path); // ignoramos error si no existe
}

#[test]
fn test_guardar_y_cargar_transacciones_ok() {
    let path = "transacciones_test_ok.json";

    let mut sistema = XYZ::new();
    sistema.transacciones.push(Transaccion::RetiroFiat {
        fecha: Fecha::new(1, 1, 2025),
        dni: "123".to_string(),
        monto: 100.0,
        medio: Medio::MercadoPago,
    });

    let resultado_guardar = sistema.guardar_transacciones(path);
    assert!(resultado_guardar.is_ok(), "Fallo al guardar transacciones");

    let mut nuevo = XYZ::new();
    let resultado_cargar = nuevo.cargar_transacciones(path);
    assert!(resultado_cargar.is_ok(), "Fallo al cargar transacciones");

    assert_eq!(nuevo.transacciones.len(), 1);

    let _ = fs::remove_file(path);
}

#[test]
fn test_cargar_usuarios_archivo_inexistente() {
    let path = "archivo_que_no_existe.json";

    let mut sistema = XYZ::new();
    let resultado = sistema.cargar_usuarios(path);

    assert!(resultado.is_ok(), "Debe ser Ok si no existe el archivo");
}

#[test]
fn test_cargar_transacciones_archivo_inexistente() {
    let path = "archivo_inexistente_transacciones.json";

    let mut sistema = XYZ::new();
    let resultado = sistema.cargar_transacciones(path);

    assert!(resultado.is_ok(), "Debe ser Ok si no existe el archivo");
}

#[test]
fn test_cargar_usuarios_con_json_invalido() {
    let path = "usuarios_corrupto.json";
    let archivo = File::create(path);
    if let Ok(mut file) = archivo {
        let _ = file.write_all(b"no es json valido");
    }

    let mut sistema = XYZ::new();
    let resultado = sistema.cargar_usuarios(path);

    assert!(
        matches!(resultado, Err(ErrorXYZ::ErrorSerializacion)),
        "Debe fallar con ErrorSerializacion"
    );

    let _ = fs::remove_file(path);
}

#[test]
fn test_cargar_transacciones_con_json_invalido() {
    let path = "transacciones_corrupto.json";
    let archivo = File::create(path);
    if let Ok(mut file) = archivo {
        let _ = file.write_all(b"json roto");
    }

    let mut sistema = XYZ::new();
    let resultado = sistema.cargar_transacciones(path);

    assert!(
        matches!(resultado, Err(ErrorXYZ::ErrorSerializacion)),
        "Debe fallar con ErrorSerializacion"
    );

    let _ = fs::remove_file(path);
}

#[test]
fn test_error_lectura_archivo() {
    // Este path es inválido porque es un directorio (no un archivo)
    let path = "."; // el punto refiere al directorio actual

    let mut sistema = XYZ::new();
    let resultado = sistema.cargar_usuarios(path);

    // Debería devolver ErrorLecturaArchivo porque no puede leer un directorio como si fuera un archivo
    assert!(
        matches!(resultado, Err(ErrorXYZ::ErrorLecturaArchivo)),
        "Se esperaba ErrorLecturaArchivo, pero se obtuvo: {:?}",
        resultado
    );
}

#[test]
fn test_display_error_xyz() {
    assert_eq!(ErrorXYZ::UsuarioNoEncontrado.to_string(), "Usuario no encontrado");
    assert_eq!(ErrorXYZ::UsuarioYaExiste.to_string(), "Ya existe un usuario con ese DNI");
    assert_eq!(ErrorXYZ::UsuarioNoValidado.to_string(), "El usuario no esta validado");
    assert_eq!(ErrorXYZ::SaldoFiatInsuficiente.to_string(), "Saldo fiat insuficiente");
    assert_eq!(ErrorXYZ::SaldoCriptoInsuficiente.to_string(), "Saldo cripto insuficiente");
    assert_eq!(ErrorXYZ::BlockchainNoSoportada.to_string(), "Blockchain no soportada por esta criptomoneda");
    assert_eq!(ErrorXYZ::ErrorLecturaArchivo.to_string(), "Error al leer o escribir archivo");
    assert!(ErrorXYZ::ErrorSerializacion.to_string().contains("Error de serialización JSON"));
}


}



















