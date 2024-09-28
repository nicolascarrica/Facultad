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
public class Ejercicio3 {
    public static void main(String[] args) {
        Estante miEstante = new Estante();
        //Crear Autores para crear el libro
        Autor tolkien = new Autor("J.R.R. Tolkien", "Autor de El Señor de los Anillos y otras obras", "Sudáfrica");
        Autor gMarquez = new Autor("Gabriel Garcia Marquez", "El colombiano de 100 años de soledad", "Colombia");
        Autor alcott = new Autor("Louisa May Alcot", "La de mujercitas", "Inglaterra?");
        
        // Agregar algunos libros
        miEstante.agregarLibro(new Libro("El señor de los anillos", "Minotauro",1954, tolkien, "978-84-450-7375-3", 18));
        miEstante.agregarLibro(new Libro("Cien años de soledad",  "Sudamericana", 1967,gMarquez, "978-84-397-2836-8",15));
        miEstante.agregarLibro(new Libro("Mujercitas", "Roberts Brothers", 1868, alcott, "978-84-206-7575-8", 12));
        
        Libro mujercitas = miEstante.buscarLibroPorTitulo("Mujercitas");
        if(mujercitas!=null){
            System.out.println("El autor de Mujercias es: " + mujercitas.getPrimerAutor());
        } else {
            System.out.println("No se encontro Libro");
        }
    }
}
