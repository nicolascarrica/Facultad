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
public class Encargado extends Empleado{
    private int cantidadEmpleados;

    public Encargado(int cantidadEmpleados, String nombre, int dni, int anioIngreso, double sueldoBasico) {
        super(nombre, dni, anioIngreso, sueldoBasico);
        this.cantidadEmpleados = cantidadEmpleados;
    }
    
    public double sueldoACobrar(){
        double total=super.getSueldoBasico() + 1000*this.cantidadEmpleados;
        if(super.getAnioActual()-super.getAnioIngreso()>20){
            total+=total*0.10;
        }
        return total;
    }
}
