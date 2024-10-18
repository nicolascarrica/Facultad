/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package temaa191023;

/**
 *
 * @author nicol
 */
public class Producto {
    private int codigo;
    private String descripcion;
    private double pUnitario;
    private int cantidad;

    public Producto(int codigo, String descripcion, double pUnitario, int cantidad) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.pUnitario = pUnitario;
        this.cantidad = cantidad;
    }
    
    public double getPrecioTotal(){
        return this.getCantidad()*this.getpUnitario();
    }

    public int getCodigo() {
        return codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public double getpUnitario() {
        return pUnitario;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setpUnitario(double pUnitario) {
        this.pUnitario = pUnitario;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    @Override
    public String toString(){
        return "codigo: " + this.getCodigo() +
                ", descripcion " + this.getDescripcion() + 
                ", precio final " + this.getPrecioTotal();
    }
    
}
