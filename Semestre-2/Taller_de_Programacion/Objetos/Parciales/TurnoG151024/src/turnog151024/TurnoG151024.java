/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnog151024;

/**
 *
 * @author nicol
 */
public class TurnoG151024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Supermecado miSupermecado = new Supermecado("Nini", "520", 5,10);
        
        Producto prod1 = new Producto(1, "prod1", "marca1", 10, 100);
        Producto prod2 = new Producto(1, "prod1", "marca2", 10, 100);
        Producto prod3 = new Producto(2, "prod1", "marca3", 10, 100);
        Producto prod4 = new Producto(3, "prod1", "marca4", 10, 100);
        Producto prod5 = new Producto(4, "prod1", "marca5", 10, 100);
        Producto prod6 = new Producto(5, "prod1", "marca6", 10, 100);
        Producto prod7 = new Producto(6, "prod1", "marca7", 10, 100);
        Producto prod8 = new Producto(6, "prod8", "marca8", 0, 100);
        
        miSupermecado.registrarProducto(prod1, 1, 1);
        miSupermecado.registrarProducto(prod1, 1, 1);
        miSupermecado.registrarProducto(prod3, 2, 1);
        miSupermecado.registrarProducto(prod4, 2, 2);
        miSupermecado.registrarProducto(prod5, 4, 2);
        miSupermecado.registrarProducto(prod6, 4, 1);
        miSupermecado.registrarProducto(prod7, 3, 1);
        miSupermecado.registrarProducto(prod2, 5, 1);
        miSupermecado.registrarProducto(prod8, 2, 5);
        
        System.out.println(miSupermecado.toString());
        
        System.out.println(miSupermecado.liberarEstante(2));
        System.out.println(miSupermecado.toString());
        
        System.out.println("Gondola mas productos");
        int max = miSupermecado.gondolaMasProduto("marca1");
        System.out.println(max);
    }
    
}
