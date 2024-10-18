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
public abstract  class Sistema {
    private Solicitud [] subsidios;
    private int cantMaxima;
    private int dimL;
    
    public Sistema (int cantMaxima){
        this.cantMaxima = cantMaxima;
        this.dimL=0;
        this.subsidios = new Solicitud[cantMaxima];
    }

    public Solicitud[] getSubsidios() {
        return subsidios;
    }

    public int getDimL() {
        return dimL;
    }
    
    
    public void Agregarsubsidio(Solicitud s){
        if(this.dimL<this.cantMaxima){
            subsidios[dimL]=s;
            dimL++;
        } else {
            System.out.println("no hay mas lugar para subsidios");
        }
        
    }
    
    public Solicitud encontrarSubsidio(int numero){
        return this.subsidios[numero];
    }
    
    public abstract void otorgarSubsidios(double x);
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL; i++){
            if(subsidios[i].isOtorgada()){
                aux+=subsidios[i].toString() +"\n";
            }
        }
        return "Subsidios otorgados \n" + aux;
    }
}
