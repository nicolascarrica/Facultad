{Una mejora respecto a la solución propuesta en el ejercicio 1 sería mantener por un lado el archivo
que contiene la información de los alumnos de la Facultad de Informática (archivo de datos no
ordenado) y por otro lado mantener un índice al archivo de datos que se estructura como un árbol
B que ofrece acceso indizado por DNI de los alumnos.
a. Defina en Pascal las estructuras de datos correspondientes para el archivo de alumnos y su
índice.
}

const
  M= // orden de arbol

type
  alumno = record
    nombre: string;
    apellido: string;
    dni: integer;
    legajo:integer;
    anioIngreso: integer;
  end;

  nodo = record
    cant_claves: integer;
    claves: arra[1..M-1] of longint;
    enlaces: array[1..M-1] of integer;
    hijos: array[1..M] of integer;
  end;

  TArchivoDatos = file of alumno;
  arbolB: file of nodo;

var
  archDatos: TArchivoDatos;
  arbolIndice: arbolB;

// b. Suponga que cada nodo del árbol B cuenta con un tamaño de 512 bytes. ¿Cuál sería el
// orden del árbol B (valor de M) que se emplea como índice? Asuma que los números enteros
// ocupan 4 bytes. Para este inciso puede emplear una fórmula similar al punto 1b, pero
// considere además que en cada nodo se deben almacenar los M-1 enlaces a los registros
// correspondientes en el archivo de datos.

// la formula para calcular M es:
// 	N = (M-1)*A + (M-1)*A + M*B + C // SE GUARDA NO SOLO LA CLAVE SI NO TAMBIEN INFORMACION SOBRE EL ENLACE AL ARCHIVO DE DATOS
// donde:
// 	N = 512 bytes (tamaño del nodo)
// 	A = 4 bytes (tamaño de la clave)
// 	B = 4 bytes (tamano de cada enlace a un hijo)
// 	C = 4 bytes (tamaño del campo que almacena el numero de claves)

//   515 = (M-1)*4 + (M-1)*4 + M*4 + 4
//   515 = (M-1)*8 + M*4 + 4
//   515 = 8*M - 8 + 4M + 4
//   515 = 12M - 4 
//   516/12 = M

//   M = 43 // ORDEN DEL ARBOL

// c. ¿Qué implica que el orden del árbol B sea mayor que en el caso del ejercicio 1?

// QUE EL ORDEN DEL ARBOL SEA MAYOR, IMPLICA QUE CADA NODO PUEDE ALMACENAR MAS CLAVES Y MAS HIJOS.
// CON ESTO CAVE MAS INFORMACION EN CADA NIVEL, SE REDUCE LA ALTURA DEL ARBOL, HACIENDO QUE LAS BUSQUEDAS REQUIERAN MENOS PASOS.
// AL HABER MENOS NIVELES HAY MENOS ACCESOS A DISCO.

// D. Describa con sus palabras el proceso para buscar el alumno con el DNI 12345678 usando el
// índice definido en este punto

// 1° se lee la raiz del archivo indice.
// 2° Se compara el DNI con las claves del nodo actual.
// 3° Si el dni es encontrado, se usa el enlace asociado para ir al archivo de datos.
// 4° Si no esta en ese nodo, se sigue el enlace al izquierdo si el dni es menor y al derecho si es mayor y se repite el paso anterior.
// 5° Se termina el proceso cuando se encuentra el dato o se confirma que no se encuentra.

// E - ¿Qué ocurre si desea buscar un alumno por su número de legajo? ¿Tiene sentido usar el
// índice que organiza el acceso al archivo de alumnos por DNI? ¿Cómo haría para brindar
// acceso indizado al archivo de alumnos por número de legajo?

// Con el diseño actual del arbol, no tendria sentido usar el indice para buscar por numero de kegajo, ya que
// el arbol esta diseñado para buscar por DNI.
// Para hacerlo por numero de legajo habria que hacer una busqueda secuencial hasta encontar el dato solicitado.
// Conclusión: No es eficiente ni apropiado usar un índice por DNI para buscar por legajo.

// Para poder hacer un acceso indizado, seria conveniente armar el nuevo arbol de indices usando el el campo legajo como clave.

//F - Suponga que desea buscar los alumnas que tienen DNI en el rango entre 40000000 y
// 45000000. ¿Qué problemas tiene este tipo de búsquedas con apoyo de un árbol B que solo
// provee acceso indizado por DNI al archivo de alumnos?

// el arbol B no es eficiente para realizar busquedas por rango de DNI. habria que buscar el dni minimo del rango y recorrer el arbol hasta el valor maximo.
// lo que implica leer muchos nodos si el rango es amplio.
// El árbol B solo organiza las claves del índice, pero el archivo de datos no está ordenado por DNI.
// Entonces, aunque se recorra el árbol B en orden, se van a hacer saltos aleatorios al archivo de datos cada vez que quieras leer un alumno.