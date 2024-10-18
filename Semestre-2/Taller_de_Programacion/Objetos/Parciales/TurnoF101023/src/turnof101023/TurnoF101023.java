/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof101023;

/**
 *
 * @author nicol
 */
public class TurnoF101023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        DirectorEjecutivo direc = new DirectorEjecutivo(50000, "Jose", 12345, 2000, 950000);
        Encargado enc1 = new Encargado(10, "Beto", 456465, 2010, 800000);
        Encargado enc2 = new Encargado(8, "Peralta", 46465, 2008, 900000);
        Encargado enc3= new Encargado(5, "Nicolas",55654, 2017, 900000);
        
        Empresa miEmpresa = new Empresa("NC", "520 125", direc, 5);
        
        miEmpresa.agregarEncargado(1, enc3);
        miEmpresa.agregarEncargado(5, enc2);
        miEmpresa.agregarEncargado(2, enc1);
        
        String Empresa = miEmpresa.toString();
        System.out.println(Empresa);
    }
    
}
