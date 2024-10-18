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
public class Version1 extends Sistema{

    public Version1(int cantMaxima) {
        super(cantMaxima);
    }
    
    public void otorgarSubsidios(double  x){
        for(int i=0; i<super.getDimL();i++){
            double pasajeIda = super.getSubsidios()[i].getPasajeIda();
            double pasajevuelta = super.getSubsidios()[i].getPasajeVuelta();
            double tasaEnbarque = super.getSubsidios()[i].getTasaEmbarque();
            double monto= pasajeIda + pasajevuelta + tasaEnbarque;
            if(monto<x){
                super.getSubsidios()[i].setOtorgada(true);
            }
        }
        
    }
}
