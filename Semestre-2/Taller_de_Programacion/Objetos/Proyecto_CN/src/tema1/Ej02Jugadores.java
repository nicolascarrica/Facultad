
package tema1;

//import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class Ej02Jugadores {

  
    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        int Df = 15;
        
        //Paso 3: Crear el vector para 15 double 
        double [] jugadores =new double [15];
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i;
                
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        double total=0;
        for (i=0; i<Df; i++) {
            System.out.println("Ingrese altura jugador " +(i+1));
            jugadores [i] = 1.5 + GeneradorAleatorio.generarDouble(2);
            total = total + jugadores[i];
        }
        System.out.println("la cantdidad es " + total);
        
        //Paso 7: Calcular el promedio de alturas, informarlo
        double promedio = total /Df;
        System.out.println("el promedio de alturas es: " + promedio);
        
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        int mayorAProm =0;
        for (i=1; i<Df; i++){
            if(jugadores[i]> promedio)
                mayorAProm++;
        }
        //Paso 9: Informar la cantidad.
        System.out.println("hay " + mayorAProm +"juagadores que su altura supera el promedio");
    }
    
}
