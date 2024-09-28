/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;
import PaqueteLectura.*;
/**
 *
 * @author Alumno
 */
public class Ejercicio1 {
    public static void main(String[] args){
        System.out.println("Ingrese Lado 1 del trianguno");
        double lado1 = Lector.leerDouble();
        System.out.println("Ingrese Lado 2 del trianguno");
        double lado2 = Lector.leerDouble();
        System.out.println("Ingrese Lado 3 del trianguno");
        double lado3 = Lector.leerDouble();
        
        System.out.println("Ingrese color de relleno");
        String relleno = Lector.leerString();
        System.out.println("Ingrese color de linea");
        String linea = Lector.leerString();
        
        Triangulo miTriangulo = new Triangulo(lado1, lado2, lado3, relleno, linea);
        
        System.out.println("El perimetro es : " + miTriangulo.calcularPerimetro());
        System.out.println("EL area es: " + miTriangulo.calcularArea());
    }
}
