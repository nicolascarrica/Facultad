/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnob171022;

/**
 *
 * @author nicol
 */
public class Lote {
    private double precio;
    private Comprador comprador;
    
    public Lote(){
        this.precio = 50000;
        this.comprador = null;
    }

    public double getPrecio() {
        return precio;
    }

    public Comprador getComprador() {
        return comprador;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public void setComprador(Comprador comprador) {
        this.comprador = comprador;
    }
    
    public String toString(){
        String aux="";
        if(comprador!=null){
            aux+=comprador.toString();
        } else {
            aux+="Disponoble para la venta";
        }
        return "precio: " + this.getPrecio() + 
                " - Comprador: " + aux;
    }
}
