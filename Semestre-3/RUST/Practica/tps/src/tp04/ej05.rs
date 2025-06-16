// 5- La empresa XYZ es una plataforma de intercambio de criptoactivos que permite a los 
// usuarios comprar y vender distintas criptomonedas. La plataforma permite el registro de 
// usuarios y la gestión de sus balances en distintas criptomonedas y en dinero fíat. De los 
// usuarios se conoce nombre, apellido, email, dni, y si está validada su identidad o no. Cada 
// usuario tiene un balance de las criptomonedas que se ofrecen en la plataforma. De las  
// criptomonedas se conoce: nombre, prefijo y un listado de blockchains donde se pueden 
// enviar o recibir. De cada blockchain se conoce el nombre, prefijo. 
 
// Implemente las estructuras, funciones asociadas y traits necesarios para resolver las 
// siguientes acciones relacionadas al usuario: 
 
// ➢  Ingresar dinero: se recibe un monto en fiat de un usuario y se acredita al balance de 
// fiat de dicho usuario. Además se crea una transacción del hecho donde los datos 
// que se guardan son:fecha, tipo(ingreso de dinero), monto, usuario. 
 
// ➢  Comprar determinada criptomoneda: dado un monto de fiat se compra una cantidad 
// de determinada criptomoneda, tenga en cuenta que al momento de realizar la 
// operación se obtiene del sistema la cotización actual de la criptomoneda para 
// acreditar la correspondiente proporción en el balance de la cripto y desacreditar en 
// el balance de fiat. Luego de ello se registra la transacción con los siguientes datos: 
// fecha, usuario, criptomoneda, tipo: compra de cripto, monto de cripto y cotización.  
 
// ➢  Vender determinada criptomoneda: dado un monto de cripto se vende por fiat, tenga 
// en cuenta que al momento de realizar la operación se obtiene del sistema la 
// cotización actual de la criptomoneda para acreditar la correspondiente proporción en 
// el balance de fiat y desacreditar en el balance de la criptomoneda. Luego de ello se 
// registra la transacción con los siguientes datos: fecha, usuario, criptomoneda, tipo: 
// venta de cripto,monto de cripto y cotización. 
 
// ➢  Retirar criptomoneda a blockchain: dado un monto de una cripto y una blockchain se 
// le descuenta del balance de dicha cripto al usuario el monto, la blockchain devuelve 
// un hash que representa una transacción en ella (esto hágalo retornando el nombre 
// de la blockchain + un número random). Luego se genera una transacción con los 
// siguientes datos: fecha, usuario, tipo: retiro cripto, blockchain, hash, cripto, monto, 
// cotización. 

// ➢  Recibir criptomoneda de blockchain: dado un monto de una cripto y una blockchain 
// se le acredita al balance de dicha cripto al usuario el monto. Luego se genera una  
 
// transacción con los siguientes datos: fecha, usuario, tipo: recepción cripto, 
// blockchain, cripto, monto, cotización. 
 
// ➢  Retirar fiat por determinado medio: dado un monto de fiat se le descuenta dicho 
// monto del balance al usuario y se genera una transacción con la siguiente 
// información: fecha, usuario, tipo: retiro fiat, monto y medio (puede ser MercadoPago 
// o Transferencia Bancaria) 
 
// Nota:: Tanto para comprar. vender, retirar el usuario debe estar validado. 
// Se debe validar siempre que haya balance suficiente para realizar la operación en los casos 
// de compra, venta, retiro. 
 
// Además la empresa desea saber lo siguiente en base a sus operaciones: 
 
// ➢  Saber cual es la criptomoneda que más cantidad de ventas tiene 
// ➢  Saber cual es la criptomoneda que más cantidad de compras tiene 
// ➢  Saber cual es la criptomoneda que más volumen de ventas tiene 
// ➢  Saber cual es la criptomoneda que más volumen de compras tiene

use std::collections::HashMap;


use chrono::prelude::*;

use crate::tp03::ej03::Fecha;

trait Validador {
  fn validar(&mut self) -> bool;
  fn esta_validado(&self) -> bool;
}

trait ManejadorBalance {
  fn obtener_balance_fiat(&self) -> f64;
  fn obtener_balance_cripto(&self, cripto: &Prefijo) -> f64;
  fn actualizar_balance_fiat(&mut self, monto: f64) -> bool;
  fn actualizar_balance_cripto(&mut self, cripto: Prefijo, monto: f64) -> bool;
  fn tiene_balance_suficiente_fiat(&self, monto: f64) -> bool;
  fn tiene_balance_suficiente_cripto(&self, cripto: &Prefijo, monto: f64) -> bool;
}

trait Cotizador {
  fn obtener_cotizacion(&self) -> f64;
  fn calcular_valor_fiat(&self, cantidad: f64) -> f64;
  fn calcular_cantidad_cripto(&self, valor_fiat: f64) -> f64;
}

trait Transaccionador {
  fn registrar_transaccion(&mut self, transaccion: Transaccion);
  fn obtener_historial(&self) -> &Vec<Transaccion>;
}

trait Reportes {
  fn top_cripto_compras(&self) -> Option<Prefijo>;
  fn top_cripto_ventas(&self) -> Option<Prefijo>;
  fn top_volumen_compras(&self) -> Option<Prefijo>;
  fn top_volumen_ventas(&self) -> Option<Prefijo>;
}

trait InformacionDetallada {
  fn obtener_resumen(&self) -> HashMap<String, String>;
  fn obtener_identificador(&self) -> String;
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
enum Medio {
  MercadoPago,
  TransferenciaBancaria
}

#[derive(Debug)]
enum Transaccion {
  IngresoDinero { fecha: Fecha, usuario: Usuario, monto: f64 },
  CompraCripto { fecha: Fecha, usuario: Usuario, cripto: Prefijo, cotizacion: f64, monto: f64 }, 
  VentaCripto { fecha: Fecha, usuario: Usuario, cripto: Prefijo, cotizacion: f64, monto: f64 },
  RetiroCripto { fecha: Fecha, usuario: Usuario, blockchain: String, hash: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, 
  RecepcionCripto { fecha: Fecha, usuario: Usuario, blockchain: String, cripto: Prefijo, cotizacion: f64, monto: f64 }, 
  RetiroFiat { fecha: Fecha, usuario: Usuario, monto: f64, medio: Medio }
}

struct Xyz {
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

impl ManejadorBalance for Usuario {
  fn obtener_balance_fiat(&self) -> f64 {
    self.fiat
  }

  fn obtener_balance_cripto(&self, cripto: &Prefijo) -> f64 {
    match self.balances.get(cripto) {
      Some(balance) => *balance,
      None => 0.0,
    }
  }

  fn actualizar_balance_fiat(&mut self, monto: f64) -> bool {
    if self.fiat + monto >= 0.0 {
      self.fiat += monto;
      true
    } else {
      false // No se puede tener balance negativo
    }
  }

  fn actualizar_balance_cripto(&mut self, cripto: Prefijo, monto: f64) -> bool {
    let balance_actual = self.obtener_balance_cripto(&cripto);
    if balance_actual + monto >= 0.0 {
      *self.balances.entry(cripto).or_insert(0.0) += monto;
      true
    } else {
      false 
    }
  }

  fn tiene_balance_suficiente_fiat(&self, monto: f64) -> bool {
    self.fiat >= monto
  }

  fn tiene_balance_suficiente_cripto(&self, cripto: &Prefijo, monto: f64) -> bool {
    self.obtener_balance_cripto(cripto) >= monto
  }
}

impl Cotizador for Prefijo {
  fn obtener_cotizacion(&self) -> f64 {
    match self {
      Prefijo::BTC => 107000.0,
      Prefijo::ETH => 2600.0,
      Prefijo::SOL => 179.0,
      Prefijo::DODGE => 0.22,
      Prefijo::XLM => 0.28,
      Prefijo::USDT => 1.0
    }
  }

  fn calcular_valor_fiat(&self, cantidad: f64) -> f64 {
    cantidad * self.obtener_cotizacion()
  }

  fn calcular_cantidad_cripto(&self, valor_fiat: f64) -> f64 {
    valor_fiat / self.obtener_cotizacion()
  }
}

impl Transaccionador for Xyz {
  fn registrar_transaccion(&mut self, transaccion: Transaccion) {
    self.transacciones.push(transaccion);
  }

  fn obtener_historial(&self) -> &Vec<Transaccion> {
     &self.transacciones
  }
}

impl Reportes for Xyz {
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
    }).map(|(pr, _)| pr)
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
    }).map(|(pr, _)| pr)
  }

}

impl Xyz {
  fn new() -> Xyz {
    Xyz {
      usuarios: Vec::new(),
      transacciones: Vec::new()
    }
  }

  fn crear_usuario(&mut self, nombre: String, apellido: String, email: String, dni: String) -> bool {
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

  // fn ingresar_dinero(&mut self, dni:String, monto: f64) -> bool {
  //   let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

  //   if let Some(u) = user {
  //     if !u.esta_validado() {
  //       return false; // No está validado no puede ingresar dinero
  //     }

  //     if u.actualizar_balance_fiat(monto) {
  //       self.registrar_transaccion(Transaccion::IngresoDinero { 
  //         fecha: get_fecha_actual(), 
  //         usuario: u.clone(), 
  //         monto 
  //       });
  //       true
  //     } else {
  //       false
  //     }
  //   } else {
  //     false // No está el usuario si no devuelve some
  //   }
  // }

  fn ingresar_dinero(&mut self, dni: String, monto: f64) -> bool {
    for u in &mut self.usuarios {
        if u.dni == dni {
            if !u.esta_validado() {
                return false; // No está validado no puede ingresar dinero
            }

            let balance_actualizado = u.actualizar_balance_fiat(monto);
            if balance_actualizado {
                let transaccion = Transaccion::IngresoDinero { 
                    fecha: get_fecha_actual(), 
                    usuario: u.clone(), 
                    monto 
                };
                self.registrar_transaccion(transaccion);
                return true;
            } else {
                return false;
            }
        }
    }
    false
  }

  pub fn comprar_cripto(&mut self, dni: String, cripto: Prefijo, monto_cripto: f64) -> bool {
    let user = self.usuarios.iter_mut().find(|u| u.dni == dni);

    if let Some(u) = user {
      if !u.esta_validado() {
        return false;
      } 

      let precio_total = cripto.calcular_valor_fiat(monto_cripto);
      
      if !u.tiene_balance_suficiente_fiat(precio_total) {
        return false;
      }

      if u.actualizar_balance_fiat(-precio_total) && u.actualizar_balance_cripto(cripto.clone(), monto_cripto) {
        self.registrar_transaccion(Transaccion::CompraCripto { 
          fecha: get_fecha_actual(), 
          usuario: u.clone(), 
          cripto: cripto.clone(), 
          cotizacion: cripto.obtener_cotizacion(),  
          monto: monto_cripto 
        });
        true
      } else {
        false
      }
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

      if !u.tiene_balance_suficiente_cripto(&cripto, monto_cripto) {
        return false;
      }

      let valor_fiat = cripto.calcular_valor_fiat(monto_cripto);
      if u.actualizar_balance_cripto(cripto.clone(), -monto_cripto) && u.actualizar_balance_fiat(valor_fiat) {
        self.registrar_transaccion(Transaccion::VentaCripto { 
          fecha: get_fecha_actual(), 
          usuario: u.clone(), 
          cripto: cripto.clone(), 
          cotizacion: cripto.obtener_cotizacion(), 
          monto: monto_cripto 
        });
           true
      } else {
          false
      }
    } else {
      false
    }

  }

  pub fn retirar_blockchain(&mut self, dni: String, cripto: Prefijo, blockchain: String, monto_cripto: f64) -> bool {
    let user = self.usuarios.iter_mut().find(|u| u.dni == dni);
    if let Some(u) = user {
      if !u.esta_validado() {
        return false;
      }

      if !u.tiene_balance_suficiente_cripto(&cripto, monto_cripto) {
        return false;
      }
      let info = cripto.get_info();
        
      if let Some(bl) = info.blockchains.iter().find(|x| &x.nombre == &blockchain) {
        let hash = format!("{}#{}", bl.nombre, rand::random::<u32>());
        
        if u.actualizar_balance_cripto(cripto.clone(), -monto_cripto) {
          self.registrar_transaccion(Transaccion::RetiroCripto { 
            fecha: get_fecha_actual(), 
            usuario: u.clone(), 
            blockchain: bl.nombre.clone(), 
            hash, 
            cripto: cripto.clone(), 
            cotizacion: cripto.obtener_cotizacion(), 
            monto: monto_cripto 
          });
          true
        } else {
            false
        }
      } else {
          false // Blockchain no válido
      }

    } else {
        false
    }
  }

  // pub fn recepcion_blockchain(&mut self, dni: String, cripto: Prefijo, blockchain: String, monto_cripto: f64) -> bool {
  //   let user = self.usuarios.iter_mut().find(|u| u.dni == dni);
  //   if let Some(u) = user {
  //     if !u.esta_validado() {
  //       return false;
  //     }
      
  //     if u.actualizar_balance_cripto(cripto.clone(), monto_cripto) {
  //       self.registrar_transaccion(Transaccion::RecepcionCripto { 
  //         fecha: get_fecha_actual(), 
  //         usuario: u.clone(), 
  //         blockchain: blockchain, 
  //         cripto: cripto.clone(), 
  //         cotizacion: cripto.obtener_cotizacion(), 
  //         monto: monto_cripto 
  //       });
  //       true
  //     } else {
  //       false
  //     }
  //   } else {
  //       false 
  //   }
  // }

  pub fn recepcion_blockchain(&mut self, dni: String, cripto: Prefijo, blockchain: String, monto_cripto: f64) -> bool {
    let user = self.usuarios.iter_mut().find(|u| u.dni == dni);
    if let Some(u) = user {
        if !u.esta_validado() {
            return false;
        }
        
        if u.actualizar_balance_cripto(cripto.clone(), monto_cripto) {
            let transaccion = Transaccion::RecepcionCripto { 
                fecha: get_fecha_actual(), 
                usuario: u.clone(), 
                blockchain: blockchain, 
                cripto: cripto.clone(), 
                cotizacion: cripto.obtener_cotizacion(), 
                monto: monto_cripto 
            };
            self.registrar_transaccion(transaccion);
            true
        } else {
            false
        }
    } else {
        false
    }
  }

  pub fn retirar_fiat(&mut self, dni: String, medio: Medio, monto_fiat: f64) -> bool {
    let user = self.usuarios.iter_mut().find(|u| u.dni == dni);
    if let Some(u) = user {
      if !u.esta_validado() {
        return false;
      }
      
      if !u.tiene_balance_suficiente_fiat(monto_fiat) {
        return false;
      }
      if u.actualizar_balance_fiat(-monto_fiat) {
        self.registrar_transaccion(Transaccion::RetiroFiat { 
          fecha: get_fecha_actual(), 
          usuario: u.clone(), 
          monto: monto_fiat, 
          medio 
        });
          true
      } else {
          false
      }
    } else {
        false 
    }
  }

  fn mostrar_informacion_criptos(&self) {
    let criptos = vec![Prefijo::BTC, Prefijo::ETH, Prefijo::SOL, Prefijo::DODGE, Prefijo::XLM, Prefijo::USDT];
    for cripto in criptos {
        println!("{}", cripto.obtener_resumen());
    }
    }

}

impl Prefijo {
  fn cotizacion(&self) -> f64 {
    self.obtener_cotizacion() // Usa el trait Cotizador
  }

  fn get_info(&self) -> CriptoMoneda {
    match self {
      Prefijo::BTC => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "Bitcoin".to_string(), prefijo: "BTC".to_string()}]},
      Prefijo::ETH => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "Ethereum".to_string(), prefijo: "ETH".to_string()}]},
      Prefijo::SOL => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "Solana".to_string(), prefijo: "SOL".to_string()}]},
      Prefijo::DODGE => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "DodgeCoin".to_string(), prefijo: "DODGE".to_string()}]},
      Prefijo::XLM => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "Lumen".to_string(), prefijo: "XLM".to_string()}]},
      Prefijo::USDT => CriptoMoneda { valor: self.obtener_cotizacion(), blockchains: vec![Blockchain{nombre: "Tether".to_string(), prefijo: "USDT".to_string()}]},
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