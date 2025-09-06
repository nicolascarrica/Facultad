#[derive(Debug, Clone)]
pub struct Fecha {
    dia: u32,
    mes: u32,
    anio: u32,
}

impl Fecha {
  pub fn new(dia: u32, mes: u32, anio: u32) -> Fecha {
    Fecha { dia, mes, anio }
  }

  fn es_bisiesto(&self) -> bool {
    let estado: bool = (self.anio % 4 == 0) && (self.anio % 100 != 0) || (self.anio % 400 == 0);
    return estado;
  }

  //helper para contar los dias que tiene el mes;
  fn cantidad_de_dias(&self, mes:u32) -> u32 {
    let dias_del_mes: u32 = match mes {
      1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
      4 | 6 | 9 | 11 => 30,
      2 => {
        if self.es_bisiesto() {
          29
        } else {
          28
        }
      }
      _=> 0,
    };

    dias_del_mes
  }

  pub fn es_fecha_valida(&self) -> bool {
    let mut estado: bool = false;
    if self.mes > 0 && self.mes < 13 && self.anio > 0 {
      let dias_del_mes: u32 = self.cantidad_de_dias(self.mes);
      estado = dias_del_mes !=0 && (self.dia >= 1 && self.dia <= dias_del_mes);
    }
    estado
  }

  pub fn sumar_dias(&mut self, dias: u32){
    let mut dias_del_mes = self.cantidad_de_dias(self.mes);
    self.dia += dias;

     // Mientras el dia actual sea mayor que la cantidad de dias en el mes actual
    while self.dia > dias_del_mes{
      // Se le restan la cantidad de dias al mes actual
      self.dia -= dias_del_mes;
      // avanza al siguiente mes
      self.mes+=1;
      // si pasamos el mes doce, se incrementa el año y se pasa al mes 1
      if self.mes > 12{
        self.mes=1;
        self.anio+=1;
      }
      // se actualizan los dias del nuevo mes
      dias_del_mes = self.cantidad_de_dias(self.mes);
    } 
  }

  pub fn restar_dias(&mut self, mut dias: u32){
    // Mientras haya días para restar
    while dias !=0 {
      // Si la cantidad de dias a restar es mayor o igual que el dia actual
      if dias >= self.dia {
        dias -= self.dia;
        // Retrocedemos al mes anterior
        self.mes -= 1;
        // Si el mes es menor que 1, retrocedemos al año anterior
        if self.mes < 1{
          self.mes = 12;
          self.anio -= 1;
        }
        // Actualizamos la cantidad de dias en el nuevo mes
        self.dia = self.cantidad_de_dias(self.mes);
      } else {
        // Si la cantidad de dias a restar es menor que el dia actual,
        // simplemente restamos esa cantidad de días
        self.dia -= dias;
        dias = 0; // Ya no quedan dias por restar
      }
    }
  }

  pub fn es_mayor(&self, otra_fecha: &Fecha) -> bool {
    let mut mayor: bool = false;
    if self.anio > otra_fecha.anio {
        mayor = true;
    } else if self.anio == otra_fecha.anio && self.mes > otra_fecha.mes {
        mayor = true;
    } else if self.anio == otra_fecha.anio
        && self.mes == otra_fecha.mes
        && self.dia > otra_fecha.dia
    {
        mayor = true;
    }
    mayor
  }

  fn to_string(&self) -> String {
    format!("{:?}", self)
  }

  pub fn eq(&self, other: &Self) -> bool {
    self.to_string().eq(&other.to_string())
  }

}

#[cfg(test)]
mod test_fecha{
  use super::*;

  #[test]
  fn test_new(){
    let fecha = Fecha::new(17,12,1990);
    assert_eq!(fecha.dia, 17);
    assert_eq!(fecha.mes, 12);
    assert_eq!(fecha.anio, 1990);
  }

  #[test]
  fn test_es_biciesto(){
    let fecha1 = Fecha::new(1, 1, 2020); //divisible x4 y no por 100
    assert_eq!(fecha1.es_bisiesto(), true);

    let fecha2 = Fecha::new(1, 1, 1900); //divisible x 100, no por 400. No bisiesto.
    assert_eq!(fecha2.es_bisiesto(), false);

    let fecha3 = Fecha::new(1, 1, 2000); // divisible x 400. biciesto.
    assert_eq!(fecha3.es_bisiesto(), true);

    let fecha4 = Fecha::new(1, 1, 2023); // no divisible x4. No biciesto.
    assert_eq!(fecha4.es_bisiesto(), false);
  }

  #[test]
  fn test_cantidad_dias(){
    let fecha = Fecha::new(1, 1, 2023);
    assert_eq!(fecha.cantidad_de_dias(1), 31); // enero
    assert_eq!(fecha.cantidad_de_dias(3), 31); // Marzo
    assert_eq!(fecha.cantidad_de_dias(5), 31); // Mayo
    assert_eq!(fecha.cantidad_de_dias(7), 31); // Julio
    assert_eq!(fecha.cantidad_de_dias(8), 31); // Agosto
    assert_eq!(fecha.cantidad_de_dias(10), 31); // Octubre
    assert_eq!(fecha.cantidad_de_dias(12), 31); // Diciembre

    assert_eq!(fecha.cantidad_de_dias(4), 30); // abril
    assert_eq!(fecha.cantidad_de_dias(6), 30); // Junio
    assert_eq!(fecha.cantidad_de_dias(9), 30); // Septiembre
    assert_eq!(fecha.cantidad_de_dias(11), 30); // Noviembre

    assert_eq!(fecha.cantidad_de_dias(2), 28); // Febrero

    // Febrero en año bisiesto
    let fecha3 = Fecha::new(1, 2, 2020);
    assert_eq!(fecha3.cantidad_de_dias(2), 29);

    // Mes inválido
    assert_eq!(fecha.cantidad_de_dias(13), 0);
  }

  #[test]
  fn test_es_fecha_valida(){
    let fecha1 = Fecha::new(15, 10, 2023);
    assert_eq!(fecha1.es_fecha_valida(), true);

    let fecha2 = Fecha::new(32, 1, 2023);
    assert_eq!(fecha2.es_fecha_valida(), false);

    let fecha3 = Fecha::new(1, 0, 2022);
    assert!(!fecha3.es_fecha_valida());
  }

  #[test]
  fn test_sumar_dias(){
    let mut fecha1 = Fecha::new(15, 10, 2023);
    fecha1.sumar_dias(5);
    assert_eq!(fecha1.dia,20);
    assert_eq!(fecha1.mes, 10);
    assert_eq!(fecha1.anio, 2023);

    // Sumar días para cambiar de mes
    let mut fecha2 = Fecha::new(28, 2, 2023);
    fecha2.sumar_dias(5);
    assert_eq!(fecha2.dia, 5);
    assert_eq!(fecha2.mes, 3);
    assert_eq!(fecha2.anio, 2023);

    // Sumar días para cambiar de año
    let mut fecha3 = Fecha::new(30, 12, 2023);
    fecha3.sumar_dias(5);
    assert_eq!(fecha3.dia, 4);
    assert_eq!(fecha3.mes, 1);
    assert_eq!(fecha3.anio, 2024);

    // Sumar muchos días (cruzando varios meses y años)
    let mut fecha4 = Fecha::new(1, 1, 2023);
    fecha4.sumar_dias(365 + 31 + 29);  // 1 año + enero y febrero de 2024 (año bisiesto)
    assert_eq!(fecha4.dia, 1);
    assert_eq!(fecha4.mes, 3);
    assert_eq!(fecha4.anio, 2024);
  }
  
  #[test]
  fn test_restar_dias() {
    // Restar días dentro del mismo mes
    let mut fecha1 = Fecha::new(15, 10, 2023);
    fecha1.restar_dias(5);
    assert_eq!(fecha1.dia, 10);
    assert_eq!(fecha1.mes, 10);
    assert_eq!(fecha1.anio, 2023);

    // Restar días para cambiar de mes
    let mut fecha2 = Fecha::new(3, 3, 2023);
    fecha2.restar_dias(5);
    assert_eq!(fecha2.dia, 26);
    assert_eq!(fecha2.mes, 2);
    assert_eq!(fecha2.anio, 2023);

    // Restar días para cambiar de año
    let mut fecha3 = Fecha::new(2, 1, 2023);
    fecha3.restar_dias(5);
    assert_eq!(fecha3.dia, 28);
    assert_eq!(fecha3.mes, 12);
    assert_eq!(fecha3.anio, 2022);

    // Restar muchos días (cruzando varios meses y años)
    let mut fecha4 = Fecha::new(1, 3, 2024);  // 1 de marzo de 2024 (año bisiesto)
    fecha4.restar_dias(365 + 31 + 29);  // 1 año + enero y febrero de 2024
    assert_eq!(fecha4.dia, 1);
    assert_eq!(fecha4.mes, 1);
    assert_eq!(fecha4.anio, 2023);
  }

  #[test]
    fn test_es_mayor() {
      // Fechas con años diferentes
      let fecha1 = Fecha::new(1, 1, 2023);
      let fecha2 = Fecha::new(1, 1, 2022);
      assert!(fecha1.es_mayor(&fecha2));
      assert!(!fecha2.es_mayor(&fecha1));

      // Fechas con mismo año pero diferentes meses
      let fecha3 = Fecha::new(1, 2, 2023);
      let fecha4 = Fecha::new(1, 1, 2023);
      assert!(fecha3.es_mayor(&fecha4));
      assert!(!fecha4.es_mayor(&fecha3));

      // Fechas con mismo año y mes pero diferentes días
      let fecha5 = Fecha::new(2, 1, 2023);
      let fecha6 = Fecha::new(1, 1, 2023);
      assert!(fecha5.es_mayor(&fecha6));
      assert!(!fecha6.es_mayor(&fecha5));

      // Fechas iguales
      let fecha7 = Fecha::new(1, 1, 2023);
      let fecha8 = Fecha::new(1, 1, 2023);
      assert!(!fecha7.es_mayor(&fecha8));
      assert!(!fecha8.es_mayor(&fecha7));
    }


}
//// ACA COMIENZA EL EJERCICIO DE LAS VENTAS///

use std::collections::HashMap;
#[derive(Debug, Hash, PartialEq, Eq, Clone)]
enum Categoria {
    Electrodomesticos,
    Indumentaria,
    Hogar,
    Otro,
}

#[derive(Clone)]
struct Producto {
    nombre: String,
    categoria: Categoria,
    precio_base: f64,
}

impl Producto {
    fn new(nombre: &str, categoria: Categoria, precio_base: f64) -> Self {
        Producto {
            nombre: nombre.to_string(),
            categoria,
            precio_base,
        }
    }
}

trait DescuentoProducto {
    fn obtener_descuento(&self) -> f64;
}

impl DescuentoProducto for Producto {
    fn obtener_descuento(&self) -> f64 {
        match self.categoria {
            Categoria::Electrodomesticos => self.precio_base * 0.3,
            Categoria::Indumentaria => self.precio_base * 0.15,
            Categoria::Hogar => self.precio_base * 0.20,
            Categoria::Otro => self.precio_base * 0.1,
        }
    }
}

#[derive(Debug, Hash, Eq, Clone)]
struct Persona {
    nombre: String,
    apellido: String,
    direccion: String,
    dni: String,
}

impl PartialEq for Persona {
    fn eq(&self, other: &Self) -> bool {
        self.dni == other.dni
    }
}

#[derive(Clone)]
struct Cliente {
    info: Persona,
    newsletter: Option<String>,
}

trait DescuentoCliente {
    fn descuento_newsletter(&self, total: f64) -> f64;
}

impl DescuentoCliente for Cliente {
    fn descuento_newsletter(&self, total: f64) -> f64 {
        if self.newsletter.is_some() {
            total * 0.9
        } else {
            total
        }
    }
}

#[derive(Debug, Clone, Hash, Eq)]
struct Vendedor {
    info: Persona,
    legajo: String,
    antiguedad: u8,
    salario: u32,
}
impl PartialEq for Vendedor {
    fn eq(&self, other: &Self) -> bool {
        self.legajo == other.legajo
    }
}

#[derive(Clone)]
enum MedioDePago {
    TarjetaDeCredito,
    TarjetaDeDebito,
    Transferencia,
    Efectivo,
}

#[derive(Clone)]
struct Venta {
    numero: u32,
    fecha: Fecha,
    cliente: Cliente,
    vendedor: Vendedor,
    pago: MedioDePago,
    productos: Vec<(Producto, u32)>,
}

/// Struct creada para el entregable 2///
struct InformeCompra {
    fecha: Fecha,
    productos: Vec<(Producto, u32)>,
    monto_total: f64,
    medio_pago: MedioDePago,
}

impl Venta {
    fn new(
        numero: u32,
        fecha: Fecha,
        cliente: Cliente,
        vendedor: Vendedor,
        pago: MedioDePago,
        productos: Vec<(Producto, u32)>,
    ) -> Self {
        Venta {
            numero,
            fecha,
            cliente,
            vendedor,
            pago,
            productos,
        }
    }

    fn calcular_precio(&self) -> f64 {
        let subtotal: f64 = self.productos.iter().map(|(p, cant)| {
            (*cant as f64) * (p.precio_base - p.obtener_descuento())
        }).sum();
        self.cliente.descuento_newsletter(subtotal)
    }
}

struct Sistema {
    ventas: Vec<Venta>,
}

impl Sistema {
    fn new() -> Self {
        Sistema { ventas: vec![] }
    }

    fn crear_venta(
        &mut self,
        numero: u32,
        fecha: Fecha,
        cliente: Cliente,
        vendedor: Vendedor,
        pago: MedioDePago,
        productos: Vec<(Producto, u32)>,
    ) {
        self.ventas
            .push(Venta::new(numero, fecha, cliente, vendedor, pago, productos));
    }

    fn calcular_precio_final(&self, numero_venta: u32) -> Option<f64> {
        self.ventas
            .iter()
            .find(|v| v.numero == numero_venta)
            .map(|v| v.calcular_precio())
    }

    fn reporte_ventas(&self) -> Option<(HashMap<Categoria, u32>, HashMap<Vendedor, u32>)> {
        if self.ventas.is_empty() {
            return None;
        }

        let mut categoria_map = HashMap::new();
        let mut vendedor_map = HashMap::new();

        for venta in &self.ventas {
            *vendedor_map.entry(venta.vendedor.clone()).or_insert(0) += 1;
            for (producto, cantidad) in &venta.productos {
                *categoria_map.entry(producto.categoria.clone()).or_insert(0) += cantidad;
            }
        }

        Some((categoria_map, vendedor_map))
    }

// Implementar una funcionalidad que permita obtener un informe de compras realizadas por un cliente específico, filtrando solo aquellas en las que el monto total final de la venta sea mayor a un valor dado.

// Este informe debe incluir, ordenado cronológicamente, lo siguiente para cada compra:

// -Fecha de la venta

// -Productos adquiridos y sus cantidades

// -Monto total final de la venta

// -Medio de pago utilizado

// La consulta se debe realizar a partir de un identificador único del cliente (por ejemplo, su DNI o su correo electrónico, según cómo lo hayan modelado), y un monto mínimo a partir del cual incluir la venta en el informe.

// En caso de que el cliente no tenga compras que cumplan esa condición, el sistema debe reflejar esa situación de forma adecuada.

// 🔧 Esta funcionalidad debe implementarse como un método dentro del struct principal del sistema.

// 🧪 Además, deben incluir los tests necesarios para verificar el correcto funcionamiento de esta funcionalidad.

// 📌 Firma esperada del método:
// get_historial_compras(id: id_cliente, monto_minimo: f64) -> ??? // Cree un struct InfomreCompra con los campos correspondientes mas arriba

    fn get_historial_compras(&self, id_cliente: &str, monto_minimo: f64) -> Result<Vec<InformeCompra>, String> {
        let mut compras = Vec::new();

        for venta in self.ventas.iter() {
            if venta.cliente.info.dni == id_cliente && venta.calcular_precio() > monto_minimo {
                let informe_compra = InformeCompra {
                    fecha: venta.fecha.clone(),
                    productos: venta.productos.clone(),
                    monto_total: venta.calcular_precio(),
                    medio_pago: venta.pago.clone(),
                };
                compras.push(informe_compra);
            }
        }

        if compras.is_empty() {
            Err("No se encontraron compras para el cliente".to_string())
        } else {
            compras.sort_by(|a, b| a.fecha.cmp(&b.fecha));
            Ok(compras)
        }
    }
}



#[cfg(test)]
mod test {
    use super::*;

    fn crear_cliente(newsletter: bool) -> Cliente {
        Cliente {
            info: Persona {
                nombre: "Charles".to_string(),
                apellido: "Leclerc".to_string(),
                direccion: "Monaco 456".to_string(),
                dni: "1234".to_string(),
            },
            newsletter: if newsletter {
                Some("Clec@example.com".to_string())
            } else {
                None
            },
        }
    }

    fn crear_vendedor() -> Vendedor {
        Vendedor {
            info: Persona {
                nombre: "Oscar".to_string(),
                apellido: "Piastri".to_string(),
                direccion: "Australia".to_string(),
                dni: "4567".to_string(),
            },
            legajo: "123".to_string(),
            antiguedad: 3,
            salario: 60000,
        }
    }

    #[test]
    fn test_descuento_producto() {
        let p = Producto::new("Heladera", Categoria::Electrodomesticos, 1000.0);
        assert_eq!(p.obtener_descuento(), 300.0);
    }

    #[test]
    fn test_descuento_cliente_newsletter() {
        let c = crear_cliente(true);
        assert_eq!(c.descuento_newsletter(1000.0), 900.0);
    }

    #[test]
    fn test_sistema_crear_venta() {
        let mut sistema = Sistema::new();
        let fecha = Fecha::new(25, 5, 2025);
        let cliente = crear_cliente(true);
        let vendedor = crear_vendedor();
        let productos = vec![
            (Producto::new("TV", Categoria::Electrodomesticos, 1000.0), 1),
            (Producto::new("Remera", Categoria::Indumentaria, 200.0), 1)
        ];
        sistema.crear_venta(1, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);
        assert_eq!(sistema.ventas.len(), 1);
    }

    #[test]
    fn test_calcular_precio_final_con_newsletter() {
        let mut sistema = Sistema::new();
        let fecha = Fecha::new(10, 5, 2025);
        let cliente = crear_cliente(true);
        let vendedor = crear_vendedor();
        let productos = vec![
            (Producto::new("Smartwatch", Categoria::Electrodomesticos, 1000.0),1),
            (Producto::new("Camiseta", Categoria::Indumentaria, 200.0),1)
        ];
        sistema.crear_venta(1, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);
        assert_eq!(sistema.calcular_precio_final(1), Some(783.0)); // (700+170)*0.9
    }

    #[test]
    fn test_calcular_precio_final_sin_newsletter() {
        let mut sistema = Sistema::new();
        let fecha = Fecha::new(11, 5, 2025);
        let cliente = crear_cliente(false);
        let vendedor = crear_vendedor();
        let productos = vec![(Producto::new("TV", Categoria::Electrodomesticos, 1000.0),1)];
        sistema.crear_venta(2, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);
        assert_eq!(sistema.calcular_precio_final(2), Some(700.0));
    }

    #[test]
    fn test_reporte_ventas() {
        let mut sistema = Sistema::new();
        let fecha = Fecha::new(25, 5, 2025);
        let cliente = crear_cliente(false);
        let vendedor1 = crear_vendedor();
        let vendedor2 = Vendedor {
            info: Persona {
                nombre: "Nico".into(),
                apellido: "Carrica".into(),
                direccion: "La Plata".into(),
                dni: "7890".into(),
            },
            legajo: "456".into(),
            antiguedad: 5,
            salario: 50000,
        };

        sistema.crear_venta(
            1,
            fecha.clone(),
            cliente.clone(),
            vendedor1.clone(),
            MedioDePago::Efectivo,
            vec![
                (Producto::new("TV", Categoria::Electrodomesticos, 1000.0), 1) ,
                (Producto::new("Mesa", Categoria::Hogar, 500.0), 1)
            ],
        );

        sistema.crear_venta(
            2,
            fecha,
            cliente,
            vendedor2.clone(),
            MedioDePago::TarjetaDeCredito,
            vec![
                (Producto::new("Silla", Categoria::Hogar, 300.0), 1),
                (Producto::new("Remera", Categoria::Indumentaria, 250.0),1)
            ],
        );

        let (cat_map, vend_map) = sistema.reporte_ventas().unwrap();
        assert_eq!(cat_map.get(&Categoria::Electrodomesticos), Some(&1));
        assert_eq!(cat_map.get(&Categoria::Hogar), Some(&2));
        assert_eq!(cat_map.get(&Categoria::Indumentaria), Some(&1));
        assert_eq!(vend_map.get(&vendedor1), Some(&1));
        assert_eq!(vend_map.get(&vendedor2), Some(&1));
    }
}
