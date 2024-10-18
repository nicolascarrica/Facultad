/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc141022;

/**
 *
 * @author nicol
 */
public class Butaca {
    private String descriptor;
    private double precio;
    private boolean ocupada;
    
    public Butaca(int fila, int numero){
        this.descriptor="Butaca " + fila +", " + numero;
        this.precio = 800 + 100*fila;
        this.ocupada = false;
    }
    
    public double getPrecio(){
        return this.precio;
    }

    public String getDescriptor() {
        return descriptor;
    }

    public boolean isOcupada() {
        return ocupada;
    }

    public void setDescriptor(String descriptor) {
        this.descriptor = descriptor;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    
    public void ocupar(){
        this.ocupada = true;
    }
    
    public void desocupar(){
        this.ocupada = false;
    }
    
    @Override
    public String toString(){
        String estado = ocupada ? "Ocupada" : "Libre";
        return this.descriptor + 
                ", precio: " + this.getPrecio() + 
                ", estado: " + estado + "\n";
    }
    
}
