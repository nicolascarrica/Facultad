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
public class BancoTradicional extends Banco{
    private String direccion;
    private String localidad;
    private int cantCuentasDolares;
    private int maxCuentasDolares;

    public BancoTradicional(String direccion, String localidad, int cantCuentas, int cantEmpleados) {
        super(cantCuentas, cantEmpleados);
        this.direccion = direccion;
        this.localidad = localidad;
        this.cantCuentasDolares = 0;
        this.maxCuentasDolares = 0;
    }
    
    public boolean agregarCuenta(int cbu, String alias, int dni, String moneda) {
        if(moneda.equals("Dolar")) {
            if(cantCuentasDolares < maxCuentasDolares) {
                cantCuentasDolares++;
                return super.agregarCuenta(cbu, alias, dni, moneda);
            } else {
                System.out.println("No se puede agregar más cuentas en dólares. Límite alcanzado.");
                return false;
            }
        } else {
            return super.agregarCuenta(cbu, alias, dni, moneda);
        }
    }
    public boolean puedeRecibirTarjeta(int cbu) {
        int aux = encontrarCbu(cbu);
        if(aux != -1) {
            Cuenta cuenta = getInfoCuentas()[aux];
            String moneda = cuenta.getMoneda();
            double monto = cuenta.getMonto();
        
            if ((moneda.equals("Dolar") && monto > 500) || (moneda.equals("Pesos") && monto > 70000)) {
                return true;
            }
        }
        return false; 
    }
    
    
    
    
}
