/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial2;

/**
 *
 * @author nicol
 */
public class Alumno {
    private String nombre;
    private int edad;
    private String instrumento;
    private int puntaje;
    
    public Alumno(String nombre, int edad, String instrumento){
        this.nombre = nombre;
        this.edad = edad;
        this.instrumento = instrumento;
        this.puntaje = -1;
    }

    public String getNombre() {
        return nombre;
    }

    public int getEdad() {
        return edad;
    }

    public String getInstrumento() {
        return instrumento;
    }

    public int getPuntaje() {
        return puntaje;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setInstrumento(String instrumento) {
        this.instrumento = instrumento;
    }

    public void setPuntaje(int puntaje) {
        this.puntaje = puntaje;
    }
    
    @Override
    public String toString(){
        return "Nombre: " + this.getNombre() + 
                ", Edad: " + this.getEdad() + 
                ", Instrumento: " + this.getInstrumento() + 
                ", puntaje " + this.getPuntaje();
    }
    
}
