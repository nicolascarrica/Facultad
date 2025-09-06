#[ink::scale_derive(Encode, Decode, TypeInfo)]
#[cfg_attr(feature = "std", derive(ink::storage::traits::StorageLayout))]
#[derive(Debug, PartialEq, Clone)]

/// Representa los posibles roles de un usuario dentro de la plataforma.
pub enum Rol {
    Comprador,
    Vendedor,
    Ambos,
}

#[ink::scale_derive(Encode, Decode, TypeInfo)]
#[cfg_attr(feature = "std", derive(ink::storage::traits::StorageLayout))]
#[derive(Debug, PartialEq, Clone)]
/// Representa los posibles estados de una orden de compra.
pub enum EstadoOrden {
    Pendiente,
    Enviada,
    Recibida,
    Cancelada,
}


#[ink::scale_derive(Encode, Decode, TypeInfo)]
#[cfg_attr(feature = "std", derive(ink::storage::traits::StorageLayout))]
#[derive(Debug, PartialEq, Clone)]
/// Representa las posibles categorias de un producto.
pub enum Categoria {
    Tecnologia,
    Indumentaria,
    Alimentos,
    Hogar,
    Otro,
}