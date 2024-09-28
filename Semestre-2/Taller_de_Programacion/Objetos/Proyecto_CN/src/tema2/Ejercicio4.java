/*
4- Sobre un nuevo programa, modifique el ejercicio anterior para considerar que:
a) Durante el proceso de inscripción se pida a cada persona sus datos (nombre, DNI, edad)
y el día en que se quiere presentar al casting. La persona debe ser inscripta en ese día, en el
siguiente turno disponible. En caso de no existir un turno en ese día, informe la situación.
La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los 40 cupos de
casting.
Una vez finalizada la inscripción:
b) Informar para cada día: la cantidad de inscriptos al casting ese día y el nombre de la
persona a entrevistar en cada turno asignado.
 */
package tema2;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class Ejercicio4 {
    public static void main(String[] args){
        GeneradorAleatorio.iniciar();
        int dias = 5;
        int entrevistas = 8;
        int maxPersonas = dias*entrevistas;
        
        Persona[][] casting = new Persona [dias][entrevistas];
        
        int [] inscriptosPorDia = new int[dias];
        int contadorPersonas = 0;
        
        String nombre = GeneradorAleatorio.generarString(3);
        while (!nombre.equals("zzz")&& contadorPersonas<maxPersonas){
            int dni = 30000000 + GeneradorAleatorio.generarInt(15000000);
            int edad = 18 + GeneradorAleatorio.generarInt(30);
            System.out.println("Ingrese el dia que quiere presentarse (1 a 5)");
            int dia = Lector.leerInt()- 1;
            
            //verificacion de disponibilidad
            if(inscriptosPorDia[dia]< entrevistas){
                int turno = inscriptosPorDia[dia];
                
                Persona persona = new Persona(nombre, dni, edad);
                casting[dia][turno] = persona;
                inscriptosPorDia[dia]++;
                contadorPersonas++;
                
                System.out.println("Persona inscripta en el dia " + (dia+1));                                        
            } else {
                System.out.println("El día " + (dia + 1) + " está completo. No hay más turnos disponibles.");
            }
            
            nombre = GeneradorAleatorio.generarString(3);            
        }
        
        System.out.println("Listado de personas por dia y turno");
        for(int i=0; i<dias; i++){
            System.out.println("Día " + (i + 1) + ":");
            System.out.println("Cantidad de inscriptos: " + inscriptosPorDia[i]);
            
            for(int j=0; j<entrevistas; j++){
                if(casting[i][j]!=null){
                    System.out.println(" Turno " + (j+1) + ": " + casting[i][j]);
                }else {
                    System.out.println(" Turno " + (j+1) + ": Vacio");
                }
            }
        }
    }
}
