/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parciale81024;

/**
 *
 * @author nicol
 */
public class Supermercado {
    private String direccion;
    private int dimL;
    private Caja [] cajas;
    private int cantidadCajas;
    private int numeroVenta;
    
    public Supermercado(String direccion){
        this.cantidadCajas = 5;
        this.direccion = direccion;
        this.dimL = 0;
        this.numeroVenta = 0;
        this.cajas = new Caja[cantidadCajas];
        iniciar();
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    
    public void iniciar(){
        for (int i=0; i<cantidadCajas; i++){
            cajas[i] = null;
        }
    }
    public void agregarCaja(Caja caja){
        if(dimL<cantidadCajas){
            cajas[dimL] = caja;
            dimL++;
        } else {
            System.out.println("No hay mas espacio");
        }
    }
    
    public void generarTicket(int nCaja, int cuit, int cantProductos, double monto, String medioPago){
        Ticket nuevoTicket = new Ticket(numeroVenta, cuit, cantProductos, monto, medioPago);
        cajas[nCaja-1].agregarTicket(nuevoTicket);
        numeroVenta ++;
    }
    
    public int cajaMenorCredito(){
        int menor = Integer.MAX_VALUE;
        int cajaMenor =0;
        for(int i=0; i<dimL; i++){
            if(cajas[i].getPagosCredito()<menor) {
                menor = cajas[i].getPagosCredito();
                cajaMenor = i;
            }
        }
        return cajaMenor + 1;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL; i++){
            aux+= "Caja " + (i+1) +
                    cajas[i].toString() + "\n";
        }
        return "Supermercado: " + this.getDireccion() +
                " Cantidad de cajas: " + this.dimL + "\n" + 
                aux;
    }
    
}
