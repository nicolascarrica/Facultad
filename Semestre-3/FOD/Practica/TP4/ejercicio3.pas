// Los árboles B+ representan una mejora sobre los árboles B dado que conservan la propiedad de
// acceso indexado a los registros del archivo de datos por alguna clave, pero permiten además un
// recorrido secuencial rápido. Al igual que en el ejercicio 2, considere que por un lado se tiene el
// archivo que contiene la información de los alumnos de la Facultad de Informática (archivo de
// datos no ordenado) y por otro lado se tiene un índice al archivo de datos, pero en este caso el
// índice se  estructura como un árbol B+ que ofrece acceso indizado por DNI al archivo de alumnos.
// // Resuelva los siguientes incisos: 

// a. ¿Cómo se organizan los elementos (claves) de un árbol B+? ¿Qué elementos se encuentran
// en los nodos internos y que elementos se encuentran en los nodos hojas?

// NODOS INTERNOS:
// - Contienen solo claves (por ejemplo, DNIs).
// - No contienen enlaces directos a los datos, sino a otros nodos del árbol (sus hijos).
// -Actúan como guía para dirigir la búsqueda hacia el nodo hoja correcto.

// NODOS HOJA:
// Contienen:
// - Las claves (DNIs)
// - Los enlaces a los registros reales en el archivo de alumnos (archDatos)
// Además, los nodos hoja están enlazados secuencialmente (de izquierda a derecha), como una lista enlazada.
// Esto permite recorrer el árbol en orden muy eficientemente.

// Gracias a esta organización:
// Las búsquedas individuales funcionan como en un árbol B.
// Las búsquedas por rango son mucho más rápidas, porque una vez que llegás al primer nodo hoja con una clave del rango, simplemente recorrés hacia la derecha.

// b. ¿Qué característica distintiva presentan los nodos hojas de un árbol B+? ¿Por qué?

// los nodos hojas de un árbol B+ tienen la siguiente característica distintiva:
// Los nodos hoja del árbol B+ están enlazados entre sí en forma secuencial (como una lista enlazada).
// Cada nodo hoja tiene un puntero al siguiente nodo hoja.

// Una vez que encontrás la primera clave del rango, solo tenés que seguir leyendo los nodos hoja hacia la derecha, sin volver a pasar por nodos internos.
// Esto hace las búsquedas por intervalos rápidas y eficientes.
// Muy útil para operaciones como: listar todos los alumnos en orden de DNI, exportar datos, o realizar búsquedas por rangos (ej. entre dos DNIs).

// c - Defina en Pascal las estructuras de datos correspondientes para el archivo de alumnos y su
// índice (árbol B+). Por simplicidad, suponga que todos los nodos del árbol B+ (nodos internos y
// nodos hojas) tienen el mismo tamaño

const 
    orden = N;
type 
    alumno = record
        nombre: string;
        apellido: string;
        dni: integer;
        legajo:integer;
        anioIngreso: integer;
    end;

    tarch = file of alumno;

    tlista = ^tnodo

    tnodo= record
        hijos: array [1..orden]= of integer;
        claves: array [1..(orden-1)]= of longint
        enlaces: array [1..(orden-1)]= of integer;
        cant_claves: integer;
        sig: tlista;
    end;

    tIndice = file of tnodo;

// D - Describa, con sus palabras, el proceso de búsqueda de un alumno con un DNI específico
// haciendo uso de la estructura auxiliar (índice) que se organiza como un árbol B+. ¿Qué
// diferencia encuentra respecto a la búsqueda en un índice estructurado como un árbol B?

//1° - Comenzamos en la raíz del árbol.

//2°- En cada nodo interno, comparamos el DNI buscado con las claves del nodo:

//    Elegimos el hijo correspondiente donde puede estar la clave (por ejemplo, si el DNI es menor que la primera clave, vamos al primer hijo; si está entre dos claves, vamos al hijo del medio, etc.).

//    Repetimos este proceso bajando niveles del árbol hasta llegar a un nodo hoja.

//3° - En el nodo hoja, buscamos el DNI exacto dentro del arreglo de claves.

//4° - Si lo encontramos, usamos el enlace asociado para ir directamente a la posición del archivo de alumnos (archivoDatos) donde está la información del alumno

//La diferencia es que En un árbol B, los enlaces pueden estar en cualquier nodo, lo que hace la estructura un poco más compleja para búsquedas por rango o recorridos secuenciales.

// E - Explique con sus palabras el proceso de búsqueda de los alumnos que tienen DNI en el
// rango entre 40000000 y 45000000, apoyando la búsqueda en un índice organizado como un
// árbol B+. ¿Qué ventajas encuentra respecto a este tipo de búsquedas en un árbol B?

// 1° Inicio en la raíz del árbol:

//     Empezamos en el nodo raíz del árbol B+. Este nodo contiene claves que guiarán la búsqueda hacia los nodos hijos correctos.

//     Compararemos el DNI de inicio (40000000) con las claves del nodo para determinar qué hijo debemos seguir.

// 2° Descendemos a los nodos internos:

//     En cada nodo interno, comparamos el DNI de inicio (40000000) con las claves.

//     Vamos seleccionando el hijo adecuado para seguir el camino hasta llegar a los nodos hojas. Este proceso es igual que en la búsqueda de un único DNI, pero en este caso, estamos buscando el primer nodo hoja que contenga el DNI de inicio de nuestro rango.

// 3° Llegamos al primer nodo hoja:

//     Una vez en el nodo hoja, buscamos el primer DNI que sea mayor o igual a 40000000.

//     Si encontramos un DNI que cumple esta condición, comenzamos a procesarlo.

//     A partir de ahí, recorremos secuencialmente los nodos hoja en busca de otros alumnos cuyo DNI esté dentro del rango.

// 4° Recorrido secuencial de los nodos hoja:

//     Gracias a que los nodos hoja están enlazados entre sí, podemos seguir el puntero sig de un nodo hoja al siguiente sin necesidad de volver a recorrer el árbol.

//     Continuamos este recorrido hasta que encontramos un DNI mayor que 45000000. En ese momento, sabemos que hemos llegado al final del rango, por lo que detenemos la búsqueda.

// 5° Acceso a los registros:

// Para cada DNI que encontramos dentro del rango, podemos usar el enlace que se encuentra en el nodo hoja para acceder directamente al registro del alumno en el archivo de datos (archivoDatos).