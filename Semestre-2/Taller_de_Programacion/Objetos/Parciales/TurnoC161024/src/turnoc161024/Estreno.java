/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc161024;

/**
 *
 * @author nicol
 */
public class Estreno {
    private String titulo;
    private String tipoContenido;
    private double recaudacion;
    private int visualizaciones;

    public Estreno(String titulo, String tipoContenido, double recaudacion, int visualizaciones) {
        this.titulo = titulo;
        this.tipoContenido = tipoContenido;
        this.recaudacion = recaudacion;
        this.visualizaciones = visualizaciones;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTipoContenido() {
        return tipoContenido;
    }

    public void setTipoContenido(String tipoContenido) {
        this.tipoContenido = tipoContenido;
    }

    public double getRecaudacion() {
        return recaudacion;
    }

    public void setRecaudacion(double recaudacion) {
        this.recaudacion = recaudacion;
    }

    public int getVisualizaciones() {
        return visualizaciones;
    }

    public void setVisualizaciones(int visualizaciones) {
        this.visualizaciones = visualizaciones;
    }
    
    public String toString(){
        return "Titilo: " + this.getTitulo() + 
                ", tipo de contenido: " + this.getTipoContenido() + 
                ", Recaudacion: " + this.getRecaudacion() + 
                ", canti visualizaciones: " + this.getVisualizaciones();
    }
    
}
