/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial2;

/**
 *
 * @author nicol
 */
public class Concierto {
    private Alumno [][] concursantes;
    private int [] cantidadConcursantes;
    
    public Concierto(int n){
        this.concursantes = new Alumno[5][n];
        this.cantidadConcursantes = new int [5];
        for (int i=0; i<5;i++){
            cantidadConcursantes[i]=0;
        }
        for (int i=0; i<5; i++){
            for(int j=0; j<n;j++){
                this.concursantes[i][j] = new Alumno ("vacio",0,"vacio"); 
            }
        }
    }
    
  
    
    public void agregarAlumno(Alumno a, int gen){
        concursantes[gen][this.cantidadConcursantes[gen]] = a;
        this.cantidadConcursantes[gen]++;
    }
    
    public void asignarPuntaje(int puntaje, String nombre){
        boolean encontro = false;
        int i =0;
        while((i<5)&&(!encontro)){
            int j = 0;
            while((j<this.cantidadConcursantes[i])&&(!encontro)){
                if(this.concursantes[i][j].getNombre().equals(nombre)){
                    encontro=true;
                    this.concursantes[i][j].setPuntaje(puntaje);
                }
                j++;
            }
            i++;
            
        }
    }
    
    public int generoMayor(){
        int maxCantidad = 0;
        int maxGenero = 0;
        for(int i=0;i<5;i++){
            if(this.cantidadConcursantes[i]>maxCantidad){
                maxCantidad = this.cantidadConcursantes[i];
                maxGenero = i;
            }
        }
        return maxGenero;
    }
    
    public String toString(){
        String aux = "";
        for(int i=0; i<5; i++){
            for(int j=0; j<this.cantidadConcursantes[i];j++){
                aux+= " genero" + i +  concursantes[i][j].toString() + "\n";
            }
        }
        return aux;
    }
    
}
