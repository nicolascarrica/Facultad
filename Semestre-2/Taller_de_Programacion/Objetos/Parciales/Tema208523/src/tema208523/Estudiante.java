/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema208523;

/**
 *
 * @author nicol
 */
public class Estudiante {
    private String nombre;
    private String apellido;
    private int dni;

    public Estudiante(String nombre, String apellido, int dni) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public int getDni() {
        return dni;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }
    
    public String toString(){
        return "nombre: " + this.nombre + 
                "Apellido: " + this.apellido + 
                "dni: " + this.dni;
    }
}