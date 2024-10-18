/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc161024;

/**
 *
 * @author nicol
 */
public class TurnoC161024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        int cantCategorias = 5;
        Plataforma2 miPlataforma = new Plataforma2("Netflix", 10, cantCategorias);
        
        Estreno est1 = new Estreno("aa", "serie", 5000, 500);
        Estreno est2 = new Estreno("asada", "Pelicula", 5000, 500);
        Estreno est3 = new Estreno("fasdas", "Pelicula", 5000, 500);
        Estreno est4 = new Estreno("fasfasa", "serie", 5000, 500);
        Estreno est5 = new Estreno("sfasda", "serie", 5000, 500);
        
        miPlataforma.registrarEstreno(est1, 1);
        miPlataforma.registrarEstreno(est2, 2);
        miPlataforma.registrarEstreno(est3, 3);
        miPlataforma.registrarEstreno(est4, 4);
        miPlataforma.registrarEstreno(est5, 4);
        miPlataforma.registrarEstreno(est5, 1);
        
        System.out.println(miPlataforma.listaEstrenos(1));
        System.out.println(miPlataforma.toString());
        
        double total = miPlataforma.gananciaTotal();
        System.out.println("Ganancia total: " + total);
    }
    
}
