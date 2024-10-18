/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio2;

/**
 *
 * @author nicol
 */
public abstract class Empleado {
    private String nombre;
    private double sueldoBase;
    private int antiguedad;
    
    public Empleado(String nombre, double sueldoBase, int antiguedad){
        this.setNombre(nombre);
        this.setSueldoBase(sueldoBase);
        this.setAntiguedad(antiguedad);
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public double getSueldoBase(){
        return sueldoBase;
    }
    
    public int getAntiguedad(){
        return antiguedad;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public void setSueldoBase(double sueldoBase){
        this.sueldoBase = sueldoBase;
    }
    
    public void setAntiguedad(int antiguedad){
        this.antiguedad = antiguedad;
    } 
    
    public double obtnerSueldo(){
        double aux = this.getSueldoBase() + this.getSueldoBase()*0.1*this.getAntiguedad();
        return aux;
    }
    public abstract double calcularSueldoACobrar();
        
    
    public abstract double calcularEfectividad();
    
     public String ToString(){
        String aux = "Nombre: "+ this.getNombre() + " Sueldo: " + this.calcularSueldoACobrar()+ " Efectividad " + this.calcularEfectividad();
        return aux;
    }
}

