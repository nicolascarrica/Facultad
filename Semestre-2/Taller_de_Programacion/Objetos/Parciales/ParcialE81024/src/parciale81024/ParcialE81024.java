/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parciale81024;

/**
 *
 * @author nicol
 */
public class ParcialE81024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Caja micaja1 = new Caja("Jose", 5);
        Caja micaja2 = new Caja("Juan", 4);
        Caja micaja3 = new Caja("Nicolas", 5);
        Caja micaja4 = new Caja("beto", 4);
        Caja micaja5 = new Caja("Washington", 3);
        Supermercado miSupermercado = new Supermercado("calle 41");
        
        miSupermercado.agregarCaja(micaja1);
        miSupermercado.agregarCaja(micaja2);
        miSupermercado.agregarCaja(micaja3);
        miSupermercado.agregarCaja(micaja4);
        miSupermercado.agregarCaja(micaja5);
        
        miSupermercado.generarTicket(5, 5551, 2, 500, "Credito");
        miSupermercado.generarTicket(1, 5551, 2, 1500, "Debito");
        miSupermercado.generarTicket(2, 5551, 2, 4500, "Credito");
        miSupermercado.generarTicket(3, 5521, 2, 5400, "Efectivo");
        miSupermercado.generarTicket(4, 5551, 2, 5050, "Debito");
        miSupermercado.generarTicket(2, 5551, 2, 5005, "Efectivo");
        miSupermercado.generarTicket(4, 5551, 2, 6500, "Debito");
        miSupermercado.generarTicket(1, 5551, 2, 7700, "Credito");
        miSupermercado.generarTicket(5, 5551, 2, 800, "Credito");
        
        System.out.println(miSupermercado.toString());
        
        System.out.println("menos credito");
        System.out.println(miSupermercado.cajaMenorCredito());
        
    }
    
}
