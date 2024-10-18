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
public class Caja {
    private String cajero;
    private Ticket [] tickets;
    private int dimF;
    private int dimL;
    
    
    public Caja(String cajero, int maxTickets){
        this.dimL = 0;
        this.dimF = maxTickets;
        this.cajero = cajero;
        this.tickets = new Ticket [maxTickets];
    }

    public String getCajero() {
        return cajero;
    }

    public void setCajero(String cajero) {
        this.cajero = cajero;
    }
    
    
    public void agregarTicket(Ticket ticket){
        if(dimL < dimF){
            tickets[dimL] = ticket;
            dimL++;
        } else {
            System.out.println("No hay mas espacio");
        }
    }
    
    public int getPagosCredito(){
        int total = 0;
        for(int i=0; i<dimL;i++){
            if(tickets[i].getMedioPago().equals("Credito")){
                total++;
            }
        }
        return total;
    }
    
    public int getCantidadTickets(){
        return this.dimL;
    }
    
    
    @Override
    public String toString(){
        String aux="";
        for(int i=0; i<dimL;i++){
            aux += tickets[i].toString() + ";";
        }
        return " Nombre del cajero: " +this.getCajero() + 
                ", Tickets emitidos: [" + aux + "]";
    }
    
    
    
}
