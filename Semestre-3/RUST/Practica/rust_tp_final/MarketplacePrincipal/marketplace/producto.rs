use ink::prelude::string::String;
use ink::primitives::AccountId;
#[cfg(feature = "std")]

use crate::enums::Categoria;

#[derive(Debug, Clone)]
#[ink::scale_derive(Encode, Decode, TypeInfo)]
#[cfg_attr(feature = "std", derive(ink::storage::traits::StorageLayout))]
pub struct Producto {
    pub id: u64,
    pub vendedor: AccountId,
    pub nombre: String,
    pub descripcion: String,
    pub precio: u128,
    pub stock: u32,
    pub categoria: Categoria,
}

impl Producto {
    /// Crea un nuevo producto listo para ser publicado por un vendedor.
    ///
    /// # Parámetros
    /// - `id`: identificador único del producto
    /// - `vendedor`: cuenta del vendedor que lo publica
    /// - `nombre`: nombre del producto
    /// - `descripcion`: descripción del producto
    /// - `precio`: precio unitario en tokens
    /// - `stock`: cantidad disponible
    /// - `categoria`: categoría del producto
    pub fn new(id: u64, vendedor: AccountId, nombre: String, descripcion: String, precio: u128, stock: u32, categoria: Categoria) -> Self {
        Self {
            id,
            vendedor,
            nombre,
            descripcion,
            precio,
            stock,
            categoria,
        }
    }

    /// Verifica si hay suficiente stock disponible para una compra.
    ///
    /// # Parámetros
    /// - `cantidad`: cantidad deseada del producto
    /// # Retorna
    /// - `true` si hay suficiente stock, `false` si no.
    pub fn tiene_stock(&self, cantidad: u32) -> bool {
        self.stock >= cantidad
    }

    /// Reduce el stock del producto en una cantidad determinada.
    /// No realiza cambios si la cantidad solicitada excede el stock disponible.
    /// # Parámetros
    /// - `cantidad`: cantidad a descontar del stock
    pub fn reducir_stock(&mut self, cantidad: u32) {
        if self.tiene_stock(cantidad) {
            self.stock -= cantidad;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn account(id: u8) -> AccountId {
        AccountId::from([id; 32])
    }

    #[test]
    fn crear_producto_funciona() {
        let producto = Producto::new(1, account(1), "Mouse".into(), "Mouse inalámbrico".into(), 1500, 10, Categoria::Tecnologia);
        assert_eq!(producto.nombre, "Mouse");
        assert_eq!(producto.precio, 1500);
        assert_eq!(producto.stock, 10);
    }

    #[test]
    fn tiene_stock_true() {
        let producto = Producto::new(1, account(1), "Zapatilla".into(), "Running".into(), 5000, 20, Categoria::Indumentaria);
        assert!(producto.tiene_stock(5));
    }

    #[test]
    fn tiene_stock_false() {
        let producto = Producto::new(1, account(1), "Heladera".into(), "Con freezer".into(), 80000, 1, Categoria::Hogar);
        assert!(!producto.tiene_stock(2));
    }

    #[test]
    fn reducir_stock_funciona() {
        let mut producto = Producto::new(1, account(1), "Remera".into(), "Talle M".into(), 3000, 10, Categoria::Indumentaria);
        producto.reducir_stock(3);
        assert_eq!(producto.stock, 7);
    }

    #[test]
    fn reducir_stock_insuficiente_no_cambia() {
        let mut producto = Producto::new(1, account(1), "Remera".into(), "Talle M".into(), 3000, 2, Categoria::Indumentaria);
        producto.reducir_stock(5);
        assert_eq!(producto.stock, 2); // stock no cambia
    }
}

