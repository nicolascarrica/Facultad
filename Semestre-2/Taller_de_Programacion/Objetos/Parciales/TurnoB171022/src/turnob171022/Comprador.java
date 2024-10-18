/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022;

/**
 *
 * @author nicol
 */
public class Comprador {
    private int dni;
    private String nombre;
    private String apellido;
    private String ciudad;

    public Comprador(int dni, String nombre, String apellido, String ciudad) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.ciudad = ciudad;
    }

    public int getDni() {
        return dni;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }
    
    public String toString(){
        return "[Dni: " +this.getDni() + 
                " - Apellido: " + this.getApellido()+
                ", Nombre: " + this.getNombre() + 
                " - ciudad: " +this.getCiudad() +"]";
    }
}
