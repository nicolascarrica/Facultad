/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023t2;

/**
 *
 * @author nicol
 */
public class Venta {
    private int dni;
    private double cantidadm3;
    private double monto;
    private String metodoPago;

    public Venta(int dni, double cantidadm3, double monto, String metodoPago) {
        this.dni = dni;
        this.cantidadm3 = cantidadm3;
        this.monto = monto;
        this.metodoPago = metodoPago;
    }

    public int getDni() {
        return dni;
    }

    public double getCantidadm3() {
        return cantidadm3;
    }

    public double getMonto() {
        return monto;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setCantidadm3(double cantidadm3) {
        this.cantidadm3 = cantidadm3;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }
    
    public String toString(){
        return "Dni: " + this.getDni() + 
                ", cantidad cargada: " + this.getCantidadm3() + 
                ", monto abonado: " + this.getMonto() + "; ";
    }
    
}
