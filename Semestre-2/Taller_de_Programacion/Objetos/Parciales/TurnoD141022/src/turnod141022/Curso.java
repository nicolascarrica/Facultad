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
public abstract class Curso {
    private int anioCursada;
    private Alumno [] alumnos;
    private int capacidadMaxima;
    private int dimL;
    
    public Curso(int anioCursada, int capacidadMaxima){
        this.anioCursada = anioCursada;
        this.capacidadMaxima = capacidadMaxima;
        this.alumnos = new Alumno[capacidadMaxima];
        this.dimL = 0;
    }

    public int getAnioCursada() {
        return anioCursada;
    }

    public int getCapacidadMaxima() {
        return capacidadMaxima;
    }

    public void setAnioCursada(int anioCursada) {
        this.anioCursada = anioCursada;
    }

    public void setCapacidadMaxima(int capacidadMaxima) {
        this.capacidadMaxima = capacidadMaxima;
    }
    
    public boolean agregarAlumno(Alumno al){
        if(this.dimL<this.capacidadMaxima){
            alumnos[dimL]= al;
            this.dimL ++;
            return true;
        }else{
            return false;
        }
    }
    
    public int encontrarAlumno(int dni){
        boolean encontro = false;
        int posAlu = -1;
        int i=0;
        while((i<dimL)&&(!encontro)){
            if(alumnos[i].getDni()==dni){
                encontro=true;
                posAlu = i;
            }
            i++;
        }
        return posAlu;
    }
    
    public void incrementarAsistencia(int dni){
        int posAlu=this.encontrarAlumno(dni);
        if (posAlu!=-1){
             alumnos[posAlu].setAsistencias(alumnos[posAlu].getAsistencias() + 1);
        }
    }
    
    public void aprobarAutoevaluaciones(int dni){
        int posAlu=this.encontrarAlumno(dni);
        if (posAlu!=-1){
             alumnos[posAlu].setAutoevaluaciones(alumnos[posAlu].getAutoevaluaciones()+ 1);
        }
    }
    
    public abstract boolean puedeRendir(Alumno alumno);
    
    public int cantidadDeAlumnosQuePuedenRendir(){
        int total=0;
        for(int i=0; i<dimL; i++){
            if(puedeRendir(alumnos[i])){
                total++;
            }
        }
        return total;
    }
    
    
    
    
}
