/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;

/**
 *
 * @author nicol
 */
public class Ejericicio4 {
    public static void main(String[] args) {
        Hotel miHotel = new Hotel(5);
        
        //Iniciar clientes
        Cliente cliente1 = new Cliente("Nicolas", 35407725 , 33);
        Cliente cliente2 = new Cliente("Florencia", 36956546, 32);
        
        miHotel.ingresarCliente(1, cliente2);
        miHotel.ingresarCliente(3, cliente1);
        
        // Mostrar el estado del hotel
        System.out.println("Estado del hotel:");
        System.out.println(miHotel.toString());
        
        //Aumentar el precio
        miHotel.aumentarPrecio(200);
        
        //Mostrar Actual
        System.out.println("Nuevo Estado del hotel:");
        System.out.println(miHotel.toString());
    }
    
}
