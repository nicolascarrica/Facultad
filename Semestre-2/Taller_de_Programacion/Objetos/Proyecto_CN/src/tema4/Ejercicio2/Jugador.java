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
public class Jugador extends Empleado {
    private int partidosJugados;
    private int golesAnotados;
    
    public Jugador(String nombre, double sueldoBase, int antiguedad, int partidosJugados, int golesAnotados){
        super(nombre, sueldoBase, antiguedad);
        this.setGolesAnotados(golesAnotados);
        this.setPartidosJugados(partidosJugados);
        
    } 
    
    public int getPartidosJugados(){
        return partidosJugados;
    }
    
    public int getGolesAnotados (){
        return golesAnotados;
    }
    
    public void setGolesAnotados(int golesAnotados){
        this.golesAnotados = golesAnotados;
    }
    
    public void setPartidosJugados (int partidosJuagdos){
        this.partidosJugados = partidosJuagdos;
    }
    
    public double calcularEfectividad(){
        return (double) this.getGolesAnotados() / this.getPartidosJugados();
    }
    
    public double calcularSueldoACobrar(){
        double sueldo;
        if(this.calcularEfectividad() >0.5){
            sueldo = this.obtnerSueldo() + this.getSueldoBase();
        } else {
            sueldo = this.obtnerSueldo();
        }
        return sueldo;
    }
}
