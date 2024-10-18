/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnom161024;

/**
 *
 * @author nicol
 */
public class Alumno {
    private int dni;
    private String nombre;
    private int poliza;
    private String obraSocial;

    public Alumno(int dni, String nombre, int poliza, String obraSocial) {
        this.dni = dni;
        this.nombre = nombre;
        this.poliza = poliza;
        this.obraSocial = obraSocial;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPoliza() {
        return poliza;
    }

    public void setPoliza(int poliza) {
        this.poliza = poliza;
    }

    public String getObraSocial() {
        return obraSocial;
    }

    public void setObraSocial(String obraSocial) {
        this.obraSocial = obraSocial;
    }
    
    public String toString(){
        return "Dni Alumbo: " + this.getDni() + 
                ", nombre y apellido: " + this.getNombre()+
                ", poliza: " + this.getPoliza() + 
                ", Obra Social: " + this.getObraSocial();
    }
}
