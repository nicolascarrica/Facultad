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
public abstract class Banco {
    private String nombre;
    private int cantEmpleados;
    private Cuenta [] infoCuentas;
    private int cantCuentas;
    private int dimL;
    
    public Banco(int cantCuentas, int cantEmpleados){
        this.cantCuentas=cantCuentas;
        this.cantEmpleados=cantEmpleados;
        this.dimL=0;
        this.infoCuentas = new Cuenta[cantCuentas];
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCantEmpleados(int cantEmpleados) {
        this.cantEmpleados = cantEmpleados;
    }

    public void setDimL(int dimL) {
        this.dimL = dimL;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCantEmpleados() {
        return cantEmpleados;
    }

   
    public int getDimL() {
        return dimL;
    }

    public Cuenta[] getInfoCuentas() {
        return infoCuentas;
    }
    
    
    public boolean agregarCuenta(int cbu, String alias, int dni, String moneda){
        Cuenta cuenta = new Cuenta(cbu, alias, dni, moneda);
        if(dimL<cantCuentas){
            infoCuentas[dimL] = cuenta;
            System.out.println("Cuenta agregada");
            return true;
        } else {
            return false;
        }
    }
    
    public int encontrarCbu(int cbu){
        int aux=0;
        boolean encontro = false;
        while((aux<dimL)&&(!encontro)){
            if(infoCuentas[aux].getCbu()==cbu){
                encontro=true;
            }
            aux++;
        }
        if (!encontro) {
            return aux;
        } else return -1;
    }
    
    public Cuenta buscarCuenta(int cbu){
        Cuenta cuenta;
        int aux=encontrarCbu(cbu);
        if(aux!=1){
            cuenta = infoCuentas[aux];
        }else {
            cuenta=null;
        }
        return cuenta;
    }
    
    public void depositarDinero(int cbu, double monto){
        int aux=encontrarCbu(cbu);
        if(aux!=-1){
            infoCuentas[aux].aumentarMonto(monto);
        }
    }
    
    public abstract boolean puedeRecibirTarjeta(int cbu);
    
    
}
