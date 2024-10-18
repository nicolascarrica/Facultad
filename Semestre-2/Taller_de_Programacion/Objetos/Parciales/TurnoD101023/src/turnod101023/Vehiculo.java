/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod101023;

/**
 *
 * @author nicol
 */
public class Vehiculo {
    private String patente;
    private int cantHoras;
    private String marca;
    private String modelo;

    public Vehiculo(String patente, int cantHoras, String marca, String modelo) {
        this.patente = patente;
        this.cantHoras = cantHoras;
        this.marca = marca;
        this.modelo = modelo;
    }

    
    public String getPatente() {
        return patente;
    }

    public int getCantHoras() {
        return cantHoras;
    }

    public String getMarca() {
        return marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setPatente(String patente) {
        this.patente = patente;
    }

    public void setCantHoras(int cantHoras) {
        this.cantHoras = cantHoras;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }
    
    public String toString(){
        return "Patente: " + this.getPatente() + 
                ", marca: " + this.getMarca() + 
                ", modelo: " + this.getModelo() + 
                ", horas: " + this.getCantHoras();
                
    }

    boolean equals() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
