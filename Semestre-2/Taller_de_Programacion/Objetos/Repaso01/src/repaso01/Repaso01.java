/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso01;

/**
 *
 * @author nicol
 */
public class Repaso01 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Proyecto proyecto = new Proyecto("Proyecto1", 001, "Nico Carri");
        
        Investigador investigador1 = new Investigador("Apo",1,"Cocinera");
        Investigador investigador2 = new Investigador("Firen", 2, "Pasteleria");
        
        proyecto.agregarInvestigador(investigador2);
        proyecto.agregarInvestigador(investigador1);
        
        investigador1.agregarSubsidio(new Subsidio(2500, "Investigacion A"));
        investigador2.agregarSubsidio(new Subsidio(1000, "Investigacion B"));
        investigador2.otorgarSubsidio();
        proyecto.otorgarTodos("Apo");
        System.out.println(proyecto.toString());
    }
    
}
