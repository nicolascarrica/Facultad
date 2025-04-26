package tp3.ejercicio6;

import tp3.ejercicio1.GeneralTree;

public class RedAguaPotable {
	private GeneralTree<Character> red;
	
	public RedAguaPotable(GeneralTree<Character> red) {
		this.red=red;
	}
	
	public double minimoCaudal(double caudal) {
		return calculoCaudal(red, caudal);
	}
	
	private double calculoCaudal(GeneralTree<Character> nodo, double caudal) {
		// si es hoja se devuelve el caudal
		if(nodo.isLeaf()) {
			return caudal;
		}
		
		int hijos = nodo.getChildren().size();
		double nuevoCaudal = caudal/hijos;
		double minimoCaudal = 999999.99;
		
		for(GeneralTree<Character> hijo: nodo.getChildren()) {
			double caudalHijo = calculoCaudal(hijo, nuevoCaudal);
			if(caudalHijo<minimoCaudal) {
				minimoCaudal= caudalHijo;
			}

		}
		return minimoCaudal;
	}
	
	public static void main (String[] args) {
		GeneralTree<Character> ag = new GeneralTree<>('A');
		ag.addChild(new GeneralTree<>('B'));
		ag.addChild(new GeneralTree<>('C'));
		ag.addChild(new GeneralTree<>('D'));
		ag.addChild(new GeneralTree<>('E'));
		ag.getChildren().get(1).addChild(new GeneralTree<>('F'));
		ag.getChildren().get(1).addChild(new GeneralTree<>('G'));
		ag.getChildren().get(2).addChild(new GeneralTree<>('H'));
		ag.getChildren().get(2).addChild(new GeneralTree<>('I'));
		ag.getChildren().get(2).addChild(new GeneralTree<>('J'));
		ag.getChildren().get(2).addChild(new GeneralTree<>('K'));
		ag.getChildren().get(2).addChild(new GeneralTree<>('P'));
		ag.getChildren().get(1).getChildren().get(1).addChild(new GeneralTree<>('L'));
		ag.getChildren().get(2).getChildren().get(2).addChild(new GeneralTree<>('M'));
		ag.getChildren().get(2).getChildren().get(2).addChild(new GeneralTree<>('N'));
		
		RedAguaPotable redAgua = new RedAguaPotable(ag);
		System.out.println("Mínimo caudal: " + redAgua.minimoCaudal(1000.0));
		
	}
}
