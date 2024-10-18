/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial1;

/**
 *
 * @author nicol
 */
public class Materia {
    private String nombre;
    private int nota;
    private String fecha;

    public Materia(String nombre, int nota, String fecha) {
        this.nombre = nombre;
        this.nota = nota;
        this.fecha = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public int getNota() {
        return nota;
    }

    public String getFecha() {
        return fecha;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setNota(int nota) {
        this.nota = nota;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    @Override
    public String toString(){
        return " Nombre: " + this.getNombre()+ 
                ", Nota: " + this.getNota() + 
                ", fecha: " + this.getFecha();
    }
}
