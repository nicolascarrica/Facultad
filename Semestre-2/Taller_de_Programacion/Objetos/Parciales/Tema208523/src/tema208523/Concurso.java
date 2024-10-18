/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema208523;

/**
 *
 * @author nicol
 */
public class Concurso {
    private int maxCategorias;
    private int maxCanciones;
    private Cancion[][] canciones;
    private int [] vectorDimL;
    
    public Concurso(int maxCategorias, int maxCanciones){
        this.maxCanciones = maxCanciones;
        this.maxCategorias= maxCategorias;
        this.canciones = new Cancion[maxCategorias][maxCanciones];
        this.vectorDimL = new int[maxCategorias];
        iniciarVDimL();
    }
    
    private void iniciarVDimL(){
        for(int i=0; i<maxCategorias; i++){
            vectorDimL[i]=0;
        }
    }
    
    public void agregarCancion(Cancion cancion, int categoria){
        canciones[categoria-1][vectorDimL[categoria-1]] = cancion;
        vectorDimL[categoria-1]+=1;
    }
    
    public void interpretarCancion(int id, Estudiante estudiante, int puntaje){
        boolean encontro = false;
        int i=0;
        while(i<maxCategorias && !encontro){
            int j=0;
            while(j<vectorDimL[i] && canciones[i][j].getId()!=id){
                j++;             
            }
            if(j<vectorDimL[i]){
                encontro=true;
                if(canciones[i][j].getPuntaje()<puntaje){
                    canciones[i][j].setPuntaje(puntaje);
                    canciones[i][j].setGanador(estudiante);   
                }
            }
            i++;
        }
    }
    
    public Estudiante conocerGanador(int id){
        boolean encontro = false;
        Estudiante ganador = null;
        int i=0;
        while(i<maxCategorias && !encontro){
            int j=0;
            while(j<vectorDimL[i] && canciones[i][j].getId()!=id){
                j++;
            }
            if(j<vectorDimL[i]){
                encontro=true;
                if(canciones[i][j].getGanador()!=null){
                    ganador = canciones[i][j].getGanador();
                } 
            }
            i++;
        }
        return ganador;
    }
    
    public Cancion mayorPuntaje(){
        Cancion mejorCancion = null;
        int puntajeMax = 0;
        for(int i=0;i<maxCategorias;i++){
            for(int j=0;j<vectorDimL[i];j++){
                if(canciones[i][j].getPuntaje()> puntajeMax){
                    puntajeMax=canciones[i][j].getPuntaje();
                    mejorCancion=canciones[i][j];
                }
            }
        }
        return mejorCancion;
    }
    
    
}
