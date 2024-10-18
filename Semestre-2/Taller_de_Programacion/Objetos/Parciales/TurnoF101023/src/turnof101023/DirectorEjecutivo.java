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
public class DirectorEjecutivo extends Empleado{
    private double viaticos;

    public DirectorEjecutivo(double viaticos, String nombre, int dni, int anioIngreso, double sueldoBasico) {
        super(nombre, dni, anioIngreso, sueldoBasico);
        this.viaticos = viaticos;
    }
    
    public double sueldoACobrar(){
        double total= super.getSueldoBasico() + this.viaticos;
        if(super.getAnioActual() - super.getAnioIngreso()>20){
            total+=total*0.10;
        }
        return total;
    }
    
    
}
