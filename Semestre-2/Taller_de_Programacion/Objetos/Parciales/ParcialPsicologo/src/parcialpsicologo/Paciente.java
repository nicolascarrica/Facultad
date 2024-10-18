/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcialpsicologo;

/**
 *
 * @author nicol
 */
public class Paciente {
    private String nombre;
    private boolean obraSocial;
    private double costoSesion;

    public Paciente(String nombre, boolean obraSocial, double costoSesion) {
        this.nombre = nombre;
        this.obraSocial = obraSocial;
        this.costoSesion = costoSesion;
    }

    public String getNombre() {
        return nombre;
    }

    public boolean isObraSocial() {
        return obraSocial;
    }

    public double getCostoSesion() {
        return costoSesion;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setObraSocial(boolean obraSocial) {
        this.obraSocial = obraSocial;
    }

    public void setCostoSesion(double costoSesion) {
        this.costoSesion = costoSesion;
    }
    
    public String toString(){
        return "nombre: " +this.getNombre();
    }
            
}
