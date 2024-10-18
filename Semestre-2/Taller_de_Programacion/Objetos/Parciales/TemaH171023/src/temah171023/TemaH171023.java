/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package temah171023;

/**
 *
 * @author nicol
 */
public class TemaH171023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Estadio estadio = new Estadio("Estadio DAM", "Av 32 y Av 25", 50000);

        // Crear un concierto con entradas vendidas
        Concierto concierto1 = new Concierto("Banda X", 100.0, 30000);
        Concierto concierto2 = new Concierto("Banda Y", 150.0, 60000); // Excede la capacidad
        Concierto concierto3= new Concierto("Los Piojos", 120,45000);
        
        // Registrar los conciertos en mayo
        estadio.registrarConcierto(2, concierto3);
        estadio.registrarConcierto(2, concierto1);
        estadio.registrarConcierto(5, concierto1);  // Debería registrarse con éxito
        estadio.registrarConcierto(5, concierto2);
        estadio.registrarConcierto(5, concierto3);// No debería registrarse (excede la capacidad
        
        System.out.println("Para el mes 2");
        System.out.println(estadio.listaMes(2));
        
        System.out.println("Ganancia Mes 2");
        System.out.println(estadio.calcularGananciaMes(2));
        
        System.out.println("Para el mes 5");
        System.out.println(estadio.listaMes(5));
        
        System.out.println("Para todo el año");
        System.out.println(estadio.toString());
        
    }
    
}
