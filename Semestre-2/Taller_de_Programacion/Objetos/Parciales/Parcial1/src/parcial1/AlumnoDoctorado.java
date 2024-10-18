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
public class AlumnoDoctorado extends Alumno{
    private String titulo;
    private String  universidad;

    public AlumnoDoctorado(int dni, String nombre, int maxMaterias,String titulo, String universidad) {
        super(dni, nombre, maxMaterias);
        this.titulo = titulo;
        this.universidad = universidad;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getUniversidad() {
        return universidad;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setUniversidad(String universidad) {
        this.universidad = universidad;
    }
    
    public String toString(){
        String aux = super.toString();
        return aux + " " + this.getTitulo() + " " + this.getUniversidad();
    }
    
}
