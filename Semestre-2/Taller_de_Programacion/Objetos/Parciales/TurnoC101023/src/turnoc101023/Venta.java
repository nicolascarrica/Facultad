/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023;

/**
 *
 * @author nicol
 */
public class Venta {
    private int dni;
    private double litros;
    private double monto;
    private String medioPago;

    public Venta(int dni, double litros, double monto, String medioPago) {
        this.dni = dni;
        this.litros = litros;
        this.monto = monto;
        this.medioPago = medioPago;
    }

    public int getDni() {
        return dni;
    }

    public double getLitros() {
        return litros;
    }

    public double getMonto() {
        return monto;
    }

    public String getMedioPago() {
        return medioPago;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setLitros(double litros) {
        this.litros = litros;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public void setMedioPago(String medioPago) {
        this.medioPago = medioPago;
    }
    
    public String toString(){
        return "Dni: " + this.getDni() + 
                ", cantidad Litros: " + this.getLitros() + 
                ", montoo abonado " + this.getMonto();
    }
}
