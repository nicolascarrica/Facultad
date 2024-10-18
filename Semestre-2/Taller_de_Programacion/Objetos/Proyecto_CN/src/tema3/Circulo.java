/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;

/**
 *
 * @author nicol
 */
public class Circulo {
    private double radio;
    private String colorRelleno;
    private String colorLinea;
    
    public Circulo(double radio, String colorRelleno, String colorLinea){
        this.radio = radio;
        this.colorRelleno = colorRelleno;
        this.colorLinea = colorLinea;
    }
    
    public double getRadio(){
        return radio;
    }
    
    public String getColorRelleno(){
        return colorRelleno;
    }
    
    public String getColorLinea(){
        return colorLinea;
    }
    
    public void setRadio(double radio){
        this.radio=radio;
    }
    
    public void setColorRelleno(String colorRelleno){
        this.colorRelleno = colorRelleno;
    }
    
    public void setColorLinea(String colorLinea){
        this.colorLinea = colorLinea;
    }
    
    public double calcularPerimetro(){
        double perimetro = 2*Math.PI*radio;
        return perimetro;
    }
    
    public double calcularArea(){
        double area = Math.PI*radio*radio;
        return area;
    }
}
