/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof81024;

/**
 *
 * @author nicol
 */
public class Caja {
    private boolean disponible;
    private Ticket [] infoTickets;
    private int cantTicket;
    private int dimL;
    
    public Caja(int cantTicket){
        this.disponible = true;
        this.cantTicket = cantTicket;
        this.dimL=0;
        this.infoTickets = new Ticket[cantTicket];
        
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
    
    public void agregarTicket(Ticket t){
        if(dimL<cantTicket){
            infoTickets[dimL] = t;
            dimL++;
        }
    }
    
    private Ticket ticketMayorMonto(){
        Ticket mayor = null;
        double montoMayor=0;
        for(int i=0; i<dimL; i++){
            if(infoTickets[i].getMonto()>montoMayor){
                montoMayor=infoTickets[i].getMonto();
                mayor = infoTickets[i];
            }
        }
        return mayor;
    }
    
    public double mayorMonto(){
        Ticket mayor = ticketMayorMonto();
        return mayor.getMonto();
    }
    
    public int mayorNumeroTicket(){
        Ticket mayor = ticketMayorMonto();
        return mayor.getNumero();
    }
    
   
    public int totalLibros(){
        int total =0;
        for(int i=0; i<dimL;i++){
            total += infoTickets[i].getCantidadLibros();
        }
        return total;
    }
    public String toString(){
        String aux ="";
        String estadoCaja = disponible ? " Disponible" : " No disponible";
        for(int i=0; i<dimL;i++){
            aux+=infoTickets[i].toString();
        }
        return estadoCaja + " tickes emitidos: [" + aux + " ]";
    }
    
   
}
