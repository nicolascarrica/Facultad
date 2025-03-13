package tp1.ejercicio5;

public class Estadisticas {
	public static int maximo;
	public static int minimo;
	public static double promedio;
	
	// a. usando return
	public static int[] calcularEstadisticasReturn(int[] arr) {
		if(arr==null || arr.length==0) {
			return null;
		}
		
		int max = arr[0];
		int min = arr[0];
		int suma = arr[0];
		
		for(int i=0; i<arr.length; i++) {
			if(arr[i]>max) {
				max=arr[i];
			}
			if(arr[i]<max) {
				min=arr[i];
			}
			suma+=arr[i];
		}
		
		double promedio = (double)suma/arr.length;
		
		return new int[] {max, min, (int)promedio};
	}
	
	//b usando un objeto para almacenar resultados
	public static void calcularEstadisticasParametro(int[] arr, Resultados res) {
		if (arr == null || arr.length == 0 || res == null) {
            return;
        }
		res.maximo = arr[0];
        res.minimo = arr[0];
        int suma = arr[0];
        
        for (int i=1; i<arr.length; i++) {
        	if(arr[i]>res.maximo) {
        		res.maximo = arr[i];
        	}
        	if(arr[i]<res.minimo) {
        		res.minimo = arr[i];
        	}
        	suma+=arr[i];
        }
        
        res.promedio = (double) suma/arr.length;
	}
	
	// c usando varibales estaticas.
	public static void calcularEstadisticasEstaticas(int[] arr) {
        if (arr == null || arr.length == 0) {
            return;
        }
        
        maximo = arr[0];
        minimo = arr[0];
        int suma = arr[0];
        
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > maximo) {
                maximo = arr[i];
            }
            if (arr[i] < minimo) {
                minimo = arr[i];
            }
            suma += arr[i];
        }
        
        promedio = (double) suma / arr.length;
    }
	
	public static void main(String[] args) {
		int[] numeros = {5, 2, 9, 1, 7, 6, 3};
		
		// metodo a
		int[] resultados = calcularEstadisticasReturn(numeros);
		
		System.out.println("Método a - Máximo: " + resultados[0] + 
                ", Mínimo: " + resultados[1] + 
                ", Promedio: " + resultados[2]);
		
		// metodo b
		Resultados res = new Resultados();
		calcularEstadisticasParametro(numeros, res);
		System.out.println("Metodo b - Maximo: " + res.maximo + 
							", Minimo: " + res.minimo + 
							", Promedio: " + res.promedio);
		
		// metodo c
		calcularEstadisticasEstaticas(numeros);
		System.out.println("Método c - Máximo: " + maximo + 
                ", Mínimo: " + minimo + 
                ", Promedio: " + promedio);
	}
	
}
