/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod141022;

/**
 *
 * @author nicol
 */
public class TurnoD141022 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Presencial presencial = new Presencial(1, 2024, 15);
        Distancia distancia = new Distancia("www.com", 2023, 20);
        
        Alumno alu1 = new Alumno (123, "Nico");
        Alumno alu2 = new Alumno (456, "leo");
        Alumno alu3 = new Alumno(678, "nestor");
        Alumno alu4 = new Alumno(889, "Ciro");
        Alumno alu5 = new Alumno (123, "Sofi");
        Alumno alu6 = new Alumno (486, "Anto");
        Alumno alu7 = new Alumno(689, "Paco");
        Alumno alu8 = new Alumno(849, "Chucho");
        
        presencial.agregarAlumno(alu8);
        presencial.agregarAlumno(alu7);
        presencial.agregarAlumno(alu6);
        
        distancia.agregarAlumno(alu5);
        distancia.agregarAlumno(alu4);
        distancia.agregarAlumno(alu3);
        distancia.agregarAlumno(alu2);
        distancia.agregarAlumno(alu1);
        
        for(int i=0; i<4;i++){
            distancia.incrementarAsistencia(123);
            distancia.aprobarAutoevaluaciones(123);
            distancia.incrementarAsistencia(456);
            distancia.aprobarAutoevaluaciones(456);
            presencial.incrementarAsistencia(849);
        }
        
        System.out.println("Presencial, pueden rendir: ");
        System.out.println(presencial.cantidadDeAlumnosQuePuedenRendir());
        
        
        System.out.println("Distancia, pueden rendir: ");
        System.out.println(distancia.cantidadDeAlumnosQuePuedenRendir());
        
        
        
    }
    
}
