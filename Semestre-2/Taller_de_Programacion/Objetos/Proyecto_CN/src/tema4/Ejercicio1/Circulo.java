/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio1;

/**
 *
 * @author nicol
 */
public class Circulo extends Figura{
    private double radio;
    
    public Circulo(double radio, String unColorR, String unColorL){
        super(unColorR, unColorL);
        setRadio(radio);
    }
    
    public double getRadio(){
        return radio;
    }
    
    public void setRadio(double radio){
        this.radio=radio;
    }
    
    public double calcularPerimetro(){
        return 2*Math.PI*getRadio();
    }
    
    public double calcularArea(){
        return Math.PI*getRadio()*getRadio();
    }
    
    public String toString(){
        String aux = super.toString() + 
                    " Radio " + getRadio();
        return aux;
    }
}
