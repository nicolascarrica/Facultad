/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof81024;

/**
 *
 * @author nicol
 */
public class TurnoF81024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        
        Libreria miLibreria=new Libreria("Central", 5);
        
        miLibreria.agregarTicket(1, 1255, 5, 250, "Debito");
        miLibreria.agregarTicket(1, 1256, 1, 5, "Efectivo");
        miLibreria.agregarTicket(3, 1257, 5, 705, "Credito");
        miLibreria.agregarTicket(2, 1258, 1, 200, "Debito");
        miLibreria.agregarTicket(4, 1255, 4, 150, "Efectivo");
        
        System.out.println(miLibreria.toString());
        
        miLibreria.marcarNoDisponilble(2);
        System.out.println(miLibreria.toString());
        
        System.out.println(miLibreria.mayotTicketLibreria());
        
    }
    
}
