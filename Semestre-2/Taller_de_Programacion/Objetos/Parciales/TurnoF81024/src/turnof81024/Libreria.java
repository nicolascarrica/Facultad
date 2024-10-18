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
public class Libreria {
    private String nombre;
    private int ventaActual;
    private Caja [] infoCajas;
    private int maxCajas;
    
    public Libreria(String nombre, int cantTickets){
        this.nombre = nombre;
        this.ventaActual = 0;
        this.maxCajas = 4;
        this.infoCajas = new Caja[maxCajas];
        for (int i=0; i<maxCajas; i++){
            infoCajas[i] = new Caja(cantTickets);
        }
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void agregarTicket(int nCaja, int dni, int cantLibros, double monto, String medio){
        Ticket t = new Ticket(ventaActual, dni, cantLibros, monto, medio);
        infoCajas[nCaja-1].agregarTicket(t);
        this.ventaActual ++;
    }
    
    public void marcarNoDisponilble(int x){
        for(int i=0; i<4; i++){
            if(infoCajas[i].totalLibros()<x){
                infoCajas[i].setDisponible(false);
            }
        }
    }
    
    public int mayotTicketLibreria(){
        int nTicket = 0;
        double maximo = 0;
        for(int i=0; i<4; i++){
            if(infoCajas[i].mayorMonto() > maximo){
                maximo=infoCajas[i].mayorMonto();
                nTicket=infoCajas[i].mayorNumeroTicket();
            }
        }
        return nTicket;
    }
    
    @Override
    public String toString(){
        String aux="";
        for(int i=0;i<4;i++){
            aux+="Caja " + (i+1) + infoCajas[i].toString() + "\n";
        }
        return "libreria: " + this.getNombre() + "\n" + aux;
    }
}
