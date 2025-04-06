package tp2.ejercicio1;

import java.util.LinkedList;
import java.util.Queue;

public class BinaryTree<T> {
	
	private T data;
	private BinaryTree<T> leftChild;
	private BinaryTree<T> rightChild;
	
	// Constructor por defecto
    public BinaryTree() {
        this.data = null;
        this.leftChild = null;
        this.rightChild = null;
    }
    
	public BinaryTree(T data) {
		this.data = data;
		this.leftChild = null;
		this.rightChild = null;
	}
	
	public T getData() {
		return data;
	}
	
	public void setData(T data) {
		this.data = data;
	}
	
	public BinaryTree<T> getLeftChild(){
		return leftChild;
	}
	
	public BinaryTree<T> getRightChild(){
		return rightChild; 
	}
	
	public void addLeftChild(BinaryTree<T> child) {
		this.leftChild = child;
	}
	
	public void addRightChild(BinaryTree<T> child) {
		this.rightChild = child;
	}
	
	public void removeRightChild() {
		this.rightChild = null;
	}
	
	public void removeLeftChild() {
		this.leftChild = null;
	}
	
	public boolean hasLeftChild() {
		return (this.leftChild !=null);
	}
	
	public boolean hasRightChild() {
		return (this.rightChild !=null);
	}
	
	public boolean isLeaf() {
		return (!this.hasLeftChild() && !this.hasRightChild());
	}
	
	public boolean isEmpty() {
		return(!this.isLeaf() && this.getData() == null);
	}
	
	public int contarHojas() {
		if (this.isEmpty()) {
	        return 0; // Si el árbol está vacío, no tiene hojas
	    }
	    if (this.isLeaf()) {
	        return 1; // Si es una hoja, cuenta como 1
	    }
		
		
		int hojasIzq = 0;
		int hojasDer = 0;
		if(this.hasLeftChild()) {
			hojasIzq = this.leftChild.contarHojas();
		}
		if(this.hasRightChild()) {
			hojasDer = this.rightChild.contarHojas();
		}
		return hojasIzq + hojasDer;
		
	}
	
	public BinaryTree<T> espejo(){
		if (this.isEmpty()) {
	        return new BinaryTree<>(); // Retorna un árbol vacío si el original está vacío
	    }
		
		BinaryTree<T> nodo = new BinaryTree<>(this.data);
		
		if(this.hasRightChild()) {
			nodo.leftChild = this.rightChild.espejo();// se invierte el nodo derecho
		}
		if (this.hasLeftChild()) {
	        nodo.rightChild = this.leftChild.espejo(); // Se invierte el lado izquierdo
	    }
		
		return nodo;

	}
	public int altura() {
		if(this.isLeaf()) {
			return 0;
		} else {
			int alturaIzq = this.leftChild.altura();
			int alturaDer = this.rightChild.altura();
			return 1 + Math.max(alturaIzq, alturaDer);
		}
		
		
	}
	
	public void entreNiveles(int n, int m) {
		if (n < 0 || m < 0 || n > m) {
	        System.out.println("Niveles no válidos");
	        return;
	    }
		if (this.isEmpty()) {
	        System.out.println("El árbol está vacío");
	        return;
	    }
		
		int altura = this.altura();
		if(m>altura) {
			m=altura;
		}
		
		Queue<BinaryTree<T>> cola = new LinkedList<>();
		cola.add(this);
		int nivelActual = 0;
		
		while(!cola.isEmpty()) {
			int size = cola.size();
			//solo el rango.
			if (nivelActual >= n && nivelActual <= m) {
	            System.out.print("Nivel " + nivelActual + ": ");
	        }
			
			 for (int i = 0; i < size; i++) {
		            BinaryTree<T> nodo = cola.remove();

		            // Imprimir solo si estamos dentro del rango
		            if (nivelActual >= n && nivelActual <= m) {
		                System.out.print(nodo.getData() + " ");
		            }

		            // Agregar hijos a la cola si existen
		            if (nodo.hasLeftChild()) {
		                cola.add(nodo.getLeftChild());
		            }
		            if (nodo.hasRightChild()) {
		                cola.add(nodo.getRightChild());
		            }
		        }

		        // Si imprimimos algo en este nivel, agregar un salto de línea
		        if (nivelActual >= n && nivelActual <= m) {
		            System.out.println();
		        }

		        nivelActual++;
		    }
						
		}
	public void imprimirArbol() {
		System.out.print(this.getData() + " ");
        if(this.hasLeftChild()) this.getLeftChild().imprimirArbol();
        
        if(this.hasRightChild()) this.getRightChild().imprimirArbol();
    }
	
	public void imprimirArbolPorNiveles() {
	    Queue<BinaryTree<T>> queue = new LinkedList<>();
	    queue.add(this); // Agregar la raíz a la cola

	    while (!queue.isEmpty()) {
	        BinaryTree<T> current = queue.poll(); // Sacar el nodo actual de la cola
	        System.out.print(current.getData() + " ");

	        // Agregar hijos a la cola si existen
	        if (current.hasLeftChild()) {
	            queue.add(current.getLeftChild());
	        }
	        if (current.hasRightChild()) {
	            queue.add(current.getRightChild());
	        }
	    }
	}
}
