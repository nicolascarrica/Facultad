/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof101023;

/**
 *
 * @author nicol
 */
public abstract class Empleado {
    private String nombre;
    private int dni;
    private int anioIngreso;
    private double sueldoBasico;
    private int anioActual;

    public Empleado(String nombre, int dni, int anioIngreso, double sueldoBasico) {
        this.nombre = nombre;
        this.dni = dni;
        this.anioIngreso = anioIngreso;
        this.sueldoBasico = sueldoBasico;
        this.anioActual = 2024;
    }

    public int getAnioActual() {
        return anioActual;
    }

    public void setAnioActual(int anioActual) {
        this.anioActual = anioActual;
    }
    
    
    public String getNombre() {
        return nombre;
    }

    public int getDni() {
        return dni;
    }

    public int getAnioIngreso() {
        return anioIngreso;
    }

    public double getSueldoBasico() {
        return sueldoBasico;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setAnioIngreso(int anioIngreso) {
        this.anioIngreso = anioIngreso;
    }

    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }
    
    public abstract double sueldoACobrar();
    
    public String toString(){
        return "nombre: " +this.getNombre() + 
                ", dni: " + this.getDni() + 
                ", Sueldo a cobrar: " + sueldoACobrar();
    }
}
