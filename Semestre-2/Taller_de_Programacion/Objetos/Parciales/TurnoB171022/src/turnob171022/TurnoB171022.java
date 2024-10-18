/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022;

/**
 *
 * @author nicol
 */
public class TurnoB171022 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Barrio miBarrio = new Barrio("los teros", 6, 9);
        
        Comprador comp1 = new Comprador(123, "nicolas", "Carrica", "Pehuajo");
        Comprador comp2 = new Comprador(123, "Florencia", "Orellana", "La Plata");
        Comprador comp3 = new Comprador(123, "Edinson", "Cavani", "Salto");
        
        miBarrio.agregarComprador(comp3, 1, 1);
        miBarrio.agregarComprador(comp2, 5, 4);
        miBarrio.agregarComprador(comp1, 2, 9);
        
        miBarrio.incrementarPrecio(1, 10);
        
        System.out.println(miBarrio.toString());
    }
    
}
