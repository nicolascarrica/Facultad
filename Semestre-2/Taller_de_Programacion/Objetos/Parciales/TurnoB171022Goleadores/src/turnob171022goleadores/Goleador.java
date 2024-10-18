/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022goleadores;

/**
 *
 * @author nicol
 */
public class Goleador {
    private String nombre;
    private String equipo;
    private int goles;

    public Goleador(String nombre, String equipo, int goles) {
        this.nombre = nombre;
        this.equipo = equipo;
        this.goles = goles;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEquipo() {
        return equipo;
    }

    public int getGoles() {
        return goles;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setEquipo(String equipo) {
        this.equipo = equipo;
    }

    public void setGoles(int goles) {
        this.goles = goles;
    }
    
    public String toString(){
        return "Nombre: " + this.getNombre() + 
                ", Equipo: " + this.getEquipo() + 
                ", cantidad Goles: " + this.getGoles() + " ;";
    }
    
}
