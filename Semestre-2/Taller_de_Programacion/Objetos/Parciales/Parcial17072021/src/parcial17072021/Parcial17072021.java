/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial17072021;

/**
 *
 * @author nicol
 */
public class Parcial17072021 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Fecha miFecha = new Fecha(2,4);
        
        Alumno alu1 = new Alumno(123, "nico");
        Alumno alu2 = new Alumno(233, "Juan");
        Alumno alu3 = new Alumno(433, "Flor");
        Alumno alu4 = new Alumno(413, "Jesus");
        Alumno alu5 = new Alumno(444, "Ale");
        
        miFecha.agregarAlumno(0, alu5);
        miFecha.agregarAlumno(0, alu2);
        miFecha.agregarAlumno(1, alu3);
        miFecha.agregarAlumno(1, alu4);
        miFecha.agregarAlumno(1, alu1);
        
        miFecha.asignarTema();
        
        System.out.println("Estado de las salas y alumnos:");
        System.out.println(miFecha.toString());
        
        System.out.println("Alumnos que rinden el tema 2:");
        System.out.println(miFecha.alumnosPorTema(3));
    }
    
}
