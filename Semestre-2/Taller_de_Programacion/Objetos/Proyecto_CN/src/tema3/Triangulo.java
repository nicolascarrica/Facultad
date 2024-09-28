/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;

/**
 *
 * @author Alumno
 */
public class Triangulo {
    private double lado1;
    private double lado2;
    private double lado3;
    private String colorRelleno;
    private String colorLinea;
    
    public Triangulo(){
    }
    
    public Triangulo(double primerLado, double segundoLado, double tercerLado, String relleno, String colLinea){
        lado1 = primerLado;
        lado2 = segundoLado;
        lado3 = tercerLado;
        colorRelleno = relleno;
        colorLinea = colLinea;
    }
    
    public double getLado1(){
        return lado1;
    }
    public double getLado2(){
        return lado2;
    }
    public double getLado3(){
        return lado3;
    }
    public String getColorRelleno (){
        return colorRelleno;
    }
    public String getColorLinea(){
        return colorLinea;
    }
    
    public void setLado1(double newLado1){
        lado1=newLado1;
        
    }
    public void setLado2(double newLado2){
        lado2=newLado2;
    }
    public void setLado3(double newLado3){
        lado2=newLado3;
    }
    
    public void setColorRelleno(String newRelleno){
        colorRelleno = newRelleno;
    }
    
    public void setColorLinea(String newLinea){
        colorLinea = newLinea;
    }
    
    public double calcularPerimetro(){
        double total = lado1+lado2+lado3;
        return total;
    }
    
    public double calcularArea() {
        double s = calcularPerimetro() / 2; // semiperímetro
        return Math.sqrt(s * (s - lado1) * (s - lado2) * (s - lado3));
    }
}
    

