/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023;

/**
 *
 * @author nicol
 */
public class TurnoC101023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Estacion miEstacion = new Estacion("7 y 49");
        
        Surtidor surt1 = new Surtidor("Diesel", 1500, 7);
        Surtidor surt2 = new Surtidor("Super", 1450, 6);
        Surtidor surt3 = new Surtidor("Infinia", 1700, 4);
        
        miEstacion.AgregarSurtidor(surt1);
        miEstacion.AgregarSurtidor(surt2);
        miEstacion.AgregarSurtidor(surt3);
        
        miEstacion.generarVenta(3, 3540777, 50, "Efectivo");
        miEstacion.generarVenta(3, 354546, 20, "Efectivo");
        miEstacion.generarVenta(3, 56465, 40, "Credito");
        miEstacion.generarVenta(1, 5468879, 35, "Debito");
        
        System.out.println(miEstacion.toString());
        
        int mayor = miEstacion.surtidorMayorMonto();
        System.out.println("mayor venta surtidor: " + mayor);
        
    }
    
}
