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
public class CompraMayor extends Compra{
    private String nombre;
    private int CUIL;

    public CompraMayor(int numero, Fecha fecha, int maxProductos, String nombre, int CUIL) {
        super(numero, fecha, maxProductos);
        this.nombre = nombre;
        this.CUIL = CUIL;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCUIL() {
        return CUIL;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCUIL(int CUIL) {
        this.CUIL = CUIL;
    }
    
    public double precioXMayor(){
        return super.obtenerPrecio() - super.obtenerPrecio()*0.21;
    }
    
    public void agregarProducto(Producto p){
        if(p.getCantidad()>6){
            super.agregarCompra(p);
        }
        else System.out.println("No tiene 6 productos");
    }
    
}
