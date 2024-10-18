/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnom161024;

/**
 *
 * @author nicol
 */
public class Minibus {
    private String patente;
    private int capacidad;
    private Alumno [] infoAlumno;
    private int dimL;
    private int lugaresLibres;
    
    public Minibus (String patente, int capacidad){
        this.patente = patente;
        this.capacidad = capacidad;
        this.infoAlumno = new Alumno[capacidad];
        this.dimL=0;
        this.lugaresLibres = capacidad - dimL;
    }

    public String getPatente() {
        return patente;
    }

    public void setPatente(String patente) {
        this.patente = patente;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public int getLugaresLibres() {
        return lugaresLibres;
    }
    
    public int cantidadAlumnos (){
        return dimL;
    }
    
    public void agregarAlumno(Alumno al){
        if(dimL<capacidad){
            infoAlumno[dimL]= al;
            dimL++;
            lugaresLibres--;
        }else{
            System.out.println("minibus lleno");
        }
    }
    
    public boolean asignarPoliza(int dni, int poliza){
        int i =0;
        boolean esta = false;
        while((i<dimL)&&(!esta)){
            if(infoAlumno[i].getDni()==dni){
                esta=true;
                infoAlumno[i].setPoliza(poliza);
            }
            i++;
        }
        return esta;
    }
    
    public int cantidadXObraSocial(String oS){
        int cantidad=0;
        for(int i=0; i<dimL; i++){
            if(infoAlumno[i].getObraSocial().equals(oS)){
                cantidad++;
            }
        }
        return cantidad;
    }
    
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL; i++){
            aux+=this.infoAlumno[i].toString() + "\n";
        }
        return "Patente: " +this.getPatente() + "capacidad: " + this.getCapacidad() +"\n" +
                aux;
        
    }
    
    
}
