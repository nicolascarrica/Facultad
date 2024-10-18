/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso01;

/**
 *
 * @author nicol
 */
public class Proyecto {
    private String nombre;
    private int codigo;
    private String director;
    private int cantidadInvestigadores;
    private Investigador [] investigadores;
    
    public Proyecto(String nombre, int codigo, String director){
        this.nombre = nombre;
        this.codigo = codigo;
        this.director = director;
        this.cantidadInvestigadores = 0;
        this.investigadores = new Investigador[50];
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public int getCodigo(){
        return codigo;
    }
    
    public void setCodigo(int codigo){
        this.codigo = codigo;
    }
    
    public String getDirector(){
        return director;
    }
    
    public void setDirector(String director){
        this.director = director;
    }
    
    public int getCantidadInvestigadores(){
        return cantidadInvestigadores;
    }
    
    public void agregarInvestigador(Investigador unInvestigador){
        if(this.cantidadInvestigadores<50){
            this.investigadores[this.cantidadInvestigadores++] = unInvestigador;
        }
    }
    
    public double dinerTotalOtorgado(){
        double aux = 0;
        for (int i=0; i<this.cantidadInvestigadores;i++){
            aux+= this.investigadores[i].dineroTotal();
        }
        return aux;
    }
    
    public void otorgarTodos(String nombre){
        for (int i=0;i<cantidadInvestigadores; i++){
            if(this.investigadores[i].getNombre().equals(nombre)){
                investigadores[i].otorgarSubsidio();
            }
        }  
    }
    
    public String toString(){
    String aux = "Nombre: " + this.nombre + 
                 " Codigo " + this.codigo + 
                 " Director " + this.director + 
                 " Dinero Otorgado " + this.dinerTotalOtorgado() + "\n";
    for (int i = 0; i < this.cantidadInvestigadores; i++) {
        aux += this.investigadores[i].toString() + "\n";
    }
    return aux;
}
}
