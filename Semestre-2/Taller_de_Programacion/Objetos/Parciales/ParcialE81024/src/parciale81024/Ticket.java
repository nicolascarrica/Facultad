/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parciale81024;

/**
 *
 * @author nicol
 */
public class Ticket {
    private int numero;
    private int cuit;
    private int cantidadProductos;
    private double monto;
    private String medioPago;

    public Ticket(int numero, int cuit, int cantidadProductos, double monto, String medioPago) {
        this.numero = numero;
        this.cuit = cuit;
        this.cantidadProductos = cantidadProductos;
        this.monto = monto;
        this.medioPago = medioPago;
    }

    public int getNumero() {
        return numero;
    }

    public int getCuit() {
        return cuit;
    }

    public int getCantidadProductos() {
        return cantidadProductos;
    }

    public double getMonto() {
        return monto;
    }

    public String getMedioPago() {
        return medioPago;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public void setCuit(int cuit) {
        this.cuit = cuit;
    }

    public void setCantidadProductos(int cantidadProductos) {
        this.cantidadProductos = cantidadProductos;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public void setMedioPago(String medioPago) {
        this.medioPago = medioPago;
    }
    
    @Override
    public String toString(){
        return "Nro: " + this.getNumero() + 
                ", cuit " + this.getCuit() + 
                ", cantidad Productos: " + this.getCantidadProductos() +
                ", monto abonado: " + this.getMonto() + 
                ", medio pago: " + this.getMedioPago();
    }
}
