package tp3.ejercicio1;

import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;

public class GeneralTree<T>{

	private T data;
	private List<GeneralTree<T>> children = new LinkedList<GeneralTree<T>>(); 

	public GeneralTree() {
		
	}
	public GeneralTree(T data) {
		this.data = data;
	}

	public GeneralTree(T data, List<GeneralTree<T>> children) {
		this(data);
		this.children = children;
	}	
	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public List<GeneralTree<T>> getChildren() {
		return this.children;
	}
	
	public void setChildren(List<GeneralTree<T>> children) {
		if (children != null)
			this.children = children;
	}
	
	public void addChild(GeneralTree<T> child) {
		this.getChildren().add(child);
	}

	public boolean isLeaf() {
		return !this.hasChildren();
	}
	
	public boolean hasChildren() {
		return !this.children.isEmpty();
	}
	
	public boolean isEmpty() {
		return this.data == null && !this.hasChildren();
	}

	public void removeChild(GeneralTree<T> child) {
		if (this.hasChildren())
			children.remove(child);
	}
	
	/* Ejercicio2
	b) Si ahora tuviera que implementar estos métodos en la clase GeneralTree<T>, ¿qué modificaciones
	haría tanto en la firma como en la implementación de los mismos? */
	
	public List<Integer> numerosImpartesMayoresQuePreOrden(Integer n){
		List<Integer> lista = new LinkedList<>();
		if(!this.isEmpty()) {
			this.recorridoPreOrden(n, lista);
		}
		return lista;
	}
	
	private void recorridoPreOrden(Integer n, List<Integer> lista) {
		int dato = (Integer) this.getData();
		if (dato % 2 !=0 && dato > n) {
			lista.add(dato);
		}
		List<GeneralTree<T>> children = this.getChildren();
		for (GeneralTree<T> child:children) {
			child.recorridoPreOrden(n,lista);
		}
	}
	
	public List<Integer> numerosImparesMayoresQueInOrden(Integer n){
		List<Integer> lista = new LinkedList<>();
		if(!this.isEmpty()) {
			this.recorridoInOrden(n, lista);
		}
		return lista;
	}
	
	private void recorridoInOrden(Integer n, List<Integer> lista) {
		int dato = (Integer) this.getData();
		List<GeneralTree<T>> hijos = this.getChildren();
		if(!hijos.isEmpty()) {
			hijos.get(0).recorridoInOrden(n, lista);
		}
		 if(dato %2 != 0 && dato > n) lista.add(dato);
		 for(int i=1; i<hijos.size(); i++) {
			 hijos.get(i).recorridoInOrden(n, lista);
		 }
		
	}
	
	public List<Integer> numerosImparesMayoresQuePostOrden(Integer n){
		List<Integer> lista = new LinkedList<>();
		if(!this.isEmpty()) {
			this.recorridoPostOrden(n, lista);
		}
		return lista;
	}
	
	private void recorridoPostOrden(Integer n, List<Integer> lista) {
		List<GeneralTree<T>> children = this.getChildren();
		for(GeneralTree<T> child: children) {
			child.recorridoPostOrden(n, lista);
		}
		int dato = (Integer) this.getData();
		if(dato %2 != 0 && dato > n) lista.add(dato);
	}
	
	public List<Integer> numerosImparesMayoresQuePorNiveles(Integer n){
		GeneralTree<T> ag;
		List<Integer> lista = new LinkedList<>();
		Queue<GeneralTree<T>> cola = new Queue <GeneralTree<T>>();
		cola.enqueue(this);
		while(!cola.isEmpty()) {
			ag = cola.dequeue();
			if(!ag.isEmpty()) {
				int dato= (Integer) ag.getData();
				if((dato%2!=0) && (dato>n)) lista.add(dato);
			}
			for (GeneralTree<T> child: ag.getChildren())
                cola.enqueue(child); 
		}
		return lista;
		
	}
	
	
	public int altura() {	 
		if(this.isEmpty()) {
			return -1;
		}
		if(this.children.isEmpty()) {
			return 0;
		} else {
			int alturaMax=0;
			for(GeneralTree<T> hijo: this.children) {
				int altHijo = hijo.altura();
				if(altHijo > alturaMax) {
					alturaMax=altHijo;
				}
			}
			return 1 + alturaMax;
		}
	}
	
		
	
	public int nivel(T dato){
		if(this.isEmpty()) return -1;
		Queue<GeneralTree<T>> cola = new Queue<>();
		Queue<Integer> niveles = new Queue<>(); //guardar niveles
		
		cola.enqueue(this);
		niveles.enqueue(0);
		
		while(!cola.isEmpty()) {
			 GeneralTree<T> actual = cola.dequeue();
			 int nivelActual = niveles.dequeue();
			 
			 if(actual.getData().equals(dato)) {
				 return nivelActual; //si lo encontre devuelvo el nivel
			 }
			 for(GeneralTree<T> hijo: actual.getChildren()) {
				 cola.enqueue(hijo); //
				 niveles.enqueue(nivelActual + 1);
			 }
		}
		
		return -1; // si no lo encuentra
		
		
	  }

	public int ancho(){
		if(this.isEmpty()) return 0;
		Queue<GeneralTree<T>> cola = new Queue<>();
		cola.enqueue(this);
		
		int maxAncho = 0;
		while(!cola.isEmpty()) {
			int nivelSize = cola.size(); // Cantidad nodos en el nivel
			if(nivelSize > maxAncho) {
				maxAncho = nivelSize;
			}
			GeneralTree<T> actual = cola.dequeue();
			for(GeneralTree<T> hijo: actual.getChildren()) {
				cola.enqueue(hijo);
			}
		}
		return maxAncho;
	}
	
	public boolean esAncestro(T a, T b) {
		if(this.getData().equals(a)) {
			return this.contiene(b);
		}
		
		for(GeneralTree<T> hijo: this.getChildren()) {
			if(hijo.esAncestro(a, b)) {
				return true;
			}
		}
		
		return false;
	}
	
	private boolean contiene(T dato) {
		if(this.getData().equals(dato)) {
			return true;
		}
		
		for(GeneralTree<T> hijo: this.getChildren()) {
			if(hijo.contiene(dato)) {
				return true;
			}
		}
		return false;
	}
	
}