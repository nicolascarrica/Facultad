/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial17072021;

/**
 *
 * @author nicol
 */
public class Fecha {
    private int cantSalas;
    private Sala [] salas;
    
    public Fecha(int cantSalas, int cantAlunos){
        this.cantSalas = cantSalas;
        this.salas = new Sala[cantSalas];
        for (int i=0; i<cantSalas; i++){
            salas[i]= new Sala(cantAlunos);
        }
    }
    
    public void agregarAlumno(int X, Alumno a){
        salas[X].agregarAlumno(a);
    }
    
    public void asignarTema(){
        for(int i=0; i<cantSalas; i++){
            salas[i].asignarTema();
        }
    }
    
     public String alumnosPorTema(int t) {
        String aux = "";
        for (int i = 0; i < cantSalas; i++) {
            aux += "Sala " + (i + 1) + ":\n" + salas[i].toStringTema(t) + "\n";
        }
        return aux;
    }
    
    public String toString() {
        String aux = "";
        for (int i = 0; i < cantSalas; i++) {
            aux += "Sala " + (i + 1) + ":\n" + salas[i].toString() + "\n";
        }
        return aux;
    }
        
}
    