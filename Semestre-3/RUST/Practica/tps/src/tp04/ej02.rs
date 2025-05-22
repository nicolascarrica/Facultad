// 2- Dado el siguiente struct: 
 
// struct Persona<'a>{ 
//     nombre:&'a str, 
//     apellido:&'a str, 
//     direccion:&'a str, 
//     ciudad:&'a str, 
//     salario:f64, 
//     edad:u8,  
// } 
 
// a- Escriba una función que reciba un vector de personas y otro parámetro que indica un 
// salario y retorna un listado de personas donde el salario es mayor al parámetro recibido. 
 
// b- Escriba una función que reciba un vector de personas, edad y el nombre de una  ciudad, 
// y retorna las personas mayores al parámetro edad y que viven en el valor del parámetro 
// ciudad. 
 
// c- Escriba una función que reciba un vector de personas y un nombre de una ciudad y 
// retorna true si todas las personas viven en la ciudad pasada por parámetro, false caso 
// contrario. 
 
// d- Escriba una función que reciba un vector de personas y un nombre de una ciudad y 
// retorna true si al menos vive una persona en la ciudad pasada por parámetro,, false caso 
// contrario.

// e- Escriba una función que reciba un arreglo de personas y una persona y retorna true si la 
// persona existe en el arreglo, false caso contrario 
 
 
// f -Escriba una función que reciba un arreglo de personas y retorna un arreglo con las 
// edades de las personas. 
 
// g - Escriba una función que reciba un arreglo de personas y retorna la persona con el menor 
// salario y la persona con el mayor salario, en caso de que haya más de una persona en cada 
// categoría desempatar por la edad más grande. 
 
// Nota: Implemente todos los métodos y traits que considere para resolver los ejercicios. 
// Todos los ejercicios deben resolverse con iterator y closure. 
#[derive(Debug, PartialEq, Clone)]
struct Persona<'a> {
    nombre: &'a str,
    apellido: &'a str,
    direccion: &'a str,
    ciudad: &'a str,
    salario: f64,
    edad: u8,
}

impl<'a> Persona<'a> {
    fn new(
        nombre: &'a str,
        apellido: &'a str,
        direccion: &'a str,
        ciudad: &'a str,
        salario: f64,
        edad: u8,
    ) -> Persona<'a> {
        Persona {
            nombre,
            apellido,
            direccion,
            ciudad,
            salario,
            edad,
        }
    }
    
}

fn personas_salario_mayor<'a>(personas: &'a Vec<Persona>, salario: f64) -> Vec<&'a Persona<'a>> {
    personas
        .iter()
        .filter(|persona| persona.salario > salario)
        .collect()
}

fn personas_mayor_edad_ciudad<'a>(personas: &'a Vec<Persona>, edad: u8, ciudad: &'a str) -> Vec<&'a Persona<'a>> {
    personas
        .iter()
        .filter(|persona| persona.edad > edad && persona.ciudad == ciudad)
        .collect()
}

fn personas_en_ciudad<'a>(personas: &'a Vec<Persona>, ciudad: &'a str) -> bool {
    personas.iter().all(|persona| persona.ciudad == ciudad)
}

fn alguna_persona_en_ciudad<'a>(personas: &'a Vec<Persona>, ciudad: &'a str) -> bool {
    personas.iter().any(|persona| persona.ciudad == ciudad)
}

fn existe_persona<'a>(personas: &'a [Persona<'a>], persona: &Persona<'a>) -> bool {
    personas.iter().any(|p| p == persona)
}

fn edades_personas<const N: usize>(personas: &[Persona; N]) -> Option<[u8; N]> {
    personas
        .iter()
        .map(|persona| persona.edad)
        .collect::<Vec<u8>>()
        .try_into()
        .ok()
}

fn persona_mayor_y_menor_salario<'a>(personas: &'a Vec<Persona>) -> Option<[&'a Persona<'a>; 2]> {
    let minimo = personas.iter().min_by(|per1, per2|{
        per1.salario
        .partial_cmp(&per2.salario)
        .expect("Comparacion no posible")// si es none paniquea
        .then_with(|| {
            per1.edad
            .partial_cmp(&per2.edad)// desempata por edad;
            .expect("Comparacion de edad no fue posible")
        })        
    });

    let maximo = personas.iter().max_by(|per1, per2|{
        per1.salario
        .partial_cmp(&per2.salario)
        .expect("Comparacion no posible")// si es none paniquea
        .then_with(|| {
            per1.edad
            .partial_cmp(&per2.edad)// desempata por edad;
            .expect("Comparacion de edad no fue posible")
        })        
    });

    if let (Some(min), Some(max)) = (minimo, maximo) {
        Some([min, max])
    } else {
        None
    }


}


#[cfg(test)]
mod tests {
    use super::*;
    fn crear_persona<'a>(
    nombre: &'a str,
    apellido: &'a str,
    direccion: &'a str,
    ciudad: &'a str,
    salario: f64,
    edad: u8,
    ) -> Persona<'a> {
        Persona::new(nombre, apellido, direccion, ciudad, salario, edad)
    }

    #[test]
    fn test_persona_mayor_y_menor_salario() {
        let mut personas = vec![
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
            crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20),
            crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28),
        ];
        let personas_mayor_y_menor = persona_mayor_y_menor_salario(&personas);
        assert_eq!(personas_mayor_y_menor, Some([&personas[2], &personas[1]]));

        // vector personas vacio:
        personas.clear();
        assert_eq!(persona_mayor_y_menor_salario(&personas), None);
    }

    #[test]
    fn test_personas_salario_mayor(){
        let mut personas = vec![
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
            crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20),
            crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28),
        ];
        let personas_mayor = personas_salario_mayor(&personas, 5000.0);
        assert_eq!(personas_mayor, vec![&personas[1], &personas[3]]);

        // vector personas vacio:
        personas.clear();
        assert_eq!(personas_salario_mayor(&personas, 0.0).len(),0);


    }

    #[test]
    fn tes_personas_mayor_edad(){
        let mut personas = vec![
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
            crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20),
            crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28),
        ];
        let vector = personas_mayor_edad_ciudad(&personas, 25, "Ciudad A");
        
        assert_eq!(vector.len(),1);
        assert_eq!(vector, vec![&personas[1]]);

        // vector personas vacio:
        personas.clear();
        assert_eq!(personas_mayor_edad_ciudad(&personas, 0, "Ciudad A").len(),0);
    }

    #[test]
    fn test_personas_en_ciudad(){
        let mut personas = vec![
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
        ];
        let mut existe = personas_en_ciudad(&personas, "Ciudad A");
        assert_eq!(existe, true);

        let p1 = crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20);
        let p2 =  crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28);

        personas.push(p1);
        personas.push(p2);

        existe = personas_en_ciudad(&personas, "Ciudad A");
        assert_eq!(existe, false);

    }

    #[test]
    fn test_alguna_persona_en_ciudad(){
        let mut personas = vec![
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
        ];
        let mut existe = alguna_persona_en_ciudad(&personas, "Ciudad A");
        assert_eq!(existe, true);

        let p1 = crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20);
        let p2 =  crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28);

        personas.push(p1);
        personas.push(p2);

        existe = alguna_persona_en_ciudad(&personas, "Ciudad B");
        assert_eq!(existe, true);

        personas.clear();
        existe = alguna_persona_en_ciudad(&personas, "Ciudad B");
        assert_eq!(existe, false);
    }

    #[test]
    fn test_existe_persona(){
        let p1 = crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25);
        let p2 =  crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 5500.0, 28);
        let p3 =  crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20);
        let p4 =  crear_persona("Ana", "Garcia", "Calle 012", "Ciudad B", 5500.0, 28);
        let personas = vec![p1.clone(),p2.clone(),p3.clone(),p4.clone()];

        let existe = existe_persona(&personas, &p1);
        assert_eq!(existe, true);

        let personas_vacias: Vec<Persona> = vec![];
        let existe2 = existe_persona(&personas_vacias, &p1);
        assert_eq!(existe2, false);
    }

    #[test]
    fn test_edades_personas(){
        let personas = [
            crear_persona("Juan", "Perez", "Calle 123", "Ciudad A", 5000.0, 25),
            crear_persona("Maria", "Gonzalez", "Calle 456", "Ciudad A", 6000.0, 30),
            crear_persona("Pedro", "Lopez", "Calle 789", "Ciudad B", 4000.0, 20),
        ];
        let edades = edades_personas(&personas);
        assert_eq!(edades, Some([25, 30, 20]));();

        let personas_vacias:[Persona; 0] = [];
        let edades2 = edades_personas(&personas_vacias);
        assert_eq!(edades2, Some([]));

    }


}
