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
public class Empresa {
    private String nombre;
    private ProgramadorLider lider;
    private Programador [] programadores;
    private int dimL;
    private int maxProgramadores;
    
    public Empresa(String nombre, ProgramadorLider lider, int maxProgramadores){
        this.nombre=nombre;
        this.lider = lider;
        this.maxProgramadores = maxProgramadores;
        this.dimL = 0;
        this.programadores = new Programador[maxProgramadores];
        
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public ProgramadorLider getLider() {
        return lider;
    }

    public void setLider(ProgramadorLider lider) {
        this.lider = lider;
    }
    
    
    public void agregarProgramador(Programador p){
        if(dimL<maxProgramadores){
            programadores[dimL] = p;
            dimL++;
        } else{
            System.out.println("No hay mas lugar");
        }
    }
    
    public double calcularSueldo(){
        double aux = 0;
        for(int i=0;i<dimL;i++){
            aux+=programadores[i].sueldoFinal();
        }
        return lider.sueldoFinal() + aux;
    }
    
    public void aumentarSueldo(double monto){
        lider.setSueldoBasico(monto+lider.getSueldoBasico());
        for(int i=0;i<dimL;i++){
            programadores[i].setSueldoBasico(monto+programadores[i].getSueldoBasico());
        }
    }
    
    
    @Override
    public String toString(){
        String aux="";
        for(int i=0; i<dimL;i++){
            aux+="Programador: " +(i+1)+ programadores[i].toString() + "\n";
        }
        return "Empresa: " + this.getNombre() + "\n" + 
                "Lider: " + this.getLider().toString() + "\n" + 
                aux;
                
    }
    
}


