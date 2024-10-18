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
public class Tradicional extends Banco{
    private String direccion;
    private int localidad;
    private int cantCuentasUsd;
    private int maxCuentasUsd;

    public Tradicional(String direccion, int localidad, String nombre, int cantEmpleados, int maxCuentas) {
        super(nombre, cantEmpleados, maxCuentas);
        this.direccion = nombre;
        this.localidad = localidad;
        this.cantCuentasUsd = 0;
        this.maxCuentasUsd = 100;
    }
    
    public boolean agregarCuenta(Cuenta c){
        if(c.getMoneda().equals("dolar")){
            if(cantCuentasUsd<maxCuentasUsd){
                cantCuentasUsd++;
                return super.agregarCuenta(c);
            }else {
                System.out.println("capacidad de cuentas usd completa");
                return false;
            }
        } else {
            return super.agregarCuenta(c);
        }
        
    }
    
    public boolean puedeRecibirTarjeta(int cbu){
        Cuenta buscada = super.obtenerCuenta(cbu);
        if(buscada!=null){
            return (buscada.getMonto()>70000)&&(buscada.getMoneda().equals("Pesos"))|| (buscada.getMonto()>500)&&(buscada.getMoneda().equals("Dolar")); 
        }else {
            System.out.println("No existe cuenta");
            return false;
        }
    }
    
    
}
