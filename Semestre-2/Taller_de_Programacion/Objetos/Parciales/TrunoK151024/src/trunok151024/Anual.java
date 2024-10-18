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
public class Anual extends Sistema{

    public Anual(String carrera, String facultad, int anioCreacion) {
        super(carrera, facultad, anioCreacion);
    }

    private int porAnio(int anio){
        int cantidad=0;
            for(int j=0; j<super.getTrimestres();j++){
                if(super.getEgresados()[anio][j]!=-1){
                    cantidad += super.getEgresados()[anio][j];
                }
 
            }
        return cantidad;
    }
    
    public String toString() {
        String aux = "";
        for (int i = 0; i < super.getAniosTotales(); i++) {
            int cantidad = porAnio(i);
            aux += "Año: " + (super.getAnioCreacion() + i) + ", Egresados: " + cantidad + "\n";
        }
        return super.getCarrera() + " plan " + super.getAnioCreacion() + " - " + super.getFacultad() + "\n" + aux;
    }
    
    
}
