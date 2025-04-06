package tp2.ejercicio5;

import tp2.ejercicio1.BinaryTree;

public class ProfundidadDeArbolBinario {
	private BinaryTree <Integer> arbol;
	
	public ProfundidadDeArbolBinario(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	
	public int sumaElementosProfunidad(int p) {
		return (!arbol.isEmpty()) ? sumaElementosRecursivo(p, arbol,0):0;
		
	}
	
	private int sumaElementosRecursivo(int p, BinaryTree<Integer> arbol, int nivelActual) {
		if(p== nivelActual) {
			return arbol.getData();
		} else {
			int suma = 0;
			if(arbol.hasLeftChild()) {
				suma+= sumaElementosRecursivo(p, arbol.getLeftChild(), nivelActual+1);
			}
			if(arbol.hasRightChild()) {
				suma+= sumaElementosRecursivo(p, arbol.getRightChild(), nivelActual+1);
			}
			return suma;
		}
		
	}
	
	public static void main(String[] args) {
		System.out.println("Profundidad");
		  // Crear un árbol binario para probar
        // Estructura del árbol:
        //       10
        //      /  \
        //     5    15
        //    / \   / \
        //   3   7 12  18
		// Crear los nodos hoja (profundidad 2)
        BinaryTree<Integer> nodo3 = new BinaryTree<>(3);
        BinaryTree<Integer> nodo7 = new BinaryTree<>(7);
        BinaryTree<Integer> nodo12 = new BinaryTree<>(12);
        BinaryTree<Integer> nodo18 = new BinaryTree<>(18);
        
     // Crear los nodos intermedios (profundidad 1)
        BinaryTree<Integer> nodo5 = new BinaryTree<>(5);
        BinaryTree<Integer> nodo15 = new BinaryTree<>(15);
        
      //Crar el nodo root
        BinaryTree<Integer> root = new BinaryTree<>(10);
        
        root.addLeftChild(nodo5);
        root.addRightChild(nodo15);
        nodo5.addLeftChild(nodo3);
        nodo5.addRightChild(nodo7);
        nodo15.addLeftChild(nodo12);
        nodo15.addRightChild(nodo18);
		
        
        ProfundidadDeArbolBinario profundidad = new ProfundidadDeArbolBinario(root);
		
     // Probar con diferentes profundidades
        System.out.println("Suma de elementos en profundidad 0: " + profundidad.sumaElementosProfunidad(0));
        System.out.println("Suma de elementos en profundidad 1: " + profundidad.sumaElementosProfunidad(1));
        System.out.println("Suma de elementos en profundidad 2: " + profundidad.sumaElementosProfunidad(2));
        System.out.println("Suma de elementos en profundidad 3: " + profundidad.sumaElementosProfunidad(3));
	}

}
