{
1. Considere que desea almacenar en un archivo la información correspondiente a los alumnos de la
Facultad de Informática de la UNLP. De los mismos deberá guardarse nombre y apellido, DNI, legajo
y año de ingreso. Suponga que dicho archivo se organiza como un árbol B de orden M. 
a. Defina en Pascal las estructuras de datos necesarias para organizar el archivo de alumnos
como un árbol B de orden M. 
b. Suponga que la estructura de datos que representa una persona (registro de persona)
ocupa 64 bytes, que cada nodo del árbol B tiene un tamaño de 512 bytes y que los números
enteros ocupan 4 bytes, ¿cuántos registros de persona entrarían en un nodo del árbol B?
¿Cuál sería el orden del árbol B en este caso (el valor de M)? Para resolver este inciso, puede
utilizar la fórmula N = (M-1) * A + M * B + C, donde N es el tamaño del nodo (en bytes), A es el
tamaño de un registro (en bytes), B es el tamaño de cada enlace a un hijo y C es el tamaño
que ocupa el campo referido a la cantidad de claves. El objetivo es reemplazar estas
variables con los valores dados y obtener el valor de M (M debe ser un número entero,
ignorar la parte decimal). 
c. ¿Qué impacto tiene sobre el valor de M organizar el archivo con toda la información de los
alumnos como un árbol B? 
d. ¿Qué dato seleccionaría como clave de identificación para organizar los elementos
(alumnos) en el árbol B? ¿Hay más de una opción? 
e. Describa el proceso de búsqueda de un alumno por el criterio de ordenamiento
especificado en el punto previo. ¿Cuántas lecturas de nodos se necesitan para encontrar un
alumno por su clave de identificación en el peor y en el mejor de los casos? ¿Cuáles serían
estos casos? 
f. ¿Qué ocurre si desea buscar un alumno por un criterio diferente? ¿Cuántas lecturas serían
necesarias en el peor de los casos?}

//a
const 
	M = ..// orden del arbol;
type
	alumno = record
		nombre: string;
		apellido: string;
		dni: integer;
		legajo:integer;
		anioIngreso: integer;
	end;
	
	nodo = record
		nClaves: integer;
		claves: array[1..M-1] of alumno;
		hijos: array[1..M] of integer;
	end;
	arbolB = file of nodo;
	var
		archivoDatos: arbolB;
		
{
// B

la formula para calcular M es:
	N = (M-1)*A + M*B + C
donde:
	N = 512 bytes (tamaño del nodo)
	A = 64 bytes (tamaño del registro alumno)
	B = 4 bytes (tamano de cada enlace a un hijo)
	C = 4 bytes (tamaño del campo que almacena el numero de claves)
	
	512 = (M-1)*64 + M*4 + 4
	515 = 64*M - 64 + 4*M + 4
	575 / 68 = M
	M = 8.41 se debe tomar el entero 8
	
	esto significa que en cada nodo del arbol B se pueden almacenar 7 registros Alumnos
	y 8 enlaces a nodos hijos.
}

{
C ¿Qué impacto tiene sobre el valor de M organizar el archivo con toda 
la información de los alumnos como un árbol B? 

El valor de M determina la cantidad máxima de claves y de hijos que puede tener un nodo en el árbol B. Un valor mayor de 
M resultará en nodos más grandes y, por lo tanto, en una estructura de árbol B más ancha y menos profunda. Por otro lado, un valor menor de 
M resultará en nodos más pequeños y en una estructura de árbol B más profunda pero más estrecha.
}

{
D ¿Qué dato seleccionaría como clave de identificación para organizar los
elementos (alumnos) en el árbol B? ¿Hay más de una opción?

Se deben seleccionar campos que sean unicos para cada elemento, dni o legajo
}

{
E Describa el proceso de búsqueda de un alumno por el criterio de ordenamiento
especificado en el punto previo. ¿Cuántas lecturas de nodos se necesitan para encontrar un
alumno por su clave de identificación en el peor y en el mejor de los casos? ¿Cuáles serían
estos casos? 

Proceso de Búsqueda:

Comienzo en la raíz: Se compara la clave de búsqueda con las claves almacenadas en el nodo raíz.

Desplazamiento a subárbol: Si no se encuentra la clave en el nodo actual, se sigue el enlace al subárbol correspondiente.

Repetición hasta nodo hoja: Este proceso se repite hasta encontrar la clave o alcanzar un nodo hoja vacío.

Número de Lecturas:

Mejor Caso: La clave está en la raíz (1 lectura).

Peor Caso: Requiere atravesar desde la raíz hasta un nodo hoja, lo que implica una profundidad de aproximadamente 
log base M(N), donde N es el numero total de alumnos
}

{
F ¿Qué ocurre si desea buscar un alumno por un criterio diferente? ¿Cuántas lecturas serían
necesarias en el peor de los casos?
Si se busca por otro criterio como nombre y apellido, el árbol B basado en DNI no será eficiente. Esto se debe a que los datos no están organizados según este campo, lo que requeriría recorrer todos los nodos del árbol para encontrar posibles coincidencias.

Peor Caso: Se deben leer todos los nodos del árbol, lo que implica lecturas del orden del tamaño completo del archivo.
}


	
	

		
