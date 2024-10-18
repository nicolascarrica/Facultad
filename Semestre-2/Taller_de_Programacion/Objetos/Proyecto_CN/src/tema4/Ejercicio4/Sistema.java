/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio4;

/**
 *
 * @author nicol
 */
public abstract class Sistema {
    private Estacion estacion;
    private int anioInicio;
    private int cantidadAnios;
    private final double [][] temperaturas;
    
    public Sistema(Estacion estacion, int anioInicio, int cantidadAnios){
        this.estacion = estacion;
        this.anioInicio = anioInicio;
        this.cantidadAnios = cantidadAnios;
        this.temperaturas = new double [cantidadAnios][12];
        
        for (int i=0; i<cantidadAnios;i++){
            for(int j=0; j<12;j++){
                temperaturas[i][j] = Double.MAX_VALUE;
            }
        }   
    }
    
    public Estacion getEstacion(){
        return estacion;
    }
    
    public void setEstacion(Estacion estacion){
        this.estacion = estacion;
    }
    
    public int getAnioInicio(){
        return anioInicio;
    }
    
    public void setAnioInicio(int anioInicio){
        this.anioInicio = anioInicio;
    }
    
    public int getCantidadAnios(){
        return cantidadAnios;
    }
    
    public void setCantidadAnios(int cantidadAnios){
        this.cantidadAnios = cantidadAnios;
    }
    
    public double getTemperatura (int mes, int anio){
        return this.temperaturas[anio-anioInicio][mes - 1];
    }
    
    public void setTemperatura(int mes, int anio, double temperatura){
        this.temperaturas[anio-anioInicio][mes-1] = temperatura;
    }
    
    
    public String mayorTemp(){
        double maxTemp = Double.MIN_VALUE;
        int anioMax = -1;
        int mesMax = -1;
        for (int i=0; i<cantidadAnios;i++){
            for(int j=0; j<12; j++){
                if(temperaturas[i][j]>maxTemp){
                    maxTemp = temperaturas[i][j];
                    anioMax = anioInicio + i;
                    mesMax = j + 1;
                }
            }
        }
        return "La maxima temperatura fue en el anio " + anioMax + " en el mes " + mesMax;
    }
    
    public abstract String generarReporte();
    
    public String toString() {
        return estacion + "\n" + generarReporte();
    }
    
    
}
