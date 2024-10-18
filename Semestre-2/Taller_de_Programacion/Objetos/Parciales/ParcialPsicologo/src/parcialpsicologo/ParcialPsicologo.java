/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcialpsicologo;

/**
 *
 * @author nicol
 */
public class ParcialPsicologo {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Agenda miAgenda = new Agenda();
        
        Paciente pac1 = new Paciente("nc", true, 500);
        Paciente pac2 = new Paciente("fc", true, 300);
        Paciente pac3 = new Paciente("ac", true, 400);
        Paciente pac4 = new Paciente("aa", false, 1500);
        Paciente pac5 = new Paciente("nn", true, 200);
        Paciente pac6 = new Paciente("bc",false, 1500);
        
        miAgenda.agregarPaciente(pac1,5, 1);
        miAgenda.agregarPaciente(pac2,2, 1);
        miAgenda.agregarPaciente(pac3,1, 2);
        miAgenda.agregarPaciente(pac4,3, 1);
        miAgenda.agregarPaciente(pac5,1, 1);
        miAgenda.agregarPaciente(pac6,4, 1);
        
        miAgenda.liberarTurnos("nn");
        
        boolean tiene = miAgenda.tieneTurno(5, "nc");
        
        if(tiene){
            System.out.println("El paciente tiene turno");
        } else {System.out.println("El paciente NO tiene turno");}
    }
    
}
