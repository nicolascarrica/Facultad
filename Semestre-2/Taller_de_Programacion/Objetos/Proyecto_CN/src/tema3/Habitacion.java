/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class Habitacion {
    private double precioPorNoche;
    private boolean ocupada; // true o false;
    private Cliente cliente; // Null si es vacio;
    
    public Habitacion(){
        this.precioPorNoche = 2000 + GeneradorAleatorio.generarDouble(8001);
        this.ocupada = false;
        this.cliente = null; // la habitacion vacia
    }
    
    public double getPrecioPorNoche(){
        return precioPorNoche;
    }
    
    public Cliente getCliente(){
        return cliente;
    }
    
    public boolean isOcupada(){
        return ocupada;
    }
    
    public void setPrecioPorNoche(double precioPorNoche){
        this.precioPorNoche = precioPorNoche;
    }
    
    public void setOcupada(boolean ocupada){
        this.ocupada = ocupada;
    }
    
    public void setCliente(Cliente cliente){
        this.cliente = cliente;
        this.ocupada = true;
    }
    
    public void desocupar (){
        this.ocupada = false;
        this.cliente = null;
    }
    
    @Override
    public String toString() {
        String estado = ocupada ? "ocupada, " + cliente.toString() : "libre";
        return "Habitación " + "costo=" + precioPorNoche + ", " + estado + '}';
    }
}
