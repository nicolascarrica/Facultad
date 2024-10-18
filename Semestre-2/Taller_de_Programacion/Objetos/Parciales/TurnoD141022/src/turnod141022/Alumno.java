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
public class Alumno {
    private int dni;
    private String nombre;
    private int asistencias;
    private int autoevaluaciones;
    
    public Alumno(int dni, String nombre){
        this.nombre = nombre;
        this.dni=dni;
        this.asistencias = 0;
        this.autoevaluaciones=0;
    }

    public int getDni() {
        return dni;
    }

    public String getNombre() {
        return nombre;
    }

    public int getAsistencias() {
        return asistencias;
    }

    public int getAutoevaluaciones() {
        return autoevaluaciones;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setAsistencias(int asistencias) {
        this.asistencias = asistencias;
    }

    public void setAutoevaluaciones(int autoevaluaciones) {
        this.autoevaluaciones = autoevaluaciones;
    }
    
}
