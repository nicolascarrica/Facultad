/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial2;

/**
 *
 * @author nicol
 */
public class Parcial2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Concierto miConcierto = new Concierto(20);
        
        Alumno alu1 = new Alumno("Nico", 12, "Guitarra");
        Alumno alu2 = new Alumno("Luis", 15, "Piano");
        Alumno alu3 = new Alumno("Chiqui", 16, "Flauta");
        Alumno alu4 = new Alumno("Dario", 24, "bateria");
        Alumno alu5 = new Alumno("Pablo", 18, "Bajo");
        
        miConcierto.agregarAlumno(alu5, 0);
        miConcierto.agregarAlumno(alu4, 1);
        miConcierto.agregarAlumno(alu3, 2);
        miConcierto.agregarAlumno(alu2, 0);
        miConcierto.agregarAlumno(alu1, 4);
        
        miConcierto.asignarPuntaje(10, "Nico");
        miConcierto.asignarPuntaje(7, "Luis");
        miConcierto.asignarPuntaje(9, "Chiqui");
        miConcierto.asignarPuntaje(8, "Dario");
        miConcierto.asignarPuntaje(10, "Pablo");
        
        String salida = miConcierto.toString();
        System.out.println(salida);
    }
    
}
