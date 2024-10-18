/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnop141024;

/**
 *
 * @author nicol
 */
public class Ingrediente extends Componente{
    private char grupo;

    public Ingrediente(char grupo, String nombre, double monto) {
        super(nombre, monto);
        this.grupo = grupo;
    }

    public char getGrupo() {
        return grupo;
    }

    public void setGrupo(char grupo) {
        this.grupo = grupo;
    }
    
    public String toString(){
        String aux = super.toString();
        return aux + " - Grupo: " + this.grupo;
    }
    
}
