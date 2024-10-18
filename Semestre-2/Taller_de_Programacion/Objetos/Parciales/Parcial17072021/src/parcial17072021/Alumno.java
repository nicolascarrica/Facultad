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
public class Alumno {
    private String nombre;
    private int DNI;
    private int tema;
    
    public Alumno(int DNI, String nombre){
        this.nombre = nombre;
        this.DNI = DNI;
        this.tema = -1;
    }

    public String getNombre() {
        return nombre;
    }

    public int getDNI() {
        return DNI;
    }

    public int getTema() {
        return tema;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDNI(int DNI) {
        this.DNI = DNI;
    }

    public void setTema(int tema) {
        this.tema = tema;
    }
    
    public String toString(){
        return "Nombre: " + this.nombre + " DNI: " + this.DNI + " Tema: " + this.tema;
    }
    
}
