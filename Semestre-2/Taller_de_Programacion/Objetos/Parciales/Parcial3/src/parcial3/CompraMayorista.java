/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial3;

/**
 *
 * @author nicol
 */
public class CompraMayorista extends Compra{
    private int cuit;

    public CompraMayorista( int maxProductos, int numero, int cuit) {
        super(maxProductos, numero);
        this.cuit = cuit;
    }

    public int getCuit() {
        return cuit;
    }

    public void setCuit(int cuit) {
        this.cuit = cuit;
    }
    
    public String toString(){
        return "Compra Mayorista: " + super.toString() + " Cuit: " + this.getCuit();
    }
    
    
}
