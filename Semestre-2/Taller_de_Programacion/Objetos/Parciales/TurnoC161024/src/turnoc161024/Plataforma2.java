/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc161024;

/**
 *
 * @author nicol
 */
public class Plataforma2 {
    private String nombre;
    private int subscriptores;
    private Estreno [][] infoAgenda;
    private int cantCategorias;
    private int cantMeses;
    private int [] vDimL;
    
    public Plataforma2 (String nombre, int subscriptores, int cantCategorias){
        this.nombre = nombre;
        this.subscriptores = subscriptores;
        this.cantCategorias = cantCategorias;
        this.cantMeses = 12;
        this.infoAgenda = new Estreno[cantCategorias][cantMeses];
        this.vDimL = new int[cantCategorias];
        iniciarVectorDimL();
    }    
    private void iniciarVectorDimL(){
        for (int i=0; i<cantCategorias; i++){
            vDimL[i]=0;
        }
    }
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getSubscriptores() {
        return subscriptores;
    }

    public void setSubscriptores(int subscriptores) {
        this.subscriptores = subscriptores;
    }
    
    public void registrarEstreno(Estreno e, int categoria){
        if(vDimL[categoria-1]<cantMeses){
            infoAgenda[categoria-1][vDimL[categoria-1]] = e;
            vDimL[categoria-1]++;
        }
    }
    
    public String listaEstrenos(int categoria){
        String aux ="";
        for(int j=0; j<vDimL[categoria-1];j++){
            aux += "Mes: " + (j+1) + "\n"  + 
                    infoAgenda[categoria-1][j].toString() + "\n";
        }
        return aux;
    }
    
    private double gananciaCategoria(int i){
        double ganancia = 0;
        for(int j=0; j<vDimL[i];j++){
            ganancia+=infoAgenda[i][j].getRecaudacion()/2;
        }
        return ganancia;
    }
    
    public double gananciaTotal(){
        double ganancia =0;
        for(int i=0; i<cantCategorias; i++){
            ganancia+=gananciaCategoria(i);
        }
        return ganancia;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantCategorias; i++){
            aux += "Categoria: " + (i+1) + "\n" + 
                    listaEstrenos(i+1);
        }
        
        return "Nombre: " + this.getNombre() + ", subscriptos: " + this.getSubscriptores() + "\n" + 
                aux;
    }
  
}
    
