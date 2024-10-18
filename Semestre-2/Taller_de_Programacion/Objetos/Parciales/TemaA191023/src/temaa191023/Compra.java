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
public class Compra {
    private int numero;
    private Fecha fecha;
    private int maxProductos;
    private int productosComprados;
    private Producto [] listaProductos;
    
    public Compra(int numero, Fecha fecha, int maxProductos){
        this.numero = numero;
        this.fecha = fecha;
        this.productosComprados = 0;
        this.maxProductos = maxProductos;
        this.listaProductos = new Producto[maxProductos];
        inicializar();
        
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public void setFecha(Fecha fecha) {
        this.fecha = fecha;
    }

    public Fecha getFecha() {
        return fecha;
    }
    
    
    private void inicializar(){
        for (int i=0; i<maxProductos; i++){
            listaProductos[i]=null;
        }
    }
    
    public void agregarCompra(Producto p){
        if(productosComprados<maxProductos){
            listaProductos[productosComprados]=p;
            productosComprados++;
            System.out.println("Producto Agregado");
        }
    }
    
    public double obtenerPrecio(){
        double total = 0;
        for(int i=0; i<productosComprados;i++){
            total+= listaProductos[i].getPrecioTotal();
        }
        return total;
    }
    
    public boolean  enCuotas(){
        boolean aux= false;
        if(this.obtenerPrecio()>100000){
            aux=true;
        }
        return aux;
    }
    
    public String ResumenCompra(){
        String aux = "numero: " + this.getNumero() + ", Fecha: " + this.getFecha().toString();
        for (int i=0; i<productosComprados;i++){
            aux+= "\n" + listaProductos[i].toString();
        }
        aux+="\n Precio Total: " + this.obtenerPrecio();
        return aux;
    }
    
    
}
