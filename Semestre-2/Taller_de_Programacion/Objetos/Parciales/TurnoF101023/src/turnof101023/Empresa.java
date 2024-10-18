/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnof101023;

/**
 *
 * @author nicol
 */
public class Empresa {
    private String nombre;
    private String direccion;
    private Encargado [] encargados;
    private DirectorEjecutivo director;
    private int cantSucursales;
    
    public Empresa(String nombre, String direccion, DirectorEjecutivo director, int cantSucursales){
        this.nombre = nombre;
        this.direccion = direccion;
        this.director = director;
        this.cantSucursales = cantSucursales;
        this.encargados = new Encargado[cantSucursales];
        iniciar();
    }

    public String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public DirectorEjecutivo getDirector() {
        return director;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setDirector(DirectorEjecutivo director) {
        this.director = director;
    }
    
    
    private void iniciar(){
        for (int i=0; i<cantSucursales;i++){
            encargados[i]=null;
        }
    }
    
    public void agregarEncargado (int sucursal, Encargado encargado){
        if(encargados[sucursal-1]==null){
            encargados[sucursal-1]=encargado;
        } else {
            System.out.println("La sucrusal ya tiene encargado");
        } 
    }
    
    public double sueldoEmpesa(){
        double total=this.director.sueldoACobrar();
        for(int i=0; i<cantSucursales;i++){
            if(encargados[i]!=null){
                total += encargados[i].sueldoACobrar();
            }
        }
        return total;
        
    }
    
    public String toString(){
        String aux="";
        for (int i=0; i<cantSucursales;i++){
            aux+="Sucursal " + (i+1)+ " ";
            if(encargados[i]!=null){
                aux+= encargados[i].toString() + "\n";   
            } else {
                aux+= "sucursal sin encargado \n";
            }
        }
        return "Empresa: " + getNombre() + 
                ", direccion " + getDireccion() + "\n" + 
                "Director Ejecutivo " + getDirector().toString() + "\n" + 
                aux;
    }
}
