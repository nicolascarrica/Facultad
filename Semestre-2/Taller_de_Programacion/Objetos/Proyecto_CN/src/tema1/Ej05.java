/*
El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
 */
package tema1;
import PaqueteLectura.Lector;
/**
 *
 * @author nicol
 */
public class Ej05 {
    public static void main(String[] args){
        int i, j;
        int clientes = 5;
        int categorias =4;
        int [][] matriz = new int [categorias][clientes];
        
        for(i=0; i<categorias; i++){
            System.out.println("clasificacion para la cateoria "+ i);
            for(j=0; j<clientes; j++){
                System.out.println("Cliente " + (j+1));
                int calificacion = Lector.leerInt();
                matriz[i][j] = calificacion;
            }
        }
        
        int total;
        double promedio;
        
        for(i=0; i<categorias;i++){
            total =0;
            promedio=0;
            for(j=0; j<clientes; j++){
                total+=matriz[i][j];
            }
            promedio=total/clientes;
            System.out.println("La categoria " + i + "tiene una calificacion promedio de " + promedio);
        }
    }    
}
