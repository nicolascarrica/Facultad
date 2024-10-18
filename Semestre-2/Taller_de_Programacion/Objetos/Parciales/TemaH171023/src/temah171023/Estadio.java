/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package temah171023;

/**
 *
 * @author nicol
 */
public class Estadio {
    private String nombre;
    private String direccion;
    private int capacidad;
    private int dias;
    private int meses;
    private Concierto [][] agenda;

    public Estadio(String nombre, String direccion, int capacidad) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.capacidad = capacidad;
        this.dias =31;
        this.meses=12;
        this.agenda = new Concierto[meses][dias];
        iniciarAgenda();
    }

    public String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }
    
    
    public void iniciarAgenda(){
        for(int i=0; i<meses; i++){
            for(int j=0; j<dias; j++){
                agenda[i][j] = null;
            }
        }
    }
    
    public void registrarConcierto(int mes, Concierto c){
        if(mes<1 || mes>12){
            System.out.println("Mes Invalido");
            return;
        } 
        
        if (c.getEntradasVendidas() > capacidad) {
            System.out.println("No se puede registrar el concierto. Entradas vendidas (" 
                            + c.getEntradasVendidas() + ") exceden la capacidad del estadio (" 
                            + capacidad + ").");
            return;  // No se registra el concierto
        }
        
        int dia=1;
        boolean encontro = false;
        while((dia<=31)&&(encontro==false)){
            if((agenda[mes-1][dia-1]==null)&&(c.getEntradasVendidas()<=this.capacidad)){
                agenda[mes-1][dia-1] = c;
                encontro= true;
            }
            dia++;
        }
        
        if(!encontro){
            System.out.println("Sin lugar ese mes " + mes);
        }
        
    }
    
    public String listaMes(int mes){
        String aux="MES: " + mes + "\n";
        for(int j=0; j<dias;j++){
            if(agenda[mes-1][j]!=null){
               aux+= agenda[mes-1][j].toString() + "\n";
            } else aux+="Dia " + (j+1) + " vacio \n"; 
        }
        return aux;
    }
    
    public double calcularGananciaMes(int mes){
        double total=0;
        for(int j=0; j<dias;j++){
            if(agenda[mes-1][j]!=null){
               total+= agenda[mes-1][j].gananciaConcierto()/2;
            } else total+=0;
            
        }
        return total;
    }
    
    public String toString(){
        String aux="";
        for (int i=0; i<meses; i++){
            aux+= "Mes " + (i+1)+ ": \n";
            for (int j=0; j<dias; j++){
                if(agenda[i][j]!=null){
                    aux+="Dia: " + (j+1)+ " "+ agenda[i][j].toString() + "\n";
                }else aux+="Dia " + (j+1) + " vacio \n";
                
            }
        }
        return aux;
    }
    
}
