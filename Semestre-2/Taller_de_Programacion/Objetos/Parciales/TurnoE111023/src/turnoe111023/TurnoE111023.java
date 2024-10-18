/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoe111023;

/**
 *
 * @author nicol
 */
public class TurnoE111023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Digital miDigital = new Digital("web", "brubank", 20, 7);
        Tradicional miTradicional = new Tradicional("44", 1, "Ciudad", 50,10);
        
        Cuenta micuenta1 = new Cuenta(123, "aa.aa", 7979, "Pesos");
        Cuenta micuenta2 = new Cuenta(456, "aas.aa", 7579, "Dolar");
        Cuenta micuenta3 = new Cuenta(789, "aadas.aa", 1, "Pesos");
        Cuenta micuenta4 = new Cuenta(101, "a465.aa", 3, "Pesos");
        Cuenta micuenta5 = new Cuenta(111, "aa456.aa", 4, "Dolar");
        Cuenta micuenta6 = new Cuenta(121, "aa446.aa", 79, "Pesos");
        Cuenta micuenta7 = new Cuenta(131, "aa5.aa", 9, "Dolar");
        Cuenta micuenta8 = new Cuenta(141, "aa.58aa", 5779, "Pesos");
        
        miDigital.agregarCuenta(micuenta1);
        miDigital.agregarCuenta(micuenta2);
        miDigital.agregarCuenta(micuenta3);
        miDigital.agregarCuenta(micuenta4);
        
        
        miTradicional.agregarCuenta(micuenta5);
        miTradicional.agregarCuenta(micuenta6);
        miTradicional.agregarCuenta(micuenta7);
        miTradicional.agregarCuenta(micuenta8);
        
        miDigital.depositarDinero(123, 500000);
        miDigital.depositarDinero(456, 600);
        
        miTradicional.depositarDinero(111, 700);
        miTradicional.depositarDinero(141, 50000);
        
        if(miDigital.puedeRecibirTarjeta(123)){
            System.out.println(miDigital.obtenerCuenta(123).getMonto());
            System.out.println("Puede recibir tarjeta");
        } else {
            System.out.println("No puede recibir tarjeta");
        }
   
        
        if(miTradicional.puedeRecibirTarjeta(141)){
            System.out.println(miTradicional.obtenerCuenta(141).getMonto());
            System.out.println("Puede recibir tarjeta");
        } else {
            System.out.println("No puede recibir tarjeta");
        }
   
        
        
    }
    
}
