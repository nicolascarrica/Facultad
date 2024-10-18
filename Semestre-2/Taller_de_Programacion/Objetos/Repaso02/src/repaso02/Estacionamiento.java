/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso02;

/**
 *
 * @author nicol
 */
public class Estacionamiento {
    private String nombre;
    private String direccion;
    private int horaApertura;
    private int horaCierre;
    private Auto [][] lugares;
    private int pisos;
    private int plazas;
    
    public Estacionamiento(String nombre, String direccion){
        this.nombre = nombre;
        this.direccion = direccion;
        this.horaApertura = 8;
        this.horaCierre = 21;
        this.pisos = 5;
        this.plazas= 10;
        this.iniciarLugares(this.pisos, this.plazas);
    }
    
    public Estacionamiento(String nombre, String direccion, int horaApertura, int horaCierre, int pisos, int plazas ){
        this.nombre = nombre;
        this.direccion= direccion;
        this.horaApertura = horaApertura;
        this.horaCierre = horaCierre;
        this.pisos = pisos;
        this.plazas=plazas;
        this.iniciarLugares(this.pisos, this.plazas);
    }
    
    public void iniciarLugares(int pisos, int plazas){
        this.lugares = new Auto[pisos][plazas];
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getDireccion() {
        return direccion;
    }

    public int getHoraApertura() {
        return horaApertura;
    }

    public int getHoraCierre() {
        return horaCierre;
    }

    public Auto[][] getLugares() {
        return lugares;
    }

    public int getPisos() {
        return pisos;
    }

    public int getPlazas() {
        return plazas;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setHoraApertura(int horaApertura) {
        this.horaApertura = horaApertura;
    }

    public void setHoraCierre(int horaCierre) {
        this.horaCierre = horaCierre;
    }

    public void setLugares(Auto[][] lugares) {
        this.lugares = lugares;
    }

    public void setPisos(int pisos) {
        this.pisos = pisos;
    }

    public void setPlazas(int plazas) {
        this.plazas = plazas;
    }
    
    public void registratAuto(Auto miAuto, int piso, int plaza){
        this.lugares[piso-1][plaza-1] = miAuto;
    }
    
    public String buscarAuto(String patente){
        boolean encontrado = false;
        int i=0;
        int j=0;
        while (i<pisos && !encontrado){
            j=0;
            while(j < plazas && !encontrado){
                if(lugares[i][j]!= null &&lugares[i][j].getPatente().equals(patente)){
                    encontrado=true;
                } else {
                    j++;
                }
            }
            if(!encontrado){
                i++;
            }
        }
        if(encontrado){
            return "Piso " + (i+1) + " Plaza " + (j+1);
        } else {
            return "Auto inexistente";
        }
    }
    
    
    @Override
    public String toString(){
        String aux = "";
        String lugar;
        for(int i=0; i<this.getPisos();i++){
            for(int j=0;j<this.getPlazas();j++){
                if(this.lugares[i][j] == null){
                    lugar = "Libre";
                } else {
                    lugar=this.lugares[i][j].toString();
                    
                }
                aux = aux + "Piso " + (i + 1) + ", Plaza " + (j + 1) + ": " + lugar + "\n";
            }
        }
        return aux;
    }
    
    public int cantidadAutos(int plaza){
        int cantidad = 0;
        for(int i=0; i<this.pisos;i++){
            if(this.lugares[i][plaza-1] !=null){
                cantidad ++;
            }
        }
        return cantidad;
    }
    
   
    
}
