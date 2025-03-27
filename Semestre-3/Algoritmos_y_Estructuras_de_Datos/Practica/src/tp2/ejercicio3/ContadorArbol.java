//Ejercicio 3
//Defina una clase Java denominada ContadorArbol cuya función principal es proveer métodos de
//validación sobre árboles binarios de enteros. Para ello la clase tiene como variable de instancia un
//BinaryTree<Integer>. Implemente en dicha clase un método denominado numerosPares() que
//devuelve en una estructura adecuada (sin ningún criterio de orden) todos los elementos pares del
//árbol (divisibles por 2).
//a) Implemente el método realizando un recorrido InOrden.
//b) Implemente el método realizando un recorrido PostOrden.


package tp2.ejercicio3;

import java.util.ArrayList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp2.ejercicio1.BinaryTree;

public class ContadorArbol {
	private BinaryTree<Integer> arbol;
	
	public ContadorArbol(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public List<Integer> numerosParesInOrden(){
		List<Integer> resultado = new ArrayList<>();
		inOrden(arbol, resultado);
		return resultado;
	}
	
	private void inOrden(BinaryTree<Integer> nodo, List<Integer> resultado) {
		if(nodo !=null) {
			inOrden(nodo.getLeftChild(), resultado); // recorrer Izquierda
			if (nodo.getData() % 2 == 0) {
				resultado.add(nodo.getData());
			}
			inOrden(nodo.getRightChild(), resultado); // recorrer derecha
		}
	}
	
	public List<Integer> numerosParesPostOrden(){
		List <Integer> resultado = new ArrayList<>();
		postOrden(arbol, resultado);
		return resultado;
	}
	
	private void postOrden(BinaryTree<Integer> nodo, List<Integer> resultado) {
		if(nodo !=null) {
			postOrden(nodo.getLeftChild(), resultado); // Izquierda
			postOrden(nodo.getRightChild(), resultado); //Derecha
			if (nodo.getData() % 2 == 0) {
				resultado.add(nodo.getData());
			}
		}
	}
	
	public void printTree() {
	    printTreeHelper(arbol, 0);
	}

	private void printTreeHelper(BinaryTree<Integer> nodo, int nivel) {
	    if (nodo == null) {
	        return;
	    }

	    // Primero imprimir el subárbol derecho (para que el árbol se vea correctamente)
	    printTreeHelper(nodo.getRightChild(), nivel + 1);

	    // Imprimir el nodo actual con indentación según el nivel
	    System.out.println(" ".repeat(nivel * 4) + nodo.getData());

	    // Luego imprimir el subárbol izquierdo
	    printTreeHelper(nodo.getLeftChild(), nivel + 1);
	}

	
	public static void main (String[] args) {
		System.out.println("Test numeros pares: ");
		BinaryTree<Integer> root = new BinaryTree<Integer>(4);
		root.addLeftChild(new BinaryTree<Integer>(2));
		root.addRightChild(new BinaryTree<Integer>(6));
		root.getLeftChild().addLeftChild(new BinaryTree<Integer>(1));
		root.getLeftChild().addRightChild(new BinaryTree<Integer>(3));
		root.getRightChild().addLeftChild(new BinaryTree<Integer>(5));
		root.getRightChild().addRightChild(new BinaryTree<Integer>(8));
		
		ContadorArbol contador = new ContadorArbol(root);
		System.out.println("Imprimir por niveles: ");
		contador.printTree();
		
		System.out.println("");
		List<Integer> lisIN = contador.numerosParesInOrden();
		System.out.println("Los nodos pares INORDER son: ");
		System.out.println(lisIN);
		
		System.out.println("");
		List<Integer> lisPOST = contador.numerosParesPostOrden();
		System.out.println("Los nodos pares POSTORDER son: ");
		System.out.println(lisPOST);
	}
		
	
}
