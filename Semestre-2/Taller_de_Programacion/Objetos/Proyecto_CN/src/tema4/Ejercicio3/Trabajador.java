/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio3;

/**
 *
 * @author nicol
 */
public class Trabajador extends Persona {
    private String ocupacion;
    
    public Trabajador(String nombre, int DNI, int edad, String ocupacion){
        super(nombre, DNI, edad);
        this.setOcupacion(ocupacion);
    }
    
    public void setOcupacion(String ocupacion){
        this.ocupacion = ocupacion;
    }
    
    public String getOcupacion(){
        return ocupacion;
    }
    
    public String toString(){
        String aux = super.toString() + " Soy " + this.getOcupacion();
        return aux;
    }
}
