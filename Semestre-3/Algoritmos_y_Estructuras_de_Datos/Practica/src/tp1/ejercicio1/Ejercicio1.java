package tp1.ejercicio1;

public class Ejercicio1 {
	public static void imprimirConFor(int a, int b) {
		for(int i=a; i<=b; i++) {
			System.out.println(i);
		}
	}
	
	public static void imprimirConWhile(int a, int b){
        while (a<=b){
             System.out.println(a);
             a++;
        }
    }
    
    public static void imprimirSinEstructura(int a , int b){
        if(a<=b){
            System.out.println(a);
            imprimirSinEstructura(a+1, b);
        }
    }
    
    public static void main(String [] args){
        System.out.println("Usando For");
        imprimirConFor(1, 10);
        System.out.println("Usando while");
        //imprimirConWhile(5, 15);
        //System.out.println("Sin EDC");
        //imprimirSinEstructura(5, 15);
    }
}
