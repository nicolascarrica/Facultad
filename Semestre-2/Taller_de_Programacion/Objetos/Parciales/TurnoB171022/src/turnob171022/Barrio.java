/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022;

/**
 *
 * @author nicol
 */
public class Barrio {
    private String nombre;
    private Lote [][] terrenos;
    private int nManzanas;
    private int nLotes;
    
    
    public Barrio(String nombre, int nManzanas, int nLotes){
        this.nManzanas = nManzanas;
        this.nLotes = nLotes;
        this.terrenos = new Lote[nManzanas][nLotes];
        for(int i=0;i<nManzanas; i++){
            for(int j=0; j<nLotes;j++){
                terrenos[i][j] = new Lote();
            }
        }
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
    public void agregarComprador(Comprador c, int manzana, int lote){
        terrenos[manzana-1][lote-1].setComprador(c);
    }
    
    public void incrementarPrecio(int manzana, double porcentaje){
        for(int j=0;j<nLotes;j++){
            if(terrenos[manzana-1][j].getComprador()==null){
                double precioActual = terrenos[manzana-1][j].getPrecio();
                terrenos[manzana-1][j].setPrecio(precioActual + precioActual*porcentaje/100);
            }
        }
    }
    
    public double gananciaTotal(){
        double total =0;
        for(int i=0;i<nManzanas;i++){
            for(int j=0;j<nLotes;j++){
                if(terrenos[i][j].getComprador()!=null){
                    total+=terrenos[i][j].getPrecio();
                }
            }
        }
        return total;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<nManzanas; i++){
            aux+="Manzana #" + (i+1) +"\n";
            for(int j=0; j<nLotes;j++){
                aux+= "Lote #" + (j+1)+ " " + terrenos[i][j].toString() +"\n";
            }
        }
        return "barrio:" + this.getNombre() + "\n" + 
                "monto Recaudado: " + this.gananciaTotal() + "\n" + 
                aux;
    }
}
