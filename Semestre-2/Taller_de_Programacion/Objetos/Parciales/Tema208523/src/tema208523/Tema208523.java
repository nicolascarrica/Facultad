/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema208523;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class Tema208523 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        GeneradorAleatorio.iniciar();
        Concurso miConcurso = new Concurso(3,5);
        Cancion cancion1 = new Cancion(1, "Ruleta", "Los Piojos");
        Cancion cancion2 = new Cancion(2, "Veneno", "La Renga");
        Cancion cancion3 = new Cancion(3, "Lover", "Taylor Swift");
        Cancion cancion4 = new Cancion(4, "Cardigan", "Taylor Swift");
        Cancion cancion5 = new Cancion(5, "La Colorada", "Pibes Chorros");
        
        miConcurso.agregarCancion(cancion5, 1);
        miConcurso.agregarCancion(cancion4, 2);
        miConcurso.agregarCancion(cancion3, 2);
        miConcurso.agregarCancion(cancion2, 3);
        miConcurso.agregarCancion(cancion1, 3);
        
        int puntaje;
        int id;
        
        System.out.println("Inciso c");
        System.out.println("Ingrese id Cancion");
        id=Lector.leerInt();
        while(id!=0){
            Estudiante estudiante = new Estudiante(
                    GeneradorAleatorio.generarString(7),
                    GeneradorAleatorio.generarString(7),
                    GeneradorAleatorio.generarInt(5)
            );
            puntaje = GeneradorAleatorio.generarInt(10) + 1;
            miConcurso.interpretarCancion(id, estudiante, puntaje);
            System.out.println("Ingrese id Cancion");
            id=Lector.leerInt();
        }
        
        System.out.println("Inciso D");
        System.out.println("Ingrese id Cancion");
        int id2=Lector.leerInt();
        Estudiante ganador = miConcurso.conocerGanador(id2);
        if(ganador !=null){
            System.out.println("El ganador es de esa cancion es");
            System.out.println(ganador.toString());
        } else {
            System.out.println("Nadie");
        }
        
        
        System.out.println("Inciso E");
        Cancion mejorCancion = miConcurso.mayorPuntaje();
        
        System.out.println(mejorCancion.toString());
        
    }
    
}
