/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod141022;

/**
 *
 * @author nicol
 */
public class Presencial extends Curso{
    private int numeroAula;

    public Presencial(int numeroAula, int anioCursada, int capacidadMaxima) {
        super(anioCursada, capacidadMaxima);
        this.numeroAula = numeroAula;
    }

    public int getNumeroAula() {
        return numeroAula;
    }

    public void setNumeroAula(int numeroAula) {
        this.numeroAula = numeroAula;
    }
    
    public boolean puedeRendir(Alumno alumno){
        return alumno.getAsistencias()>=3;
    }
    
}
