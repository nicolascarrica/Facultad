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
public class Investigador {
    private String nombre;
    private int categoria;
    private String especialidad;
    private int cantidadSubsidios;
    private Subsidio [] subsidio;
    
    public Investigador(String nombre, int categoria, String especialidad){
        this.nombre=nombre;
        this.categoria = categoria;
        this.especialidad = especialidad;
        this.cantidadSubsidios = 0;
        this.subsidio = new Subsidio[5];
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public int getCategoria(){
        return categoria;
    }
    
    public void setCategoria(int categoria){
        this.categoria=categoria;
    }
    
    public String getEspecialidad(){
        return especialidad;
    }
    
    public void setEspecialidad(String especialidad){
        this.especialidad = especialidad;
    }
    
    public int getCantidadSubsidios (){
        return cantidadSubsidios;
    }
    
    public void agregarSubsidio(Subsidio unSubsidio){
        if(this.cantidadSubsidios<5){
            this.subsidio[this.cantidadSubsidios++] = unSubsidio;
        }
    }
    
    public double dineroTotal(){
    double aux = 0;
    for (int i = 0; i < this.cantidadSubsidios; i++) {
        if (this.subsidio[i].isOtorgado()) {
            aux += this.subsidio[i].getMonto();
        }
    }
    return aux;
}

    public void otorgarSubsidio(){
        for (int i=0; i<this.cantidadSubsidios; i++){
            if(!this.subsidio[i].isOtorgado()){
                this.subsidio[i].setOtorgado(true);
            }
        }
    }
    
    @Override
    public String toString(){
        String aux = "Nombre: " + this.nombre + 
                    " Categoria " + this.categoria + 
                    " Especialidad " + this.especialidad + 
                    " Total Dinero " + this.dineroTotal();
        return aux;
    }
}
