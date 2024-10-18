/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trunok151024;

/**
 *
 * @author nicol
 */
public abstract class Sistema {
    private String carrera;
    private String facultad;
    private int anioCreacion;
    private int [][] egresados;
    private int aniosTotales;
    private int trimestres;
    
    public Sistema(String carrera, String facultad, int anioCreacion){
        this.carrera = carrera;
        this.facultad = facultad;
        this.anioCreacion=anioCreacion;
        this.aniosTotales = 2024 - anioCreacion;
        this.trimestres =4;
        this.egresados = new int[aniosTotales][trimestres];
        iniciarSistema();
        
    }
    
    private void iniciarSistema(){
        for(int i=0; i<aniosTotales; i++){
            for(int j=0; j<trimestres; j++){
                egresados[i][j]=-1;
            }
        }
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getFacultad() {
        return facultad;
    }

    public void setFacultad(String facultad) {
        this.facultad = facultad;
    }

    public int getAnioCreacion() {
        return anioCreacion;
    }

    public void setAnioCreacion(int anioCreacion) {
        this.anioCreacion = anioCreacion;
    }

    public int[][] getEgresados() {
        return egresados;
    }

    public void setEgresados(int[][] egresados) {
        this.egresados = egresados;
    }

    public int getAniosTotales() {
        return aniosTotales;
    }

    public void setAniosTotales(int aniosTotales) {
        this.aniosTotales = aniosTotales;
    }

    public int getTrimestres() {
        return trimestres;
    }

    public void setTrimestres(int trimestres) {
        this.trimestres = trimestres;
    }
    
    
    public void registrarEgresados(int cantidad, int anio, int trimestre){
        egresados[anio-this.anioCreacion][trimestre-1]=cantidad;
    }
    
    public int cantidadEgresados(int anio, int trimestre){
       int cantidad = egresados[anio - this.anioCreacion][trimestre - 1];
       return cantidad != -1 ? cantidad : 0;
    }
    
    public int cantidadXSemestreIgualAValor(int cantidad){
        int total=0;
        for(int i=0; i<aniosTotales; i++){
            for(int j=0; j<trimestres; j++){
                if(egresados[i][j]==cantidad){
                    total++;
                }
            }
        }
        return total;
    }
    
    public abstract String toString();
    
    
    
}
