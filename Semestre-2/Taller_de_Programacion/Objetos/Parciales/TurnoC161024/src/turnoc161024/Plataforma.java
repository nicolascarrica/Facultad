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
public class Plataforma {
    private String nombre;
    private int subscriptores;
    private Estreno [][] infoAgenda;
    private int cantCategorias;
    private int cantMeses;
    
    public Plataforma (String nombre, int subscriptores, int cantCategorias){
        this.nombre = nombre;
        this.subscriptores = subscriptores;
        this.cantCategorias = cantCategorias;
        this.cantMeses = 12;
        this.infoAgenda = new Estreno[cantCategorias][cantMeses];
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
        int j=0;
        boolean encontro = false;
        while((j<cantMeses)&&(!encontro)){
            if(infoAgenda[categoria-1][j]==null){
                infoAgenda[categoria-1][j]=e;
                encontro = true;
            }
            j++;
        }
    }
    
    public String listaEstrenos(int categoria){
        String aux = "";
        boolean cargado = true;
        int j =0;
        while((j<cantMeses)&&(cargado)){
            if(infoAgenda[categoria-1][j]!=null){
                aux+= "Mes: " + (j+1) + "\n" + infoAgenda[categoria-1][j].toString() + "\n";
            }else{
                cargado = false;
            }
            j++;
        }
        return aux;
    }
    
    private double gananciaCategoria(int categoria){
        double total=0;
        boolean vacio = false;
        int j =0;
        while((j<cantMeses)&&(!vacio)){
            if(infoAgenda[categoria][j]==null){
                vacio = true;
            }else{
                total+= infoAgenda[categoria][j].getRecaudacion()/2;
            }
            
            j++;
        }
        return total;
    }
    
    
    public double gananciaTotal(){
        double ganancia = 0;
        for(int i=0; i<cantCategorias;i++){
            ganancia+=gananciaCategoria(i);
        }
        return ganancia;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantCategorias; i++){
            aux+="Categoria: " + (i+1) + "\n" + listaEstrenos(i+1);
        }
        return "Plataforma: " + this.getNombre() + "; cantidad Subscriptores: " + this.getSubscriptores() + "\n" + aux;
                
    }
}
