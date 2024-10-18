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
public class Cliente {
    private String nombre;
    private int dni;
    private int edad;
    
    public Cliente(String nombre, int  dni, int edad){
        this.nombre = nombre;
        this.dni = dni;
        this.edad =edad;
    }
    
    public String genNombre(){
        return nombre;
    }
    
    public int getDni(){
        return dni;
    }
    
    public int getEdad(){
        return edad;
    }
    
    public void setNombre(String nombre){
        this.nombre=nombre;
    }
    
    public void setDni (int dni){
        this.dni=dni;
    }
    
    public void setEdad(int edad){
        this.edad=edad;
    }
    
    @Override
    public String toString() {
        return  nombre + 
                "\nDNI: " + dni + 
                "\nEdad: " + edad;
    }
}
