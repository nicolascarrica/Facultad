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
public class Autor {
    private String nombre;
    private String biografia;
    private String origen;


public Autor(){
}

public Autor(String unNombre, String unaBiografia, String  unOrigen){
    nombre = unNombre;
    biografia = unaBiografia;
    origen = unOrigen;
}

public String getNombre(){
    return nombre;
}

public String getBiografia(){
    return biografia;
}

public String getOrigen(){
    return origen;
}

public void setNombre(String newNombre){
    nombre=newNombre;
}

public void setBiografia(String newBiografia){
    biografia=newBiografia;
}

public void setOrigen (String newOrigen){
    origen = newOrigen;
}

@Override
public String toString() {
        return  nombre + 
                "\nBiografía: " + biografia + 
                "\nOrigen: " + origen;
    }

        
        
        
        
}