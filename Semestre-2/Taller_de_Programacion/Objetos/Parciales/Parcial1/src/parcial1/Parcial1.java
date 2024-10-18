/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial1;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class Parcial1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        AlumnoGrado aluGrado = new AlumnoGrado(123,"Nicolas", 10, "ingenieria civil");
        AlumnoDoctorado aluDoctorado = new AlumnoDoctorado(456, "Carrica", 12, "Imgeniero Civil e Hidraulico","UNLP");
        
        for(int i=0; i<aluGrado.getMaxMaterias();i++){
            Materia mat = new Materia(GeneradorAleatorio.generarString(5), (6 + GeneradorAleatorio.generarInt(4)), GeneradorAleatorio.generarString(4));
            if(i==5){
                mat.setNombre("Tesis");
            }
            aluGrado.agregarMateria(mat);
        }
        
        for(int i=0; i<aluDoctorado.getMaxMaterias();i++){
            Materia mat = new Materia(GeneradorAleatorio.generarString(5), (6 + GeneradorAleatorio.generarInt(4)), GeneradorAleatorio.generarString(4));
            aluDoctorado.agregarMateria(mat);
        }
        
        System.out.println(aluGrado.toString());
        System.out.println(aluDoctorado.toString());
        
    }
    
}
