package tp3.ejercicio7;

import java.util.LinkedList;
import java.util.List;

import tp3.ejercicio1.GeneralTree;

public class Caminos {
	private GeneralTree<Integer> numeros;
	
	public Caminos(GeneralTree<Integer> numeros) {
		this.numeros= numeros;
	}
	
	public List<Integer> caminoHojaMasLejana(){
		List<Integer> camAct= new LinkedList<Integer>();
		List<Integer> camMasLargo = new LinkedList<Integer>();
		if(!numeros.isEmpty()) {
			caminoRecursivo(numeros, camAct, camMasLargo);
		}
		return camMasLargo;
	}
	
	private void caminoRecursivo(GeneralTree<Integer> numeros, List<Integer> camAct, List<Integer> camMasLargo) {
		camAct.add(numeros.getData());
		
		if(numeros.isLeaf()) {
			if(camAct.size()>camMasLargo.size()){
				camMasLargo.clear();
				camMasLargo.addAll(camAct);
			}
		} else {
			for (GeneralTree<Integer> child: numeros.getChildren()) {
				caminoRecursivo(child, camAct, camMasLargo);
			}
		}
		
		camAct.remove(camAct.size() - 1);
	}
	
	public static void main(String[] args) {
		GeneralTree<Integer> ag = new GeneralTree<>(12);
		ag.addChild(new GeneralTree<>(17));
		ag.addChild(new GeneralTree<>(9));
		ag.addChild(new GeneralTree<>(15));
		ag.getChildren().get(0).addChild(new GeneralTree<>(10));
		ag.getChildren().get(0).addChild(new GeneralTree<>(6));
		ag.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(1));
		
		ag.getChildren().get(1).addChild(new GeneralTree<>(8));
		
		ag.getChildren().get(2).addChild(new GeneralTree<>(14));
		ag.getChildren().get(2).addChild(new GeneralTree<>(18));
		ag.getChildren().get(2).getChildren().get(0).addChild(new GeneralTree<>(16));
		ag.getChildren().get(2).getChildren().get(0).addChild(new GeneralTree<>(17));
		
	
		Caminos camino = new Caminos(ag);
		
		System.out.println(camino.caminoHojaMasLejana());
		
		
	}
}
