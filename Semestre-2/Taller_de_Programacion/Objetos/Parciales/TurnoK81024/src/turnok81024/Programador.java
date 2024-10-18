/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnok81024;

/**
 *
 * @author nicol
 */
public class Programador {
    private String nombre;
    private int dni;
    private double sueldoBasico;
    private int lineasHora;
    private String lenguaje;

    public Programador(String nombre, int dni, double sueldoBasico, int lineasHora, String lenguaje) {
        this.nombre = nombre;
        this.dni = dni;
        this.sueldoBasico = sueldoBasico;
        this.lineasHora = lineasHora;
        this.lenguaje = lenguaje;
    }

    public String getNombre() {
        return nombre;
    }

    public int getDni() {
        return dni;
    }

    public double getSueldoBasico() {
        return sueldoBasico;
    }

    public int getLineasHora() {
        return lineasHora;
    }

    public String getLenguaje() {
        return lenguaje;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    public void setLineasHora(int lineasHora) {
        this.lineasHora = lineasHora;
    }

    public void setLenguaje(String lenguaje) {
        this.lenguaje = lenguaje;
    }
    
    
    public double sueldoFinal(){
        double sFinal = 0;
        if(this.getLineasHora()>200){
            sFinal += 50000 + this.getSueldoBasico();
        }else {sFinal += this.getSueldoBasico();}
        return sFinal;
    }
    
    
    public String toString(){
        return "Nombre: " + this.getNombre() + 
                ", DNI: " + this.getDni() + 
                ", Lenguaje: " + this.getLenguaje()+
                ", Sueldo Final: " + sueldoFinal();
    }
}
