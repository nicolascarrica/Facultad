/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023;

/**
 *
 * @author nicol
 */
public class Estacion {
    private String direccion;
    private Surtidor [] surtidores;
    private int maxSurtidores;
    private int dimL;

    public Estacion(String direccion) {
        this.direccion = direccion;
        this.maxSurtidores = 6;
        this.dimL =0;
        this.surtidores = new Surtidor[maxSurtidores];
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void AgregarSurtidor(Surtidor s){
        if(dimL<maxSurtidores){
            this.surtidores[dimL]= s;
            this.dimL++;
        }else{
            System.out.println("No hay mas espacio");
        }
    }
    
    public void generarVenta(int nSurtidor, int dni, double litros, String metodoPago){
        double monto = this.surtidores[nSurtidor-1].getPrecioLitro()*litros;
        Venta venta = new Venta(dni, litros, monto, metodoPago);
        this.surtidores[nSurtidor-1].agregarVenta(venta);
    }
    
    public int surtidorMayorMonto(){
        double mayorMonto = 0;
        int mayorSurtidor=0;
        for (int i=0; i<dimL; i++){
            if(surtidores[i].totalVentas()>mayorMonto){
                mayorMonto = surtidores[i].totalVentas();
                mayorSurtidor = (i+1);
            }
        }
        return mayorSurtidor;
    }
    
    public String toString(){
        String aux="";
        for (int i=0; i<dimL; i++){
            aux+= "Surtidor " + (i+1) + surtidores[i].toString() + "\n";
        }
        return "Estacion de Servicio: " + this.getDireccion() + this.dimL + " surtidores." +"\n" + 
                aux;
                
    }

    
    
    
    
    
}
