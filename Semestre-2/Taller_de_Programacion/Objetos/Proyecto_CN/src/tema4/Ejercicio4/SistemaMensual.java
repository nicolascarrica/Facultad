/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4.Ejercicio4;

/**
 *
 * @author nicol
 */
public class SistemaMensual extends Sistema{
    private String[] meses = new String[]{
        "Enero", "Febrero", "Marzo","Abril", 
        "Mayo", "Junio", "Julio", "Agosto", 
        "Septiembre", "Octubre", "Noviembre", "Diciembre"
    };
    
    public SistemaMensual(Estacion estacion, int anioInicio, int cantidadAnios){
        super(estacion, anioInicio, cantidadAnios);
    }
    
    public String generarReporte(){
        String aux = "";
        double total;
        for (int j=0; j<12; j++){
            total=0;
            for (int i=0; i<this.getCantidadAnios(); i++){
                total = this.getTemperatura(j+1, i+this.getAnioInicio());
            }
            aux += meses[j]+ ": " + Math.round((total/this.getCantidadAnios())*100)/100.0+"°C \n";
        }
        return aux;
    }
    
    public String toString(){
        return super.toString();
    }
    
}
