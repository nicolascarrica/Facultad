package tp3.ejercicio1;

import java.util.LinkedList;
import java.util.List;

public class Main {
	public static void main(String[] args) {
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
		
		System.out.println("PREORDEN:" + a.numerosImpartesMayoresQuePreOrden(0));
		System.out.println("INORDEN: " + a.numerosImparesMayoresQueInOrden(0));
		System.out.println("POSTORDEN: " + a.numerosImparesMayoresQuePostOrden(0));
		System.out.println("POR NIVELES: " + a.numerosImparesMayoresQuePorNiveles(0));
		
//		PREORDEN:[11, 1, 21, 23, 3, 31]
//				INORDEN: [1, 11, 21, 23, 31, 3]
//				POSTORDEN: [1, 21, 23, 31, 3, 11]
//				POR NIVELES: [11, 1, 3, 21, 23, 31]
		System.out.println("La Altura del arbol es:" + a.altura());
		System.out.println("La profundidad o nivel del dato 3 en el árbol general ag es " + a.nivel(3));
		System.out.println("La profundidad o nivel del dato 502 en el árbol general ag es " + a.nivel(502));
		System.out.println("El ancho del arbol es: " + a.ancho());
		
		boolean ancestro = a.esAncestro(3, 23);
		System.out.println(ancestro);
		
		
    }
}
