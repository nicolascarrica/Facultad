/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parciale111023;

/**
 *
 * @author nicol
 */
public class ParcialE111023 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        BancoTradicional miBancoTrad = new BancoTradicional("Castellanos 567", "Pehuajo", 10, 10);
        
        miBancoTrad.agregarCuenta(123546, "ncasa", 121545, "Pesos");
        miBancoTrad.getInfoCuentas()[0].aumentarMonto(500000);
        
        BancoDigital miBancoDigital = new BancoDigital("www.banco.com", 10,10);
        miBancoDigital.agregarCuenta(2154854, "ncasad", 4545, "Pesos");
        miBancoDigital.getInfoCuentas()[0].aumentarMonto(120022);
        
        double monto =  miBancoTrad.getInfoCuentas()[0].getMonto();
        System.out.println("banco tradicional");
        System.out.println(monto);
        int cbu = miBancoTrad.encontrarCbu(123546);
        System.out.println(cbu);
        boolean puede = miBancoTrad.puedeRecibirTarjeta(123546);
        System.out.println(puede);
        
        
        double monto1 =  miBancoDigital.getInfoCuentas()[0].getMonto();
        System.out.println("banco Digital");
        System.out.println(monto1);
        boolean puede2 = miBancoDigital.puedeRecibirTarjeta(2154854);
        System.out.println(puede2);
        
        
        
    }
    
}
