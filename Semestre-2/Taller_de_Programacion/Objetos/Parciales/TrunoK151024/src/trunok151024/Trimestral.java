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
public class Trimestral extends Sistema{

    public Trimestral(String carrera, String facultad, int anioCreacion) {
        super(carrera, facultad, anioCreacion);
    }
    
    public String toString() {
        String aux = "";
        for (int i = 0; i < super.getAniosTotales(); i++) {
            for (int j = 0; j < super.getTrimestres(); j++) {
                int cantidad = super.getEgresados()[i][j];
                aux += "Año: " + (super.getAnioCreacion() + i) + ", Trimestre: " + (j + 1) + ", Egresados: " + (cantidad != -1 ? cantidad : 0) + "\n";
            }
        }
        return super.getCarrera() + " plan " + super.getAnioCreacion() + " - " + super.getFacultad() + "\n" + aux;
    }
}
