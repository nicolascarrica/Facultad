// 4 -Se requiere implementar un sistema de ventas de productos. De cada producto se 
// conoce el nombre, una categoría y un precio base, y algunos productos pueden tener 
// descuentos aplicables dependiendo de la categoría. Además, se debe registrar al vendedor 
// que realizó la venta y al cliente. De ellos se conoce nombre, apellido, dirección, dni y del 
// vendedor nro de legajo, antigüedad y salario. Los clientes pueden tener un beneficio de 
// descuento si tienen suscripción al newsletter, de ser así se tiene el correo electrónico del 
// mismo. 
 
// El sistema debe permitir registrar las ventas realizadas y asociar el medio de pago utilizado. 
// Los medios de pago aceptados son: tarjeta de crédito, tarjeta de débito, transferencia 
// bancaria y efectivo. 
 
 
// Implemente las estructuras, funciones asociadas y traits necesarios para resolver las 
// siguientes acciones: 
 
// ➢   Crear una venta con: fecha, cliente, vendedor, medio de pago y un listado de 
// productos con sus cantidades. 
// ➢   Calcular el precio final de una venta en base a los productos que hay en ella. Para 
// calcularlo tenga en cuenta que pueden haber determinados productos de alguna 
// categoría donde debería aplicarse un descuento. Tanto la categoría como el 
// porcentaje de descuento a aplicar son datos que le brinda el sistema. Es decir el 
// sistema tiene una lista de las categorías con el descuento a aplicar. Además se debe 
// aplicar un porcentaje de descuento general si el cliente tiene suscripción al 
// newsletter. 
// ➢  Para llevar un control de las ventas realizadas, se debe implementar un reporte que 
// permita visualizar las ventas totales por categoría de producto y otro por vendedor.

use std::collections::HashMap;

use crate::tp03::ej03::Fecha;

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

#[derive(Debug, Hash, PartialEq, Eq, Clone)]
struct Persona {
  nombre: String,
  apellido: String,
  direccion: String,
  dni: String,
}

#[derive(Clone)]
struct Cliente {
  info: Persona,
  newsletter: Option<String>
}

#[derive(Debug,Clone, Hash, PartialEq, Eq)]
struct Vendedor {
  info: Persona,
  legajo: String,
  antiguedad: u8,
  salario: u32,
}

#[derive(Clone)]
enum MedioDePago {
  TarjetaDeCredito,
  TarjetaDeDebito,
  Transferencia,
  Efectivo
}

#[derive(Clone)]
struct Venta {
  numero: u32,
  fecha: Fecha,
  cliente: Cliente,
  vendedor: Vendedor,
  pago: MedioDePago,
  productos: Vec<Producto>
}

impl Venta {
  fn new(
    numero: u32,
    fecha: Fecha,
    cliente: Cliente,
    vendedor: Vendedor,
    pago: MedioDePago,
    productos: Vec<Producto>
  ) -> Venta {
    Venta {
      numero,
      fecha,
      cliente,
      vendedor,
      pago,
      productos,
    }
  }
}
struct Sistema {
  ventas: Vec<Venta>
}

impl Sistema {
  fn new() -> Sistema {
    Sistema {
      ventas: Vec::new()
    }
  }

  fn crear_venta(
    &mut self,
    numero: u32,
    fecha: Fecha,
    cliente: Cliente,
    vendedor: Vendedor,
    pago: MedioDePago,
    productos: Vec<Producto>
  ){
    self.ventas.push(Venta::new(numero, fecha, cliente, vendedor, pago, productos));
  }

  fn obtener_descuento(&self, producto: &Producto) -> f64{
    match producto.categoria {
      Categoria::Electrodomesticos => producto.precio_base*0.3,
      Categoria::Indumentaria => producto.precio_base*0.15,
      Categoria::Hogar => producto.precio_base*0.20,
      Categoria::Otro => producto.precio_base*0.1
    }
  }

  fn calcular_precio_final(&self, numero_venta: u32) -> Option<f64> {
    self.ventas
        .iter()
        .find(|v| v.numero == numero_venta)
        .map(|venta| {
          let total = venta.productos
          .iter()
          .map(|p| p.precio_base - self.obtener_descuento(p))
          .sum();
          
          if venta.cliente.newsletter.is_some() {
            total*0.9 // descuento 10% nl
          } else {
            total
          }
        })
  }

  fn reporte_ventas(&self) -> Option<(HashMap<Categoria, u32>, HashMap<Vendedor, u32>)> {
    if self.ventas.is_empty() {
      return None;
    }

    let mut categoria_map : HashMap<Categoria, u32> = HashMap::new();
    let mut vendedor_map : HashMap<Vendedor, u32> = HashMap::new();
    
    self.ventas.iter().for_each(|venta| {
      *vendedor_map.entry(venta.vendedor.clone()).or_insert(0) += 1;

      venta.productos.iter().for_each(|producto| {
        *categoria_map.entry(producto.categoria.clone()).or_insert(0) += 1;
      });
    });

    Some((categoria_map, vendedor_map))
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
      newsletter: if newsletter { Some("Clec@example.com".to_string()) } else { None },
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
  fn test_sistema_new() {
    let sistema = Sistema::new();
    assert!(sistema.ventas.is_empty());

  }

  #[test]
  fn test_sistema_crar_venta(){
    let mut sistema = Sistema::new();
    let fecha = Fecha::new(25,5,2025);

    let cliente = crear_cliente(true);
    let vendedor = crear_vendedor();
    let producto1 = Producto::new("Laptop", Categoria::Electrodomesticos, 1500.0);
    let producto2 = Producto::new("Remera", Categoria::Indumentaria, 25.0);

    let productos = vec![producto1, producto2];

    sistema.crear_venta(1, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);

    assert!(!sistema.ventas.is_empty());
    assert!(sistema.ventas.len() == 1);
    assert_eq!(sistema.ventas[0].vendedor.info.nombre, "Oscar".to_string());
  }

  #[test]
  fn descuento_categoria_test() {
    let sistema = Sistema::new();
    let p1 = Producto::new("Heladera", Categoria::Electrodomesticos, 1000.0);
    let p2 = Producto::new("Camisa", Categoria::Indumentaria, 200.0);
    let p3 = Producto::new("Silla", Categoria::Hogar, 300.0);
    let p4 = Producto::new("Libro", Categoria::Otro, 100.0);
    
    assert_eq!(sistema.obtener_descuento(&p1), 300.0);
    assert_eq!(sistema.obtener_descuento(&p2), 30.0);
    assert_eq!(sistema.obtener_descuento(&p3), 60.0);
    assert_eq!(sistema.obtener_descuento(&p4), 10.0);
 }

 #[test]
  fn test_calcular_precio_final_con_newsletter() {
    let mut sistema = Sistema::new();
    let fecha = Fecha::new(10, 5, 2025);
    let cliente = crear_cliente(true);
    let vendedor = crear_vendedor();
    let productos = vec![
      Producto::new("Smartwatch", Categoria::Electrodomesticos, 1000.0), // descuento 30% = 700.0
      Producto::new("Camiseta Messi", Categoria::Indumentaria, 200.0),   // 15% = 170.0
    ];
    sistema.crear_venta(1, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);
    let precio = sistema.calcular_precio_final(1);
    assert_eq!(precio, Some(783.0)); // (700 + 170) * 0.9 = 783
  }

  #[test]
  fn test_calcular_precio_final_sin_newsletter() {
    let mut sistema = Sistema::new();
    let fecha = Fecha::new(11, 5, 2025);
    let cliente = crear_cliente(false);
    let vendedor = crear_vendedor() ;
    let productos = vec![Producto::new("TV", Categoria::Electrodomesticos, 1000.0)];
    
    sistema.crear_venta(2, fecha, cliente, vendedor, MedioDePago::Efectivo, productos);
    let precio = sistema.calcular_precio_final(2);
    assert_eq!(precio, Some(700.0)); // sin descuento adicional
  }


  #[test]
  fn test_calcular_precio_final_venta_inexistente() {
    let sistema = Sistema::new();
    assert_eq!(sistema.calcular_precio_final(99), None);
  }

  #[test]
  fn test_reporte_ventas_con_ventas() {
    let mut sistema = Sistema::new();
    let fecha = Fecha::new(25, 5, 2025);
    let cliente = crear_cliente(true);
    let vendedor1 = crear_vendedor();

    let vendedor2 = Vendedor {
      info: Persona {
        nombre: "Nicolas".into(),
        apellido: "Carrica".into(),
        direccion: "Calle 41".into(),
        dni: "40772".into(),
      },
        legajo: "456".into(),
        antiguedad: 2,
        salario: 45000,
    };

    sistema.crear_venta(
      1,
      fecha.clone(),
      cliente.clone(),
      vendedor1.clone(),
      MedioDePago::Efectivo,
      vec![
        Producto::new("TV", Categoria::Electrodomesticos, 1000.0),
        Producto::new("Mesa", Categoria::Hogar, 500.0),
      ],
    );

    sistema.crear_venta(
      2,
      fecha,
      cliente,
      vendedor2.clone(),
      MedioDePago::TarjetaDeCredito,
      vec![
        Producto::new("Silla", Categoria::Hogar, 300.0),
        Producto::new("Camiseta Boca", Categoria::Indumentaria, 250.0),
      ],
    );

    if let Some((cat_map, vend_map))= sistema.reporte_ventas() {
      assert_eq!(cat_map.get(&Categoria::Electrodomesticos), Some(&1));
      assert_eq!(cat_map.get(&Categoria::Hogar), Some(&2));
      assert_eq!(cat_map.get(&Categoria::Indumentaria), Some(&1));

      assert_eq!(vend_map.get(&vendedor1), Some(&1));
      assert_eq!(vend_map.get(&vendedor2), Some(&1));
    } else {
      panic!("Error al obtener el reporte de ventas, se obtuvo NONE");
    }
  }

  #[test]
  fn test_reporte_sin_ventas() {
    let sistema = Sistema::new();
    assert_eq!(sistema.reporte_ventas(), None);
  }

}