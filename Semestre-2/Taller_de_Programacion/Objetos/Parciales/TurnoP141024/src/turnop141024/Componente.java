/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnop141024;

/**
 *
 * @author nicol
 */
public abstract class Componente{
    private String nombre;
    private double monto;

    public Componente(String nombre, double monto) {
        this.nombre = nombre;
        this.monto = monto;
    }
    
    
    public String getNombre() {
        return nombre;
    }

    public double getMonto() {
        return monto;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }
    
    public String toString(){
        return "Nombre: " + this.getNombre() + 
                " - Costo: " + this.getMonto();
                
    }
    
}
