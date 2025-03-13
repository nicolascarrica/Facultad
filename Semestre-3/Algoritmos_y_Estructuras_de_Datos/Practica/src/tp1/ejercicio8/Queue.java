package tp1.ejercicio8;

import java.util.LinkedList;

public class Queue<T> {
	protected LinkedList<T> lista;
	
	public Queue() {
		lista = new LinkedList<>();
	}
	
	public void enqueue(T dato) {
		lista.addLast(dato);
	}
	
	public T dequeue() {
		if(lista.isEmpty()) {
			System.out.println("La Lista esta vacia");
		}
		return lista.removeFirst();
	}
	
	public T head() {
		if(lista.isEmpty()) {
			System.out.println("La Lista esta vacia");
		}
		return lista.getFirst();
	}
	
	public boolean isEmpty() {
		return lista.isEmpty();
	}
	
	public int size() {
		return lista.size();
	}
	
	public String toString() {
		String aux = "";
		for (int i=0; i<this.size(); i++) {
			aux = aux +" " + lista.get(i);
		}
		return aux;
	}

}
