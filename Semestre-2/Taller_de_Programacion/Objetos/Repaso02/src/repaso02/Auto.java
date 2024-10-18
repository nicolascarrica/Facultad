/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso02;

/**
 *
 * @author nicol
 */
public class Auto {
    private String duenio;
    private String patente;

    public Auto(String duenio, String patente) {
        this.duenio = duenio;
        this.patente = patente;
    }

    public String getDuenio() {
        return duenio;
    }

    public String getPatente() {
        return patente;
    }

    public void setDuenio(String duenio) {
        this.duenio = duenio;
    }

    public void setPatente(String patente) {
        this.patente = patente;
    }


    public String toString() {
        return  "duenio=" + duenio + ", patente=" + patente;
    }
    
   
}
