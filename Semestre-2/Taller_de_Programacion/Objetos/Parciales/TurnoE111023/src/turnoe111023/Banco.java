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
public abstract  class Banco {
    private String nombre;
    private int cantEmpleados;
    private Cuenta [] infoCuentas;
    private int maxCuentas;
    private int dimL;
    
    public Banco(String nombre, int cantEmpleados, int maxCuentas){
        this.nombre= nombre;
        this.cantEmpleados= cantEmpleados;
        this.maxCuentas = maxCuentas;
        this.dimL =0;
        this.infoCuentas= new Cuenta[maxCuentas];
    }
    
    public boolean agregarCuenta(Cuenta c){
        if(this.dimL<this.maxCuentas){
            infoCuentas[dimL]=c;
            dimL++;
            return true;
        }else return false;
    }
    
    public int buscarCuenta(int cbu){
        int posCuenta=0;
        boolean encontro = false;
        int i = 0;
        while((i<dimL) && !encontro){
            if(infoCuentas[i].getCbu() == cbu){
                posCuenta = i;
                encontro=true;
            }
            i++;
        }
        if(!encontro){
            posCuenta = -1;
        }
        return posCuenta;
    }
    
    public Cuenta obtenerCuenta(int cbu){
        Cuenta buscada = null;
        int posCuenta= buscarCuenta(cbu);
        if(posCuenta!=-1){
            buscada = infoCuentas[posCuenta];
        }
        return buscada;
    }
    
    public void depositarDinero(int cbu, double monto){
        int posCuenta = buscarCuenta(cbu);
        if(posCuenta!=-1){
            infoCuentas[posCuenta].depositarSueldo(monto);
        }else{
            System.out.println("No existe cuenta");
        } 
    }
    
    public abstract boolean puedeRecibirTarjeta(int cbu);
    
}
