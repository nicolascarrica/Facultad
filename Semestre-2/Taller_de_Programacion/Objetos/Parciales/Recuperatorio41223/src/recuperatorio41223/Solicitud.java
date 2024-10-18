/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recuperatorio41223;

/**
 *
 * @author nicol
 */
public class Solicitud {
    private String investigador;
    private String planTrabajo;
    private String destino;
    private double pasajeIda;
    private double pasajeVuelta;
    private double tasaEmbarque;
    private double hotePorDia;
    private int cantDias;
    private boolean otorgada;

    public Solicitud(String investigador, String planTrabajo, String destino, double pasajeIda, double pasajeVuelta, double tasaEmbarque, double hotePorDia, int cantDias) {
        this.investigador = investigador;
        this.planTrabajo = planTrabajo;
        this.destino = destino;
        this.pasajeIda = pasajeIda;
        this.pasajeVuelta = pasajeVuelta;
        this.tasaEmbarque = tasaEmbarque;
        this.hotePorDia = hotePorDia;
        this.cantDias = cantDias;
        this.otorgada = false;
    }

    public String getInvestigador() {
        return investigador;
    }

    public void setInvestigador(String investigador) {
        this.investigador = investigador;
    }

    public String getPlanTrabajo() {
        return planTrabajo;
    }

    public void setPlanTrabajo(String planTrabajo) {
        this.planTrabajo = planTrabajo;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public double getPasajeIda() {
        return pasajeIda;
    }

    public void setPasajeIda(double pasajeIda) {
        this.pasajeIda = pasajeIda;
    }

    public double getPasajeVuelta() {
        return pasajeVuelta;
    }

    public void setPasajeVuelta(double pasajeVuelta) {
        this.pasajeVuelta = pasajeVuelta;
    }

    public double getTasaEmbarque() {
        return tasaEmbarque;
    }

    public void setTasaEmbarque(double tasaEmbarque) {
        this.tasaEmbarque = tasaEmbarque;
    }

    public double getHotePorDia() {
        return hotePorDia;
    }

    public void setHotePorDia(double hotePorDia) {
        this.hotePorDia = hotePorDia;
    }

    public int getCantDias() {
        return cantDias;
    }

    public void setCantDias(int cantDias) {
        this.cantDias = cantDias;
    }

    public boolean isOtorgada() {
        return otorgada;
    }

    public void setOtorgada(boolean otorgada) {
        this.otorgada = otorgada;
    }
    
    public String toString(){
        return "Nombre: " + this.getInvestigador() + 
                ", Plan de trabajo: " + this.getPlanTrabajo()+
                ", Lugar de Destino: " + this.getDestino();
    }
    
    
    
    
}
