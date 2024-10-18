/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trunok151024;
import PaqueteLectura.*;
/**
 *
 * @author nicol
 */
public class TrunoK151024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        GeneradorAleatorio.iniciar();
        
        //Instanciar sistema trimestral
        Trimestral miTrimestral = new Trimestral("Lic. Informatica", "Informatica", 2015);
        
         for (int i = 0; i < (2024 - 2015); i++) { 
            for (int j = 1; j <= 4; j++) { 
                int cantidad = GeneradorAleatorio.generarInt(20) + 5;
                miTrimestral.registrarEgresados(cantidad, 2015 + i, j);
            }
        }
        
        System.out.println(miTrimestral.toString());
        
        // Instanciar el sistema Anual
        Anual miAnual = new Anual("Lic. Informatica", "Informatica", 2015);
        
        
        for (int i = 0; i < (2024 - 2010); i++) {  
            int cantidad = GeneradorAleatorio.generarInt(80) + 20;  
            for (int j = 1; j <= 4; j++) {
                miAnual.registrarEgresados(cantidad / 4, 2010 + i, j); 
            }
        }
        
  
        System.out.println("\nSistema Anual:");
        System.out.println(miAnual.toString());
    }
        
    
}
