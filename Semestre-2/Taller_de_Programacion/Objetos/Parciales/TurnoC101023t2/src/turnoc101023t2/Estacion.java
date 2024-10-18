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
public class Estacion {
    private String direccion;
    private double preciom3;
    private Surtidor [] infoSurtidors;
    private int cantSurtidores;
    private int maxVentas;
    
    public Estacion(String direccion, double preciom3, int maxVentas){
        this.direccion= direccion;
        this.preciom3 = preciom3;
        this.maxVentas = maxVentas;
        this.cantSurtidores = 6;
        this.infoSurtidors = new Surtidor[cantSurtidores];
        iniciar();
    }

    private void iniciar(){
        for(int i=0; i<cantSurtidores;i++){
            this.infoSurtidors[i]=new Surtidor(maxVentas);
        }
    }
    
    
    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public double getPreciom3() {
        return preciom3;
    }

    public void setPreciom3(double preciom3) {
        this.preciom3 = preciom3;
    }
    
    
    
    
    public void generarventa(int nSurtidor, int dni, double m3, String metodoPago){
        double monto = this.preciom3*m3;
        Venta venta = new Venta(dni, m3, monto, metodoPago);
        infoSurtidors[nSurtidor-1].agregarVenta(venta);
        System.out.println("Venta genereda");
    }
    
    public void fueraDeServicio(double x){
        for(int i=0; i<cantSurtidores; i++){
            if(infoSurtidors[i].sumarGncVendido()<x){
                infoSurtidors[i].setFueraDeServicio(true);
            }
        }
    }
    
    public Venta maximaVenta(){
        Venta maxima = null;
        for(int i=0; i<cantSurtidores; i++){
          Venta ventaSurtidor = infoSurtidors[i].ventaMax();
          if(ventaSurtidor!=null){
              if((maxima == null) || ventaSurtidor.getMonto()>maxima.getMonto()){
                  maxima=ventaSurtidor;
                }
          }
        }
        return maxima;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantSurtidores;i++){
            aux+="Surtidor " + (i+1) + ";" + infoSurtidors[i].toString() + "\n";
        }
        return "Estacion de Servicio: Direccion, " + this.getDireccion() + "; precio m3 " + this.getPreciom3() +"\n" +
                aux;
    }
    
    
}
