/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022goleadores;

/**
 *
 * @author nicol
 */
public class TurnoB171022Goleadores {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Torneo miTorneo = new Torneo("LPF", 7, 5);
        
        Goleador gole1 = new Goleador("Cavani", "boca", 3);
        Goleador gole2 = new Goleador("Vieto", "Racing", 2);
        Goleador gole3 = new Goleador("Borja", "River", 1);
        Goleador gole4 = new Goleador("Merentiel", "boca", 2);
        Goleador gole5 = new Goleador("Saltita", "indepte", 1);
        Goleador gole6 = new Goleador("Montiel", "indepte", 1);
        Goleador gole7 = new Goleador("Muniain", "Slo", 1);
        
        miTorneo.agregarGoleador(gole1, 1);
        miTorneo.agregarGoleador(gole2, 2);
        miTorneo.agregarGoleador(gole3, 3);
        miTorneo.agregarGoleador(gole4, 4);
        miTorneo.agregarGoleador(gole5, 1);
        miTorneo.agregarGoleador(gole6, 5);
        miTorneo.agregarGoleador(gole7, 6);
        miTorneo.agregarGoleador(gole1, 6);
        miTorneo.agregarGoleador(gole2, 3);
        
        System.out.println(miTorneo.toString());
        
        int cantGoleadores = miTorneo.cantidadGoleadores();
        System.out.println("La cantidad de goleadores es: " + cantGoleadores);
        
        Goleador menor= miTorneo.menosGoles(1);
        
        System.out.println("El que menos goles hizo en la fecha uno es " + menor.getNombre());
    }
    
}
