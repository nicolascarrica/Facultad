#![cfg_attr(not(feature = "std"), no_std, no_main)]
mod usuario;
mod enums;
mod errores;
mod calificacion;
mod orden;
mod producto;
#[ink::contract]
mod marketplace {
    use ink::storage::Mapping;

    use crate::{enums::{Categoria, EstadoOrden, Rol}, errores::ErrorMarketplace, orden::Orden, producto::Producto, usuario::Usuario};


    /// Defines the storage of your contract.
    /// Add new fields to the below struct in order
    /// to add new static storage fields to your contract.
    #[ink(storage)]
    pub struct Marketplace {
        pub usuarios: Mapping<AccountId, Usuario>,
        pub productos: Mapping<u64, Producto>,
        pub ordenes: Mapping<u64, Orden>,
        pub productos_por_usuario: Mapping<AccountId, Vec<u64>>,
        pub contador_ordenes: u64,
        pub contador_productos: u64,
    }

    impl Marketplace {
        /// Crea una nueva instancia del contrato Marketplace.
        /// # Retorna
        /// Un contrato con mapas vacíos y contadores en cero.
        #[ink(constructor)]
        pub fn new() -> Self {
            Self {
                usuarios: Mapping::default(),
                productos: Mapping::default(),
                ordenes: Mapping::default(),
                productos_por_usuario: Mapping::default(),
                contador_ordenes: 0,
                contador_productos: 0,
            }
        }

        /// Registra un nuevo usuario en el sistema con su rol.
        /// # Parámetros
        /// - `username`: nombre público visible del usuario.
        /// - `rol`: rol del usuario (Comprador, Vendedor o Ambos).
        /// # Retorna
        /// - `Ok(())` si el registro fue exitoso.
        /// - `Err(ErrorMarketplace::UsuarioYaRegistrado)` si el usuario ya existe.
        #[ink(message)]
        pub fn registrar_usuario(&mut self, username: String, rol: Rol) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            if self.usuarios.get(&caller).is_some() {
                return Err(ErrorMarketplace::UsuarioYaRegistrado);
            }
            let nuevo = Usuario::new(username, rol);
            self.usuarios.insert(caller, &nuevo);
            Ok(())
        }

        /// Cambia el rol de un usuario previamente registrado.
        /// Útil si el usuario desea comenzar a vender productos, por ejemplo.
        /// # Parámetros
        /// - `nuevo_rol`: el nuevo rol a asignar.
        /// # Retorna
        /// - `Ok(())` si el cambio fue exitoso.
        /// - `Err(ErrorMarketplace::UsuarioNoExiste)` si la cuenta no estaba registrada.
        #[ink(message)]
        pub fn cambiar_rol(&mut self, nuevo_rol: Rol) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            let mut usuario = self.usuarios.get(caller).ok_or(ErrorMarketplace::UsuarioNoExiste)?;
            usuario.set_rol(nuevo_rol);
            self.usuarios.insert(caller, &usuario);
            Ok(())
        }


        /// Publica un nuevo producto en el marketplace.
        ///
        /// # Parámetros
        /// - `nombre`, `descripcion`, `precio`, `stock`, `categoria`: datos del producto.
        ///
        /// # Retorna
        /// - `Ok(())` si se publicó correctamente.
        /// - Error si el usuario no es vendedor o no existe.
        #[ink(message)]
        pub fn publicar_producto(&mut self, nombre: String, descripcion: String, precio: u128, stock: u32, categoria: Categoria) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            let usuario = self.usuarios.get(&caller).ok_or(ErrorMarketplace::UsuarioNoExiste)?;
            if usuario.rol != Rol::Vendedor && usuario.rol != Rol::Ambos {
                return Err(ErrorMarketplace::NoEsVendedor);
            }
            let producto_id = self.contador_productos;
            let nuevo = Producto::new(producto_id, caller, nombre, descripcion, precio, stock, categoria);
            self.productos.insert(producto_id, &nuevo);
            let mut lista = self.productos_por_usuario.get(&caller).unwrap_or_default();
            lista.push(producto_id);
            self.productos_por_usuario.insert(caller, &lista);
            self.contador_productos += 1;
            Ok(())
        }

        /// Devuelve los productos publicados por el usuario actual.
        /// # Retorna
        /// Un vector con todos los productos asociados a la cuenta que llama.
        #[ink(message)]
        pub fn ver_productos_propios(&self) -> Vec<Producto> {
            let caller = self.env().caller();
            let ids = self.productos_por_usuario.get(&caller).unwrap_or_default();
            ids.into_iter()
                .filter_map(|id| self.productos.get(&id))
                .collect()
        }

        /// Consulta las calificaciones promedio del usuario llamador.
        /// Devuelve el puntaje promedio que el usuario tiene como Comprador y como Vendedor.
        /// Si el usuario aún no fue calificado en alguno de los roles, retorna `None` para ese campo.
        /// # Retorna
        /// - Tupla `(promedio_como_comprador, promedio_como_vendedor)`.
        /// - Si el usuario no existe, devuelve `(None, None)`.
        #[ink(message)]
        pub fn reputacion_actual(&self) -> (Option<u128>, Option<u128>) {
            let caller = self.env().caller();
            match self.usuarios.get(caller) {
                Some(u) => (u.promedio_como_comprador(), u.promedio_como_vendedor()),
                None => (None, None),
            }
        }

        /// Crea una nueva orden de compra con los productos seleccionados. 
        /// # Parámetros
        /// - `productos`: un vector de tuplas con ID de producto y cantidad solicitada.
        ///
        /// # Requiere
        /// - Que el llamador esté registrado como `Comprador` o `Ambos`.
        /// - Que todos los productos existan y tengan suficiente stock.
        ///
        /// # Efectos
        /// - Se reduce el stock de cada producto.
        /// - Se crea una nueva orden con estado `Pendiente`.
        ///
        /// # Errores
        /// - `UsuarioNoExiste`: si el llamador no está registrado.
        /// - `NoEsComprador`: si el rol del usuario no permite comprar.
        /// - `ProductoNoExiste`: si algún producto no existe.
        /// - `StockInsuficiente`: si algún producto no tiene suficiente stock.
        #[ink(message)]
        pub fn crear_orden(&mut self, productos: Vec<(u64, u32)>) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            let usuario = self.usuarios.get(&caller).ok_or(ErrorMarketplace::UsuarioNoExiste)?;
            if usuario.rol != Rol::Comprador && usuario.rol != Rol::Ambos {
                return Err(ErrorMarketplace::NoEsComprador);
            }

            let mut total: u128 = 0;
            let mut vendedor: Option<AccountId> = None;

            for (id, cantidad) in &productos {
                let mut prod = self.productos.get(id).ok_or(ErrorMarketplace::ProductoNoExiste)?;
                if !prod.tiene_stock(*cantidad) {
                    return Err(ErrorMarketplace::StockInsuficiente);
                }
                prod.reducir_stock(*cantidad);
                self.productos.insert(*id, &prod);
                total += prod.precio * (*cantidad as u128);
                if vendedor.is_none() {
                    vendedor = Some(prod.vendedor);
                }
            }

            let vendedor_final = vendedor.ok_or(ErrorMarketplace::ProductoNoExiste)?; // ya está validado antes
            let orden = Orden::new(self.contador_ordenes, caller, vendedor_final, productos, total);
            self.ordenes.insert(self.contador_ordenes, &orden);
            self.contador_ordenes += 1;
            Ok(())
        }

        /// Cambia el estado de una orden según la acción del llamador.
        /// # Parámetros
        /// - `orden_id`: ID de la orden a modificar.
        /// - `accion`: una cadena que puede ser `"enviar"`, `"recibir"`, `"solicitar_cancelacion"` o `"confirmar_cancelacion"`.
        ///
        /// # Requiere
        /// - Que la orden exista.
        /// - Que el llamador tenga permisos sobre la orden (comprador o vendedor).
        /// - Que el estado actual de la orden permita la acción.
        ///
        /// # Efectos
        /// - Cambia el estado de la orden y la actualiza en almacenamiento.
        ///
        /// # Errores
        /// - `OrdenNoExiste`: si la orden no se encuentra.
        /// - `EstadoInvalido`: si el estado actual impide la acción.
        /// - `NoAutorizado`: si el llamador no tiene permisos.
        #[ink(message)]
        pub fn cambiar_estado_orden(&mut self, orden_id: u64, accion: String) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            let mut orden = self.ordenes.get(&orden_id).ok_or(ErrorMarketplace::OrdenNoExiste)?;
        
            match accion.as_str() {
                "enviar" => orden.marcar_enviada(caller)?,
                "recibir" => orden.marcar_recibida(caller)?,
                "solicitar_cancelacion" => orden.solicitar_cancelacion(caller)?,
                "confirmar_cancelacion" => orden.confirmar_cancelacion(caller)?,
                _ => return Err(ErrorMarketplace::EstadoInvalido),
            }
        
            self.ordenes.insert(orden_id, &orden);
            Ok(())
        }

        /// Califica al otro usuario involucrado en una orden.
        /// # Parámetros
        /// - `orden_id`: ID de la orden completada.
        /// - `puntaje`: valor de calificación (entre 1 y 5).
        ///
        /// # Requiere
        /// - Que la orden exista y esté en estado `Recibida`.
        /// - Que el llamador haya participado en la orden (comprador o vendedor).
        ///
        /// # Efectos
        /// - Registra una calificación en el perfil del otro usuario.
        ///
        /// # Errores
        /// - `OrdenNoExiste`: si la orden no se encuentra.
        /// - `EstadoInvalido`: si la orden aún no fue recibida.
        /// - `NoAutorizado`: si el llamador no participó en la orden.
        /// - `PuntajeInvalido`, `YaCalificado`: si se viola alguna restricción de calificación.
        #[ink(message)]
        pub fn calificar_usuario(&mut self, orden_id: u64, puntaje: u8) -> Result<(), ErrorMarketplace> {
            let caller = self.env().caller();
            let orden = self.ordenes.get(&orden_id).ok_or(ErrorMarketplace::OrdenNoExiste)?;
            
            if orden.estado != EstadoOrden::Recibida {
                return Err(ErrorMarketplace::EstadoInvalido);
            }
            
            if caller == orden.comprador {
                let mut vendedor = self.usuarios.get(&orden.vendedor).ok_or(ErrorMarketplace::UsuarioNoExiste)?;
                vendedor.calificar_como_vendedor(caller, puntaje, orden_id)?;
                self.usuarios.insert(orden.vendedor, &vendedor);
            } else if caller == orden.vendedor {
                let mut comprador = self.usuarios.get(&orden.comprador).ok_or(ErrorMarketplace::UsuarioNoExiste)?;
                comprador.calificar_como_comprador(caller, puntaje, orden_id)?;
                self.usuarios.insert(orden.comprador, &comprador);
            } else {
                return Err(ErrorMarketplace::NoAutorizado);
            }
            
            Ok(())
        }
    }
}

    /// Unit tests in Rust are normally defined within such a `#[cfg(test)]`
    /// module and test functions are marked with a `#[test]` attribute.
    /// The below code is technically just normal Rust code.
    #[cfg(test)]
    mod tests {
        /// Imports all the definitions from the outer scope so we can use them here.
        use super::*;

        /// We test if the default constructor does its job.
        #[ink::test]
        fn default_works() {
            let marketplace = Marketplace::default();
            assert_eq!(marketplace.get(), false);
        }

        /// We test a simple use case of our contract.
        #[ink::test]
        fn it_works() {
            let mut marketplace = Marketplace::new(false);
            assert_eq!(marketplace.get(), false);
            marketplace.flip();
            assert_eq!(marketplace.get(), true);
        }
    }


    /// This is how you'd write end-to-end (E2E) or integration tests for ink! contracts.
    ///
    /// When running these you need to make sure that you:
    /// - Compile the tests with the `e2e-tests` feature flag enabled (`--features e2e-tests`)
    /// - Are running a Substrate node which contains `pallet-contracts` in the background
    #[cfg(all(test, feature = "e2e-tests"))]
    mod e2e_tests {
        /// Imports all the definitions from the outer scope so we can use them here.
        use super::*;

        /// A helper function used for calling contract messages.
        use ink_e2e::ContractsBackend;

        /// The End-to-End test `Result` type.
        type E2EResult<T> = std::result::Result<T, Box<dyn std::error::Error>>;

        /// We test that we can upload and instantiate the contract using its default constructor.
        #[ink_e2e::test]
        async fn default_works(mut client: ink_e2e::Client<C, E>) -> E2EResult<()> {
            // Given
            let mut constructor = MarketplaceRef::default();

            // When
            let contract = client
                .instantiate("marketplace", &ink_e2e::alice(), &mut constructor)
                .submit()
                .await
                .expect("instantiate failed");
            let call_builder = contract.call_builder::<Marketplace>();

            // Then
            let get = call_builder.get();
            let get_result = client.call(&ink_e2e::alice(), &get).dry_run().await?;
            assert!(matches!(get_result.return_value(), false));

            Ok(())
        }

        /// We test that we can read and write a value from the on-chain contract.
        #[ink_e2e::test]
        async fn it_works(mut client: ink_e2e::Client<C, E>) -> E2EResult<()> {
            // Given
            let mut constructor = MarketplaceRef::new(false);
            let contract = client
                .instantiate("marketplace", &ink_e2e::bob(), &mut constructor)
                .submit()
                .await
                .expect("instantiate failed");
            let mut call_builder = contract.call_builder::<Marketplace>();

            let get = call_builder.get();
            let get_result = client.call(&ink_e2e::bob(), &get).dry_run().await?;
            assert!(matches!(get_result.return_value(), false));

            // When
            let flip = call_builder.flip();
            let _flip_result = client
                .call(&ink_e2e::bob(), &flip)
                .submit()
                .await
                .expect("flip failed");

            // Then
            let get = call_builder.get();
            let get_result = client.call(&ink_e2e::bob(), &get).dry_run().await?;
            assert!(matches!(get_result.return_value(), true));

            Ok(())
        }
    
}



// #[ink(constructor)]
//         pub fn new() -> Self;

//         // --- Usuario ---
//         #[ink(message)]
//         pub fn registrar_usuario(&mut self, username: String, rol: Rol) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn cambiar_rol(&mut self, nuevo_rol: Rol) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn reputacion_actual(&self) -> (Option<f64>, Option<f64>);

//         // --- Producto ---
//         #[ink(message)]
//         pub fn publicar_producto(&mut self, nombre: String, descripcion: String, precio: u128, stock: u32, categoria: Categoria) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn ver_mis_productos(&self) -> Vec<Producto>;

//         // --- Orden ---
//         #[ink(message)]
//         pub fn crear_orden(&mut self, productos: Vec<(u64, u32)>) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn marcar_orden_enviada(&mut self, orden_id: u64) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn marcar_orden_recibida(&mut self, orden_id: u64) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn cancelar_orden(&mut self, orden_id: u64) -> Result<(), ErrorMarketplace>;

//         // --- Calificación ---
//         #[ink(message)]
//         pub fn calificar_vendedor(&mut self, orden_id: u64, puntaje: u8) -> Result<(), ErrorMarketplace>;

//         #[ink(message)]
//         pub fn calificar_comprador(&mut self, orden_id: u64, puntaje: u8) -> Result<(), ErrorMarketplace>;
//     }
