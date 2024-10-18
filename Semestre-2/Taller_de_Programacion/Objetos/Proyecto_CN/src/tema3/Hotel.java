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
public class Hotel {
   private Habitacion [] habitaciones;
   private int totalHabitaciones; 
   
   public Hotel (int numero){
       totalHabitaciones = numero;
       habitaciones = new Habitacion[numero];  //inicaliza array de habitaciones vacias
       for (int i = 0; i<numero; i++){
           habitaciones[i] = new Habitacion(); // precio aleatorio para cada una de las hab.
       }
   }
   
   public void ingresarCliente(int numeroHabitacion, Cliente cliente){
       Habitacion habitacion = habitaciones [numeroHabitacion - 1];//la base del array es el cero;
       if(!habitacion.isOcupada()){
           habitacion.setCliente(cliente);
            System.out.println("Cliente ingresado en la habitación " + numeroHabitacion);
       } else {
           System.out.println("la habitacion " + numeroHabitacion + " ya esta ocupada");          
       }
   }
   
   public void aumentarPrecio(double monto){
       for (int i=0; i<totalHabitaciones;i++){
           habitaciones[i].setPrecioPorNoche(habitaciones[i].getPrecioPorNoche() + monto);
       }
       System.out.println("Se ha aumentado el precio de todas las habitaciones en " + monto);
   }
   
   @Override
   public String toString() {
    for (int i = 0; i < totalHabitaciones; i++) {
        String estado = habitaciones[i].isOcupada() ? "ocupada, " + habitaciones[i].getCliente().toString() : "libre";
        double precio = habitaciones[i].getPrecioPorNoche();
        System.out.println("Habitación " + (i + 1) + ": costo=" + precio + ", " + estado);
    }
    return ""; // El retorno es vacío porque solo imprimimos
   }   
}
