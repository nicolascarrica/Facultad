/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoh151024;

/**
 *
 * @author nicol
 */
public class Supermercado {
    private String nombre;
    private String direccion;
    private int cantGondolas;
    private int cantEstantes;
    private Producto [][] infoSupermercado;

    public Supermercado(String nombre, String direccion, int cantGondolas, int cantEstantes) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.cantGondolas = cantGondolas;
        this.cantEstantes = cantEstantes;
        this.infoSupermercado = new Producto[cantGondolas][cantEstantes];
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public void agregarProducto(Producto p){
        boolean ocupado = false;
        int i=0;
        while((i<cantGondolas)&&(!ocupado)){
            int j=0;
            while((j<cantEstantes)&&(!ocupado)){
                if(infoSupermercado[i][j]==null){
                    infoSupermercado[i][j]=p;
                    ocupado = true;
                }
                j++;
            }
            i++;
        }
    }
    
    public String listarProductos(String marca, int gondola){
        String aux="";
        for(int j=0; j<cantEstantes; j++){
            if((infoSupermercado[gondola-1][j])!=null&&(infoSupermercado[gondola-1][j].getMarca().equals(marca))){
                aux+=infoSupermercado[gondola-1][j].toString() + "\n";
            }
        }
        return aux;
    }
    
    public int gondolaMayotCantidad(){
        int numeroMax = 0;
        int cantidadMax = 0;
        for(int i=0; i<cantGondolas;i++){
            int cantidadProductos=0;
            for(int j=0; j<cantEstantes;j++){
                if(infoSupermercado[i][j]!=null){
                    cantidadProductos+=infoSupermercado[i][j].getCantUnidades();
                }
            }
            if(cantidadProductos>cantidadMax){
                cantidadMax = cantidadProductos;
                numeroMax = (i+1);
            }
        }
        return numeroMax;
        
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantGondolas;i++){
            aux+="Gondola: " + (i+1) + "\n";
            for(int j=0; j<cantEstantes;j++){
                if(infoSupermercado[i][j]!=null){
                   aux+="Producto { " + infoSupermercado[i][j].toString() + "} \n";
                } else {
                   aux+="Lugar Vacio \n";
                }
            }
        }
        
        return "Supermercado: " + this.getNombre() + ", Direccion: " + this.getDireccion() +"\n" + 
                aux;
    }
    
}
