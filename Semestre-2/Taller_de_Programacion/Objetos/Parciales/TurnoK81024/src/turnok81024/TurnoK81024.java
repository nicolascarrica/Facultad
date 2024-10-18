/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnok81024;

/**
 *
 * @author nicol
 */
public class TurnoK81024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
       
       ProgramadorLider miLider = new ProgramadorLider(3, 2, "Nicolas", 35407725, 2000000, 300, "TypeScript");
       
       Programador prog1 = new Programador("JJ", 55566, 1500000, 200, "Java");
       Programador prog2 = new Programador("NC", 55567, 1500000, 150, "JavaScript");
       Programador prog3 = new Programador("AC", 55568, 1500000, 250, "Phyton");
       Empresa miEmpresa = new Empresa("Empresa 2", miLider, 6);
       
       miEmpresa.agregarProgramador(prog3);
       miEmpresa.agregarProgramador(prog2);
       miEmpresa.agregarProgramador(prog1);
       
       
       System.out.println("Empresa");
       System.out.println(miEmpresa.toString());
       
       miEmpresa.aumentarSueldo(20000);
       System.out.println(miEmpresa.toString());
        
    }
    
}
