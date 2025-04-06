package tp2.ejercicio6;

import tp2.ejercicio1.BinaryTree;

public class Transformacion {
	private BinaryTree<Integer> arbol;
	
	public Transformacion (BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public BinaryTree<Integer> suma() {
		sumaRec(arbol);
		return arbol;
	}
	
	public BinaryTree<Integer> getTrans() {
        return arbol;
    }
	private int sumaRec(BinaryTree<Integer> arbol) {
		int sum = 0;
		if (arbol.isLeaf()) {
			sum = arbol.getData();
			arbol.setData(0);
			return sum;
		}
		
		if(arbol.hasLeftChild()) {
			sum+= sumaRec(arbol.getLeftChild());
		}
		if(arbol.hasRightChild()) {
			sum+= sumaRec(arbol.getRightChild());
		}
		
		int actual = arbol.getData();
		arbol.setData(sum);
		return actual + sum;
	}
	
	public static void main(String[] args) {
		System.out.println("Test Transformacion");
		
		BinaryTree<Integer> root = new BinaryTree<>(1);
		BinaryTree<Integer> nodo2 = new BinaryTree<>(2);
		BinaryTree<Integer> nodo3 = new BinaryTree<>(3);
		BinaryTree<Integer> nodo4 = new BinaryTree<>(4);
		BinaryTree<Integer> nodo5 = new BinaryTree<>(5);
		BinaryTree<Integer> nodo6 = new BinaryTree<>(6);
		BinaryTree<Integer> nodo7 = new BinaryTree<>(7);
		BinaryTree<Integer> nodo8 = new BinaryTree<>(8);
		
		root.addLeftChild(nodo2);
		root.addRightChild(nodo3);
		nodo2.addRightChild(nodo4);
		nodo3.addLeftChild(nodo5);
		nodo3.addRightChild(nodo6);
		nodo5.addLeftChild(nodo7);
		nodo5.addRightChild(nodo8);
		
		
		root.imprimirArbolPorNiveles();
		
		Transformacion trans = new Transformacion (root);
		System.out.println();
		System.out.println("Arbol Transformado");
		trans.suma();
		trans.getTrans().imprimirArbolPorNiveles();
		
	}
}
