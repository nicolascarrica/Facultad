/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc141022;

/**
 *
 * @author nicol
 */
public class TurnoC141022 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Funcion miSala = new Funcion("Hola", "15/09", 20, 5,5);
        miSala.ocuparButaca(1, 1);
        miSala.ocuparButaca(5, 1);
        miSala.ocuparButaca(2, 3);
        System.out.println(miSala.StringButacaB(2));
        System.out.println(miSala.toString());
    }
    
    
    
    
    
}
