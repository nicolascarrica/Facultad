/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022goleadores;

/**
 *
 * @author nicol
 */
public class Torneo {
    private String nombre;
    private Goleador [][] tablaGoleadores;
    private int cantFechas;
    private int cantGoleadores;
    private int [] dimL;
    
    public Torneo(String nombre, int cantFechas, int cantGoleadores){
        this.nombre=nombre;
        this.cantFechas=cantFechas;
        this.cantGoleadores=cantGoleadores;
        this.tablaGoleadores = new Goleador[cantFechas][cantGoleadores];
        this.dimL = new int[cantFechas];
        iniciarVectorDimL();
    }
    
    private void iniciarVectorDimL(){
        for(int i=0; i<cantFechas; i++){
            dimL[i]=0;
        }
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void agregarGoleador(Goleador goleador, int fecha){
        tablaGoleadores[fecha-1][dimL[fecha-1]]= goleador;
        dimL[fecha-1]++;
    }
    
    public Goleador menosGoles(int fecha){
        Goleador menorGoleador = null;
        int cantGoles = 100;
        for(int j=0; j<dimL[fecha-1];j++){
            if(tablaGoleadores[fecha-1][j].getGoles()<cantGoles){
                menorGoleador=tablaGoleadores[fecha-1][j];
                cantGoles=tablaGoleadores[fecha-1][j].getGoles();
            }
        }
        return menorGoleador;
    }
    
    public int cantidadGoleadores(){
        int total=0;
        for(int i=0; i<cantFechas; i++){
            for(int j=0; j<dimL[i]; i++){
                total++;
            }
        }
        return total;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantFechas;i++){
            aux+= "Fecha# " + (i+1) +"|"+ " cantidad Goleadores: " + dimL[i] + " | Goleadores: [";
            for(int j=0; j<dimL[i];j++){
               aux+= tablaGoleadores[i][j].toString();
            }
            aux+=" ] \n";
        }
        
        return "TORNEO 2022: " + this.getNombre() + "\n" + 
                aux;
    }
}
