package tp3.ejercicio4;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;
// se usa reocrrido por niveles para procesar la tardanza de todos los noddos del nivel y luego dividir por la cantidad
public class AnalizadorArbol {
	public double devolverMaximoPromedio(GeneralTree<AreaEmpresa> arbol) {
		if((arbol==null) || arbol.isEmpty()) {
			return 0;
		}
		Queue<GeneralTree<AreaEmpresa>>cola = new Queue<>();
		cola.enqueue(arbol);
		double maxProm = 0;
		while(!cola.isEmpty()) {
			int nivelSize = cola.size();
			int sumaNiveles = 0;
			
			for(int i=0;  i< nivelSize; i++) {
				GeneralTree<AreaEmpresa> nodo = cola.dequeue();
				sumaNiveles += nodo.getData().getTardanza();
				
				for(GeneralTree<AreaEmpresa> hijo: nodo.getChildren()) {
					cola.enqueue(hijo);
				}
			}
			
			double promedioNivel = (double) sumaNiveles/nivelSize;
			if(promedioNivel>maxProm) {
				maxProm=promedioNivel;
			}
		}
		return maxProm;
	}
	
	public static void main(String[] args) {
		GeneralTree<AreaEmpresa> ag= new GeneralTree<>(new AreaEmpresa("M", 14));
		ag.addChild(new GeneralTree<>(new AreaEmpresa("J",13)));
		ag.addChild(new GeneralTree<>(new AreaEmpresa("K",25)));
		ag.addChild(new GeneralTree<>(new AreaEmpresa("L",10)));
		ag.getChildren().get(0).addChild(new GeneralTree<>(new AreaEmpresa("B", 7)));
	    ag.getChildren().get(0).addChild(new GeneralTree<>(new AreaEmpresa("C", 5)));
	    ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("D", 6)));
	    ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("E", 10)));
	    ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("F", 18)));
	    ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("G", 9)));
	    ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("H", 12)));
	    ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("I", 19)));
		
	    AnalizadorArbol analizador = new AnalizadorArbol();
	    
	    double promedioMaximo = analizador.devolverMaximoPromedio(ag);
	    System.out.println("El promedio maximo es:" +  promedioMaximo);
	}
}
