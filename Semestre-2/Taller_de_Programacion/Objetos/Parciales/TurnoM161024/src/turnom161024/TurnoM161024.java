/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnom161024;

/**
 *
 * @author nicol
 */
public class TurnoM161024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Minibus minibus1 = new Minibus("AB123CD", 20);
        Minibus minibus2 = new Minibus("AB456CD", 28);
        Viaje miViaje = new Viaje("Normal", "25/10/2024", "Mendoza", minibus1, minibus2);
        
        Alumno al1 = new Alumno(123, "nicolas", 123, "ospe");
        Alumno al2 = new Alumno(234, "jose", 120, "ioma");
        Alumno al3 = new Alumno(567, "sofia", 11, "osde");
        Alumno al4 = new Alumno(890, "laura", 12, "ioma");
        Alumno al5 = new Alumno(012, "juan", 153, "ospe");
        Alumno al6 = new Alumno(344, "nico", 15, "ospe");
        
        System.out.println(miViaje.agregarAlviaje(al1));
        miViaje.agregarAlviaje(al2);
        miViaje.agregarAlviaje(al3);
        miViaje.agregarAlviaje(al4);
        miViaje.agregarAlviaje(al5);
        miViaje.agregarAlviaje(al6);
        miViaje.agregarAlviaje(al5);
        miViaje.agregarAlviaje(al6);
        miViaje.agregarAlviaje(al5);
        miViaje.agregarAlviaje(al6);
        miViaje.agregarAlviaje(al5);
        miViaje.agregarAlviaje(al6);
        
        
        System.out.println(miViaje.toString());
        
        miViaje.aisgnarPoliza(123, 0000);
        System.out.println(miViaje.toString());
    }
    
}
