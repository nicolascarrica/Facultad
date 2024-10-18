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
public class AlumnoGrado extends Alumno {
    private String carrera;

    public AlumnoGrado(int dni, String nombre, int maxMaterias,String carrera) {
        super(dni, nombre, maxMaterias);
        this.carrera = carrera;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }
    
    
    @Override
    public String toString(){
        String aux= super.toString();
        return aux + " " + this.getCarrera();
    }
    
    
}
