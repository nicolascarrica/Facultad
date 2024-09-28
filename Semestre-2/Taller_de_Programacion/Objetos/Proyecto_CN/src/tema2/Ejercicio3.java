/*
3- Se realizará un casting para un programa de TV. El casting durará a lo sumo 5 días y en
cada día se entrevistarán a 8 personas en distinto turno.
a) Simular el proceso de inscripción de personas al casting. A cada persona se le pide
nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las
personas primero completan el primer día en turnos sucesivos, luego el segundo día y así
siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los
40 cupos de casting.
Una vez finalizada la inscripción:
b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
NOTA: utilizar la clase Persona. Pensar en la estructura de datos a utilizar. Para comparar
Strings use el método equals.
 */
package tema2;
import PaqueteLectura.*;

/**
 *
 * @author nicolas
 */
public class Ejercicio3 {
    public static void main(String[] args){
        GeneradorAleatorio.iniciar();
        int dias = 5;
        int entrevistas = 8;
        int maxPersonas = dias * entrevistas;
        
        Persona[][] casting = new Persona[dias][entrevistas];
        
        int contadorPersonas = 0;
         String nombre = GeneradorAleatorio.generarString(3);
         while(!nombre.equals("zzz")&& contadorPersonas<maxPersonas){
             int dni = 30000000 + GeneradorAleatorio.generarInt(15000000);
             int edad = 18 + GeneradorAleatorio.generarInt(30);
             Persona persona = new Persona(nombre, dni, edad);
             
             int dia = contadorPersonas/entrevistas;
             int turno = contadorPersonas % entrevistas;
             
             casting[dia][turno] = persona;
             contadorPersonas++;
             
             nombre = GeneradorAleatorio.generarString(3);            
         }
         
         
         //mostrar turnos
         System.out.println("Listado de personas por dia y turno");
         for (int i =0; i<dias; i++) {
             System.out.println("Dia " + (i+1) + ":");
             for(int j=0; j<entrevistas; j++){
                 if(casting[i][j]!=null){
                     System.out.println(" Turno " + (j+1) + ": " + casting[i][j]);
                 } else {
                     System.out.println(" Turno " +  (j+1)+ ": Vacio");
                 }
             }
         }
    }
}
