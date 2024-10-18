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
public class Surtidor {
    private String combustible;
    private double precioLitro;
    private Venta [] ventas;
    private int maxVentas;
    private int dimL;
    
    public Surtidor(String combustible, double precioLitro, int maxVentas){
        this.combustible = combustible;
        this.precioLitro = precioLitro;
        this.maxVentas = maxVentas;
        this.dimL = 0;
        this.ventas = new Venta[maxVentas];
    }

    public String getCombustible() {
        return combustible;
    }

    public double getPrecioLitro() {
        return precioLitro;
    }

    public void setCombustible(String combustible) {
        this.combustible = combustible;
    }

    public void setPrecioLitro(double precioLitro) {
        this.precioLitro = precioLitro;
    }
    
    public void agregarVenta(Venta v){
        if(dimL<maxVentas){
            ventas[dimL] = v;
            dimL++;
        }else{
            System.out.println("No hay mas espacio para ventas");
        }
    }
    
    public double totalVentas(){
        double total = 0;
        for(int i=0;i<dimL;i++){
            total+=ventas[i].getMonto();
        }
        return total;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL;i++){
            aux+= ventas[i].toString() + "; ";
        }
        return " Combustible: " + this.getCombustible() + 
                ", precio litro: " + this.getPrecioLitro() + 
                ", Ventas: [" + aux +"]";
    }
}
