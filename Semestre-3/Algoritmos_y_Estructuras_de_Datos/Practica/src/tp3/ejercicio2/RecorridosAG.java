package tp3.ejercicio2;

import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class RecorridosAG {
	private GeneralTree<Integer> a;
	
	public RecorridosAG() {
		
	}
	
	public RecorridosAG(GeneralTree<Integer> a) {
		this.a = a;
	}
	
	public List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree <Integer> a, Integer n){
		List <Integer> lista = new LinkedList<Integer>();
		if(!a.isEmpty()) this.numerosImparesPreRecursivo(a, n, lista);
		return lista;
	}
	
	private void numerosImparesPreRecursivo(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
		int dato = a.getData();
		if (dato % 2 != 0 && dato > n) {
			lista.add(dato);
		}
		List<GeneralTree<Integer>> hijos = a.getChildren();
		for (GeneralTree<Integer> hijo: hijos) {
			numerosImparesPreRecursivo(hijo, n, lista);
		}	
	}
	
	public List<Integer> numerosImparesMayoresQueInOrden(GeneralTree <Integer> a, Integer n){
		List <Integer> lista = new LinkedList<Integer>();
		if(!a.isEmpty()) this.numerosImparesInRecursivo(a, n, lista);
		return lista;
	}
	
	private void numerosImparesInRecursivo(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
		int dato = a.getData();
		List<GeneralTree<Integer>> hijos = a.getChildren(); 
		
		if(!hijos.isEmpty()) { //se procesa el primer hijo de la raiz
			numerosImparesInRecursivo(hijos.get(0), n, lista);
		}
		
		//se procesa la raiz;
		if(dato % 2 !=0 && dato > n) {
			lista.add(dato);
		}
		
		//se procesan los demas hijos
		for(int i=1; i<hijos.size(); i++) {
			numerosImparesInRecursivo(hijos.get(i), n, lista);
		}
	}
	
	public List<Integer> numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n){
		List<Integer> lista = new LinkedList<Integer>();
		if(!a.isEmpty()) this.numerosImparesPoRecursivo(a, n, lista);
		return lista;
	}
	
	private void numerosImparesPoRecursivo(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
		//primero los hijos
		List<GeneralTree<Integer>> children = a.getChildren();
		for(GeneralTree<Integer> child : children) {
			numerosImparesPoRecursivo(child, n, lista);
		}
		
		int dato = a.getData();
		if(dato %2 !=0 && dato > n) {
			lista.add(dato);
		}
	}
	
	public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n){
		GeneralTree<Integer> ag;
		Queue<GeneralTree<Integer>> cola = new Queue<GeneralTree<Integer>>();
		List<Integer> lista=new LinkedList<>();
		cola.enqueue(a);
		while(!cola.isEmpty()) {
			ag= cola.dequeue();
			if (!ag.isEmpty()) {
                int dato=ag.getData();
                if ((dato%2!=0) && (dato>n)) lista.add(dato);
            }
            for (GeneralTree<Integer> child: ag.getChildren())
                cola.enqueue(child);
        }
        return lista;
	}
	
	public static void main(String [] args) {
		GeneralTree <Integer> a1 = new GeneralTree<Integer> (1);
		
		List<GeneralTree<Integer>> children2 = new LinkedList<GeneralTree<Integer>>();
		children2.add(new GeneralTree<Integer>(21));
		children2.add(new GeneralTree<Integer>(22));
		children2.add(new GeneralTree<Integer>(23));
		GeneralTree <Integer> a2 = new GeneralTree<Integer> (2, children2);
		
		List<GeneralTree<Integer>> children3 = new LinkedList<GeneralTree<Integer>>();
		children3.add(new GeneralTree<Integer>(31));
		children3.add(new GeneralTree<Integer>(32));
		GeneralTree<Integer> a3 = new GeneralTree<Integer>(3, children3);
		
		List<GeneralTree<Integer>> children = new LinkedList<GeneralTree<Integer>>();
		children.add(a1);
		children.add(a2);
		children.add(a3);
		GeneralTree<Integer> a = new GeneralTree<Integer>(11, children);
	
		RecorridosAG rec = new RecorridosAG();
		System.out.println("PREORDEN:" + rec.numerosImparesMayoresQuePreOrden(a, 0));
		System.out.println("INORDEN: " + rec.numerosImparesMayoresQueInOrden(a, 0));
		System.out.println("POSTORDEN: " + rec.numerosImparesMayoresQuePostOrden(a, 0));
		System.out.println("POR NIVELES: " + rec.numerosImparesMayoresQuePorNiveles(a, 0));
	}
}
