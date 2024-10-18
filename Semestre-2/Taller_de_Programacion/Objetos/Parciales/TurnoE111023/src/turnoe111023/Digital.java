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
public class Digital extends Banco {
    private String sitioWeb;

    public Digital(String sitioWeb, String nombre, int cantEmpleados, int maxCuentas) {
        super(nombre, cantEmpleados, maxCuentas);
        this.sitioWeb = sitioWeb;
    }
    
    public boolean puedeRecibirTarjeta(int cbu){
        Cuenta buscada = super.obtenerCuenta(cbu);
        if(buscada!=null){
            return (buscada.getMoneda().equals("Pesos"))&& (buscada.getMonto()>100000); 
        }else{
            logger.println("No existe cuenta");
            return false;
        }
    }
}
