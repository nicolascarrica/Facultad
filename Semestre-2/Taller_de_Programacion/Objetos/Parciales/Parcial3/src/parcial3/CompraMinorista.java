/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial3;

/**
 *
 * @author nicol
 */
public class CompraMinorista extends Compra {
    private boolean jubilado;

    public CompraMinorista(int maxProductos, int numero, boolean jubilado) {
        super(maxProductos, numero);
        this.jubilado = jubilado;
    }

    public boolean isJublido() {
        return jubilado;
    }

    public void setJublido(boolean jubilado) {
        this.jubilado = jubilado;
    }
    
    public String esJubilado(){
        String aux="";
        if(jubilado) {
            aux+="SI";
        } else aux="NO";
        return aux;
    }
    
    public String toString(){
        return "Compra Minorista: " + super.toString() + " Es Jubilado " + this.esJubilado();
    }
    
    
    
}
