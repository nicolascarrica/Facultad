/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod101023;

/**
 *
 * @author nicol
 */
public class TurnoD101023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Vehiculo v1 = new Vehiculo ("ABBA",5, "VW","GOL");
        Vehiculo v2 = new Vehiculo("asdas", 4, "Toyota", "Corolla");
        Vehiculo v3 = new Vehiculo("asdass", 3, "Toyota", "S10");
        Vehiculo v4 = new Vehiculo("ssad", 2, "renault", "Clio");
        
        Estacionamiento miEstacionamiento = new Estacionamiento("41 682", 1500, 4, 4);
        
        miEstacionamiento.agregarAuto(v1, 2, 1);
        miEstacionamiento.agregarAuto(v2, 1, 2);
        miEstacionamiento.agregarAuto(v3, 4,3);
        miEstacionamiento.agregarAuto(v4, 2, 3);
        
        System.out.println(miEstacionamiento.liberarMarca(2, "VW"));
        
        System.out.println(miEstacionamiento.toString());
        int sector = miEstacionamiento.sectorMasRecaudo();
        System.out.println(sector);
        
        
        
    }
    
}
