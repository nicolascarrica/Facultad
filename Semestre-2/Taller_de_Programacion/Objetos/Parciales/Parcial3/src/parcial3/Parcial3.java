/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial3;

/**
 *
 * @author nicol
 */
public class Parcial3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Producto prod1 = new Producto(1,500,"Producto1");
        Producto prod2 = new Producto(2,400,"Producto2");
        Producto prod3 = new Producto(3,550,"Producto3");
        
        CompraMinorista cm = new CompraMinorista(4,1, true);
        cm.agregarProducto(prod3);
        cm.agregarProducto(prod2);
        cm.agregarProducto(prod1);
        System.out.println(cm.toString());
        
        Producto prod4 = new Producto(4,550,"Producto4");
        Producto prod5 = new Producto(5,4050,"Producto5");
        Producto prod6 = new Producto(6,550,"Producto6");
        CompraMayorista cmay = new CompraMayorista(5, 4, 123549);
        cmay.agregarProducto(prod6);
        cmay.agregarProducto(prod5);
        cmay.agregarProducto(prod4);
        System.out.println(cmay.toString());
        
    }
    
}
