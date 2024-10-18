/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package temah171023;

/**
 *
 * @author nicol
 */
public class Concierto {
    private String artista;
    private double precio;
    private int entradasVendidas;

    public Concierto(String artista, double precio, int entradasVendidas) {
        this.artista = artista;
        this.precio = precio;
        this.entradasVendidas = entradasVendidas;
    }

    public String getArtista() {
        return artista;
    }

    public double getPrecio() {
        return precio;
    }

    public int getEntradasVendidas() {
        return entradasVendidas;
    }

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public void setEntradasVendidas(int entradasVendidas) {
        this.entradasVendidas = entradasVendidas;
    }
    
    public String toString(){
        return "Artista:  " + this.artista +
                ", precio: " +  this.precio + 
                ", entradas venidas: " + this.entradasVendidas;           
    }
    
    public double gananciaConcierto(){
        return this.getEntradasVendidas()*this.getPrecio();
    }
    
}
