/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoh151024;

/**
 *
 * @author nicol
 */
public class TurnoH151024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Supermercado miSuper = new Supermercado("Nico", "41 y 8", 5, 4);
        
        Producto prod1 = new Producto(1, "nom1", "marca1", 10, 120);
        Producto prod2 = new Producto(2, "nom2", "marca2", 10, 150);
        Producto prod3 = new Producto(3, "nom3", "marca3", 12, 150);
        Producto prod4 = new Producto(4, "nom4", "marca4", 15, 150);
        Producto prod5 = new Producto(5, "nom5", "marca1", 12, 150);
        Producto prod6 = new Producto(6, "nom6", "marca2", 10, 150);
       
        miSuper.agregarProducto(prod1);
        miSuper.agregarProducto(prod2);
        miSuper.agregarProducto(prod3);
        miSuper.agregarProducto(prod4);
        miSuper.agregarProducto(prod5);
        miSuper.agregarProducto(prod6);
        
        System.out.println(miSuper.toString());
        
        int max = miSuper.gondolaMayotCantidad();
        
        System.out.println("La gondola de mayor cantidad es: "+ max);
        
        System.out.println(miSuper.listarProductos("marca1", 1));
        
        
        
    }
    
}
