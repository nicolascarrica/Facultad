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
