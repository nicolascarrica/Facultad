/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnog151024;

/**
 *
 * @author nicol
 */
public class Producto {
    private int codigo;
    private String nombre;
    private String marca;
    private int cantUnidades;
    private double pUnitario;

    public Producto(int codigo, String nombre, String marca, int cantUnidades, double pUnitario) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.marca = marca;
        this.cantUnidades = cantUnidades;
        this.pUnitario = pUnitario;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public int getCantUnidades() {
        return cantUnidades;
    }

    public void setCantUnidades(int cantUnidades) {
        this.cantUnidades = cantUnidades;
    }

    public double getpUnitario() {
        return pUnitario;
    }

    public void setpUnitario(double pUnitario) {
        this.pUnitario = pUnitario;
    }
    
    public String toString(){
        return "Codigo: " + this.getCodigo() + 
                ", nombre: " + this.getNombre() + 
                ", marca: " +this.getMarca() + 
                ", cantidad: " + this.getCantUnidades() + 
                ", precio: " +this.getpUnitario();
    }
}
