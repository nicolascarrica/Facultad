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
public class Entrenador extends Empleado{
    private int campeonatosGanados;
    
    public Entrenador(String nombre, double sueldoBase, int antiguedad, int campeonatosGanados){
        super(nombre, sueldoBase, antiguedad);
        this.setCampeonatosGanados(campeonatosGanados);
    }
    
    public int getCampeonatosGanados(){
        return campeonatosGanados;
    }
    public void setCampeonatosGanados(int campeonatosGanados){
        this.campeonatosGanados = campeonatosGanados;
    }
    
    public double calcularEfectividad(){
        return (double) this.getCampeonatosGanados() / this.getAntiguedad();
    }
    
    public double calcularSueldoACobrar(){
        double sueldo;
        if (this.getCampeonatosGanados()== 0){
            sueldo = this.obtnerSueldo();
        } else {
            if (this.getCampeonatosGanados()>=1 && this.getCampeonatosGanados()<=4){
                sueldo = 5000 + this.obtnerSueldo();
            } else if (this.getCampeonatosGanados()>=5 && this.getCampeonatosGanados()<=10){
                sueldo = 30000 + this.obtnerSueldo();
            } else {
                sueldo = 50000 + obtnerSueldo();
            }
        }
        
        return sueldo;
    }
    
}
