/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof81024;

/**
 *
 * @author nicol
 */
public class Ticket {
    private int numero;
    private int dni;
    private int cantidadLibros;
    private double monto;
    private String medioDePago;

    public Ticket(int numero, int dni, int cantidadLibros, double monto, String medioDePago) {
        this.numero = numero;
        this.dni = dni;
        this.cantidadLibros = cantidadLibros;
        this.monto = monto;
        this.medioDePago = medioDePago;
    }

    public int getNumero() {
        return numero;
    }

    public int getDni() {
        return dni;
    }

    public int getCantidadLibros() {
        return cantidadLibros;
    }

    public double getMonto() {
        return monto;
    }

    public String getMedioDePago() {
        return medioDePago;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setCantidadLibros(int cantidadLibros) {
        this.cantidadLibros = cantidadLibros;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public void setMedioDePago(String medioDePago) {
        this.medioDePago = medioDePago;
    }
    
    @Override
    public String toString(){
        return " Nro: " + this.getNumero() + 
                ", DNI: " + this.getDni() + 
                ", cantidad Libros: " + this.getCantidadLibros()+
                ", Monto abonado: " + this.getMonto() + 
                ", medio de pago: " + this.getMedioDePago() + ";";
    }
}
