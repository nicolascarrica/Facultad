/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial17072021;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class Sala {
    private int capacidadMaxima;
    private int cantidadAlumnos;
    private Alumno [] alumnos;

    public Sala(int capacidadMaxima) {
        this.capacidadMaxima = capacidadMaxima;
        this.cantidadAlumnos = 0;
        this.alumnos = new Alumno [capacidadMaxima];
    }
    
    public void agregarAlumno(Alumno a){
        if(this.cantidadAlumnos < this.capacidadMaxima){
            this.alumnos[cantidadAlumnos] = a;
            cantidadAlumnos ++;
        }
    }
    
    public int getCantidadAlumnos(){
        return cantidadAlumnos;
    }
    
    public void asignarTema(){
        GeneradorAleatorio.iniciar();
        for (int i=0; i<cantidadAlumnos; i++){
            alumnos[i].setTema(1 + GeneradorAleatorio.generarInt(capacidadMaxima));
        }
    }
    
    public String toStringTema(int t){
        String aux="";
        for (int i=0; i<cantidadAlumnos;i++){
            if(alumnos[i].getTema()==t){
                aux+= alumnos[i].toString() + "\n";
            }    
        }
        return aux;
    }
    
    @Override
    public String toString() {
        String aux = "";
        for (int i = 0; i < cantidadAlumnos; i++) {
            aux += alumnos[i].toString() + "\n";
        }
        return aux;
    }
    
}
