/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023t2;

/**
 *
 * @author nicol
 */
public class TurnoC101023t2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Estacion miEstacion = new Estacion("Avendida 60", 400, 4);
        
        miEstacion.generarventa(1, 1258, 20, "Efectivo");
        miEstacion.generarventa(2, 5488, 40, "Credito");
        miEstacion.generarventa(4, 548, 15, "Credito");
        miEstacion.generarventa(1, 8787, 10, "Debito");
        
        miEstacion.fueraDeServicio(3);
        
        System.out.println(miEstacion.toString());
    }
    
}
