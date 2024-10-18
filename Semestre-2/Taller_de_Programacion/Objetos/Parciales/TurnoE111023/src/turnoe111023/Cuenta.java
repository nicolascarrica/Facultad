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
public class Cuenta {
    private int cbu;
    private String alias;
    private int dni;
    private String moneda;
    private double monto;

    public Cuenta(int cbu, String alias, int dni, String moneda) {
        this.cbu = cbu;
        this.alias = alias;
        this.dni = dni;
        this.moneda = moneda;
        this.monto = 0;
    }

    public int getCbu() {
        return cbu;
    }

    public String getAlias() {
        return alias;
    }

    public int getDni() {
        return dni;
    }

    public String getMoneda() {
        return moneda;
    }

    public double getMonto() {
        return monto;
    }

    public void setCbu(int cbu) {
        this.cbu = cbu;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }
    
    public void depositarSueldo(double monto){
        this.monto+=monto;
    }
    
    
}
