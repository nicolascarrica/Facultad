/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnop141024;

/**
 *
 * @author nicol
 */
public class Pan extends Componente{
    private String calidad;

    public Pan(String calidad, String nombre, double monto) {
        super(nombre, monto);
        this.calidad = calidad;
    }

    public String getCalidad() {
        return calidad;
    }

    public void setCalidad(String calidad) {
        this.calidad = calidad;
    }

   public String toString(){
       String aux = super.toString();
       return aux + " - Calidad " + this.getCalidad();
   }
    
    
    
    
    
}
