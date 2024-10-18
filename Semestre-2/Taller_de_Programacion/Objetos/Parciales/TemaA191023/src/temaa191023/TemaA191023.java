/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package temaa191023;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class TemaA191023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        GeneradorAleatorio.iniciar();;
        Fecha f= new Fecha(12, 12, 2023);
        Compra miCompra = new Compra(25, f, 10);
        CompraMayor miCompraMayor = new CompraMayor(29, f, 10, "Rulo", 5565);
        
        for (int i=0; i<5;i++){
            Producto p = new Producto(GeneradorAleatorio.generarInt(30), GeneradorAleatorio.generarString(6), GeneradorAleatorio.generarDouble(150000), GeneradorAleatorio.generarInt(10));
            Producto p2 = new Producto(GeneradorAleatorio.generarInt(30), GeneradorAleatorio.generarString(6), GeneradorAleatorio.generarDouble(150000), GeneradorAleatorio.generarInt(10));
            miCompra.agregarCompra(p);
            miCompraMayor.agregarCompra(p2);
        }
        
        System.out.println("COMPRA NORMAL");
        System.out.println(miCompra.ResumenCompra());
        if(miCompra.enCuotas()==true){
            System.out.println("Se puede hacer en cuotas");
        }else 
            System.out.println("No se puede en cuotas");
        
        System.out.println("COMPRA MAYORISTA");
        System.out.println(miCompraMayor.ResumenCompra());
        if(miCompraMayor.enCuotas()==true){
            System.out.println("se puede en cuotas");
        } else System.out.println("No se puede en cuotas");
        
        
    }
    
    
}
