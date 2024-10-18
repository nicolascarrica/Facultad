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
public class Viaje {
    private String colegio;
    private String fecha;
    private String destino;
    private Minibus minibus1;
    private Minibus minibus2;

    public Viaje(String colegio, String fecha, String destino, Minibus minibus1, Minibus minibus2) {
        this.colegio = colegio;
        this.fecha = fecha;
        this.destino = destino;
        this.minibus1 = minibus1;
        this.minibus2 = minibus2;
    }
    
    public String agregarAlviaje(Alumno al){
        String aux="";
        if(minibus1.getLugaresLibres()>minibus2.getLugaresLibres()){
            minibus1.agregarAlumno(al);
            aux+=minibus1.getPatente();
        }else{
            minibus2.agregarAlumno(al);
            aux+=minibus2.getPatente();
        }
        return aux;
    }
    
    public void aisgnarPoliza (int dni, int poliza){
        boolean esta=minibus1.asignarPoliza(dni, poliza);
        if(esta){
            System.out.println("Poliza agregada minibus 1");
        }else{
            esta=minibus2.asignarPoliza(dni, poliza);
            if(esta){
                System.out.println("Poliza agregada minibus 2");
            }else{
                System.out.println("No se encontro alumno");
            }
        }
        
    }
    
    public int cantidadConOS(String oS){
        return minibus1.cantidadXObraSocial(oS)+minibus2.cantidadXObraSocial(oS);
    }
    
    private int cantAlumnos(){
        return minibus1.cantidadAlumnos() + minibus2.cantidadAlumnos();
    }
    public String toString(){
        return "VIAJE ESCOLAR: FECHA: " + this.fecha + "Cantidad De Alumnos : " + this.cantAlumnos() +"\n"+
                "Minibus 1: " + minibus1.toString() +"\n" + 
                "Minubis 2: " + minibus2.toString();
    }
}
