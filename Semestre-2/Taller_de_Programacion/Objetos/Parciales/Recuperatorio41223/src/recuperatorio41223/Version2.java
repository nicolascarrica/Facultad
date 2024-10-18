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
public class Version2 extends Sistema{

    public Version2(int cantMaxima) {
        super(cantMaxima);
    }
    
     public void otorgarSubsidios(double  x){
        for(int i=0; i<super.getDimL();i++){
            double costoHotel = super.getSubsidios()[i].getHotePorDia();
            int dias = super.getSubsidios()[i].getCantDias();
            double monto= costoHotel*dias;
            if(monto<x){
                super.getSubsidios()[i].setOtorgada(true);
            }
        }
        
    }
}
