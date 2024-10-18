/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnok81024;

/**
 *
 * @author nicol
 */
public class ProgramadorLider extends Programador{
    private int antiguedad;
    private int proyectos;

    public ProgramadorLider(int antiguedad, int proyectos, String nombre, int dni, double sueldoBasico, int lineasHora, String lenguaje) {
        super(nombre, dni, sueldoBasico, lineasHora, lenguaje);
        this.antiguedad = antiguedad;
        this.proyectos = proyectos;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    public int getProyectos() {
        return proyectos;
    }

    public void setAntiguedad(int antiguedad) {
        this.antiguedad = antiguedad;
    }

    public void setProyectos(int proyectos) {
        this.proyectos = proyectos;
    }
    
    public double sueldoFinal(){
        double total = super.sueldoFinal();
        total+=this.getAntiguedad()*10000 + this.getProyectos()*20000;
        return total;
    }
    
}
