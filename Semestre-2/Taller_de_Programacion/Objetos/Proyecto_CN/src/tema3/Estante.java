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
public class Estante {
    private static final int CAPACIDAD = 20;
    private int cantidadLibros;
    private final Libro[] libros;
    
    public Estante(){
        libros = new Libro[CAPACIDAD];
        cantidadLibros = 0;
    }
    // PARA CREAR EL ESTANTE CON UNA CAPACIDAD N
   /* public Estante(int n) {
        capacidad = n;
        libros = new Libro[maxLibros];
        cantidadLibros = 0;
    }
    */
    
    public int getCantidadLibros(){
        return cantidadLibros;
    }
    
    public boolean estaLleno(){
        return cantidadLibros == CAPACIDAD;
    }
    
    public boolean agregarLibro(Libro libro){
        if (!estaLleno()){
            libros[cantidadLibros] = libro;
            cantidadLibros++;
            return true;
        }
        return false;
    }
    
    public Libro buscarLibroPorTitulo(String titulo) {
        for (int i = 0; i < cantidadLibros; i++) {
            if (libros[i].getTitulo().equalsIgnoreCase(titulo)) {
                return libros[i];
            }
        }
        return null;
    }
}
