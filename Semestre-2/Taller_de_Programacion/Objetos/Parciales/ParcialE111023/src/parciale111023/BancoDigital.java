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
public class BancoDigital extends Banco{
    private String url;

    public BancoDigital(String url, int cantCuentas, int cantEmpleados) {
        super(cantCuentas, cantEmpleados);
        this.url = url;
    }
    
    public boolean puedeRecibirTarjeta(int cbu){
        int aux = encontrarCbu(cbu);
        if(aux!=-1){
            Cuenta cuenta = getInfoCuentas()[aux];
            String moneda = cuenta.getMoneda();
            double monto = cuenta.getMonto();
            if(moneda.equals("Pesos") && monto>100000){
                return true;
            }
        }
        return false;
        
    }
    
}
