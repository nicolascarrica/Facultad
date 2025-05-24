// 1- Escriba una función que reciba un vector de números enteros y retorna la cantidad de 
// números primos. Cree un trait para la determinación del número primo e impleméntelo 
// según corresponda. Utilice la función iter sobre el vector y aplique un closure para 
// resolverlo.

trait EsPrimo {
    fn es_primo(&self) -> bool;
}

impl EsPrimo for i32 {
    fn es_primo(&self) -> bool {
        if *self <= 1 {
            return false
        }

        for n in 2..(self/2) + 1 {
            if self % n == 0 {
                return false;
            }
        }

        true
    }
}

fn cantidad_primos<T>(numeros: &Vec<T>) -> i32 where T: EsPrimo {
    let mut cantidad = 0;
    numeros.iter().for_each(|n| {
        if n.es_primo() {
            cantidad += 1;
        }
    });

    cantidad
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_cantidad_primos_vacia() {
        let vector: Vec<i32> = Vec::new();
        assert_eq!(cantidad_primos(&vector), 0);
    }

    #[test]
    fn test_cantidad_primos_mixto() {
        let vector = vec![1, 2, 4, 6, 7, 9];
        assert_eq!(cantidad_primos(&vector), 2);
    }
}