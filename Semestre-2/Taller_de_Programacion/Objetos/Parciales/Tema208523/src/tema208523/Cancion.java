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
public class Cancion {
    private String nombre;
    private String compositor;
    private int id;
    private Estudiante ganador;
    private int puntaje;
    
    public Cancion (int id,String nombre, String compositor){
        this.compositor=compositor;
        this.nombre= nombre;
        this.id= id;
        this.puntaje = 0;
        this.ganador = null;
    }

    public Estudiante getGanador() {
        return ganador;
    }

    public void setGanador(Estudiante ganador) {
        this.ganador = ganador;
    }
    
    
    public String getNombre() {
        return nombre;
    }

    public String getCompositor() {
        return compositor;
    }

    public int getId() {
        return id;
    }

    public int getPuntaje() {
        return puntaje;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCompositor(String compositor) {
        this.compositor = compositor;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPuntaje(int puntaje) {
        this.puntaje = puntaje;
    }
    
    public String toString(){
        return "nombre : " +this.getNombre() + " Compositor: "+ this.getCompositor();
    }
    
}
