/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc101023t2;

/**
 *
 * @author nicol
 */
public class Surtidor {
    private int maxVentas;
    private boolean fueraDeServicio;
    private Venta [] infoVentas;
    private int dimL;
    
    public Surtidor(int maxVentas){
        this.dimL = 0;
        this.maxVentas = maxVentas;
        this.infoVentas = new Venta [maxVentas];
        this.fueraDeServicio = false;
    }

    public boolean isFueraDeServicio() {
        return fueraDeServicio;
    }

    public void setFueraDeServicio(boolean fueraDeServicio) {
        this.fueraDeServicio = fueraDeServicio;
    }
    
    public void agregarVenta(Venta v){
        if(this.dimL<this.maxVentas){
            infoVentas[dimL]=v;
            this.dimL++;
            System.out.println("Venta agregada");
        }else{
            System.out.println("No hay lugar para mas ventas");
        }
    }
    
    public double sumarGncVendido(){
        double total = 0;
        for(int i=0;i<dimL; i++){
            total+=infoVentas[i].getCantidadm3();
        }
        return total;
    }
    
    public Venta ventaMax(){
        Venta ventaMax=null;
        double montoMax = 0;
        for(int i=0; i<dimL; i++){
            if(infoVentas[i].getMonto()>montoMax){
                montoMax= infoVentas[i].getMonto();
                ventaMax=infoVentas[i];
            }
        }
        return ventaMax;
    }
    
    public String toString(){
        String aux="";
        String enServicio = this.isFueraDeServicio() ? "SI" : "NO";
        for(int i=0;i<dimL; i++){
            aux+=this.infoVentas[i];
        }
        return "Fuera de Servicio: " + enServicio + ", Ventas: [" + aux + "]";
    }
            
}
