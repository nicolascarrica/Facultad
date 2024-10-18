/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;
import PaqueteLectura.*;

/**
 *
 * @author nicol
 */
public class Ejericicio5 {
    public static void main(String[] args) {
        System.out.println("Ingrese Radio de circulo");
        double radio = Lector.leerDouble();
        System.out.println("Ingrese color de Relleno");
        String relleno = Lector.leerString();
        System.out.println("Ingrese color de Linea");
        String linea = Lector.leerString();
        
        Circulo miCirculo = new Circulo(radio, relleno, linea);
        
        double area = miCirculo.calcularArea();
        double perimetro = miCirculo.calcularPerimetro();
        System.out.println("El valor del area es " + area);
        System.out.println("El valor del perimetro es " + perimetro);
    }
}
