/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio1;
import PaqueteLectura.*;

/**
 *
 * @author nicol
 */
public class Ejercicio1 {
    public static void main(String[] args) {
        //Triangulo
        System.out.println("Ingrese lados del Triangulo");
        double lado1 = Lector.leerDouble();
        double lado2 = Lector.leerDouble();
        double lado3 = Lector.leerDouble();
        System.out.println("Ingrese Color Relleno");
        String unColorR = Lector.leerString();
        System.out.println("Ingrese Color de Linea");
        String unColorL = Lector.leerString();
        
        Triangulo miTriangulo = new Triangulo(lado1, lado2, lado3, unColorR, unColorL);
        
        System.out.println(miTriangulo.toString());
        
        //Circulo
        System.out.println("Ingrese radio del circulo");
        double radio = Lector.leerDouble();
        System.out.println("Ingrese Color Relleno");
        String unColorRC = Lector.leerString();
        System.out.println("Ingrese Color de Linea");
        String unColorLC = Lector.leerString();
        
        Circulo miCirculo = new Circulo(radio, unColorRC, unColorLC);
        
        System.out.println(miCirculo.toString());
        
        
        
    }
    
}
