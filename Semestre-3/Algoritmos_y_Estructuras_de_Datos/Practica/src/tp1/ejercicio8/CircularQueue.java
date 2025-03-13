package tp1.ejercicio8;

public class CircularQueue <T> extends Queue<T>{
	
	public CircularQueue() {
		super();
	}
	
	public T shift() {
		if (isEmpty()) {
			throw new IllegalStateException("La cola esta vacia");
		}
		
		//primer elemento
		T dato = dequeue();
		//moverlo al final
		enqueue(dato);
		return dato;
		
	}

}
