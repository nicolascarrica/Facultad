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
public abstract class Compra {
    private int numero;
    private Producto [] listaProductos;
    private int maxProductos;
    private int dimL;
    
    public Compra(int maxProductos, int numero){
        this.numero = numero;
        this.maxProductos = maxProductos;
        this.dimL=0;
        this.listaProductos = new Producto[maxProductos];
        
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }
    
    
    public void agregarProducto(Producto p){
        if(dimL<maxProductos){
            listaProductos[dimL] = p;
            dimL++;
        }else {System.out.println("No hay mas lugar");}
    }
    
    public double precioCompra(){
        double total = 0;
        for(int i=0; i<dimL;i++){
            total+= listaProductos[i].getPrecio();
        }
        return total;
    }
    
    public double precioConIva(){
        return this.precioCompra() + this.precioCompra()*0.21;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL;i++){
            aux+=listaProductos[i].toString();
        }
        return " Nro: " + this.getNumero() + 
                " Productos: (" + aux + ")" + 
                " Precio a pagar: " + this.precioConIva();
    }
    
    
}
