/* Ejercicio 4 
Una red binaria es una red que posee una topología de árbol binario lleno.
Los nodos que conforman una red binaria llena tiene la particularidad de que todos ellos conocen
cuál es su retardo de reenvío. El retardo de reenvío se define como el período comprendido entre
que un nodo recibe un mensaje y lo reenvía a sus dos hijos.
Su tarea es calcular el mayor retardo posible, en el camino que realiza un mensaje desde la raíz
hasta llegar a las hojas en una red binaria llena. En el ejemplo, debería retornar 10+3+9+12=34
(Si hay más de un máximo retorne el último valor hallado).
Nota: asuma que cada nodo tiene el dato de retardo de reenvío expresado en cantidad de
segundos.
a) Indique qué estrategia (recorrido en profundidad o por niveles) utilizará para resolver el
problema.
Dado que necesitamos evaluar el retardo acumulado en el camino desde la raíz hasta las hojas, utilizaremos un recorrido en profundidad (DFS - Depth First Search).

📍 Razones para elegir DFS (Recursión o Pila explícita):

Necesitamos explorar todos los caminos hasta las hojas.
DFS nos permite llevar un contador acumulativo del retardo de cada camino.
Nos aseguramos de encontrar el máximo retardo posible en cualquier ruta.
⚠️ No usamos BFS (por niveles) porque este enfoque es más útil para encontrar caminos mínimos, pero aquí buscamos el máximo retardo.
b) Cree una clase Java llamada RedBinariaLlena donde implementará lo solicitado en el
método retardoReenvio():int */

package tp2.ejercicio4;

import tp2.ejercicio1.BinaryTree;

public class RedBinariaLlena {
	private BinaryTree<Integer> arbol;
	
	public RedBinariaLlena(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public int retardoEnvio() {
		if (arbol == null) {
			return 0;
		}
		return calcularRetardo(arbol);
	}
	
	private int calcularRetardo(BinaryTree<Integer> nodo) {
		if(nodo == null) {
			return 0;
		}
		// Si es hoja, devuelve su propio retardo
        if (!nodo.hasLeftChild() && !nodo.hasRightChild()) {
            return nodo.getData();
        }
        
        int retardoIzq = calcularRetardo(nodo.getLeftChild());
        int retardoDer = calcularRetardo(nodo.getRightChild());
        
        return nodo.getData() + Math.max(retardoIzq, retardoDer);
	}
	
	public static void main(String[] args) {
		// crear el arbol binario con retardos de envio
		BinaryTree<Integer> root = new BinaryTree<>(10);
		root.addLeftChild(new BinaryTree<>(3));
        root.addRightChild(new BinaryTree<>(8));
        
        root.getLeftChild().addLeftChild(new BinaryTree<>(2));
        root.getLeftChild().addRightChild(new BinaryTree<>(9));
        
        root.getRightChild().addLeftChild(new BinaryTree<>(6));
        root.getRightChild().addRightChild(new BinaryTree<>(12));
        
        RedBinariaLlena red = new RedBinariaLlena(root);
        
        System.out.println("El mayor tiempo de retardo es: " + red.retardoEnvio());
	}

}
