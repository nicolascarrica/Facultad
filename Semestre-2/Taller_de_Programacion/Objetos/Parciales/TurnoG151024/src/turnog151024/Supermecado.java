/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnog151024;

/**
 *
 * @author nicol
 */
public class Supermecado {
    private String nombre;
    private String direccion;
    private Producto [][] infoProductos;
    private int cantGodolas;
    private int cantEstantes;
    
    public Supermecado(String nombre, String direccion, int cantGondolas, int cantEstantes){
        this.nombre = nombre;
        this.direccion=direccion;
        this.cantEstantes=cantEstantes;
        this.cantGodolas = cantGondolas;
        this.infoProductos = new Producto[cantGondolas][cantEstantes];
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
    
    public void registrarProducto(Producto p, int gondola, int estante){
        if(infoProductos[gondola-1][estante-1]==null){
            infoProductos[gondola-1][estante-1]=p;
           
        } else {
            if (infoProductos[gondola-1][estante-1].getCodigo()==p.getCodigo()){
                int cantidad = infoProductos[gondola-1][estante-1].getCantUnidades() + p.getCantUnidades();
                infoProductos[gondola-1][estante-1].setCantUnidades(cantidad);
            } else{
                System.out.println("Estante ocupado");
            }
        }
    }
    
    public String liberarEstante(int gondola){
        String aux="Productos eliminados: \n";
        for(int j=0; j<cantEstantes;j++){
            if((infoProductos[gondola-1][j]!=null)&&(infoProductos[gondola-1][j].getCantUnidades()==0)){
                aux+=infoProductos[gondola-1][j].toString() + "\n";
                infoProductos[gondola-1][j] = null;
                
            }
        }
        return aux;
    }
    
    public int gondolaMasProduto(String marca){
        int gondolaMax = 0;
        int cantMax = 0;
        for(int i=0; i<cantGodolas; i++){
            int cantidad =0;
            for(int j=0; j<cantEstantes;j++){
                if((infoProductos[i][j]!=null)&&(infoProductos[i][j].getMarca().equals(marca))){
                    cantidad++;
                }
            }
            if(cantidad>cantMax){
                cantMax=cantidad;
                gondolaMax=(i+1);
            }
        }
        return gondolaMax;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantGodolas; i++){
            aux+= "Gondola " + (i+1)+ "\n";
            for(int j=0; j<cantEstantes;j++){
                aux+="Estante " + (j+1); 
                if(infoProductos[i][j]!=null){
                    aux+= ", producto { " + infoProductos[i][j].toString() + "} \n";
                }else{
                    aux+="Vacio \n";
                }
                        
            }
        }
        
        return "Supermercado: " + this.getNombre() + "; " + this.getDireccion() + "\n" + aux;
                
    }
}
