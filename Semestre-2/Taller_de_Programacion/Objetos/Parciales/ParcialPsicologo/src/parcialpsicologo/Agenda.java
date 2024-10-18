/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcialpsicologo;

/**
 *
 * @author nicol
 */
public class Agenda {
    private int cantDias;
    private int cantsesiones;
    private Paciente [][] pacientes;
    
    public Agenda(){
        this.cantDias = 5;
        this.cantsesiones = 6;
        this.pacientes = new Paciente[cantDias][cantsesiones];
        iniciarAgenda();
    }
    
    private void iniciarAgenda(){
        for (int i=0; i<cantDias;i++){
            for(int j=0; j<cantsesiones;j++){
                pacientes[i][j] = null;
            }
        }
    }
    
    public void agregarPaciente(Paciente p, int dia, int turno){
        pacientes[dia-1][turno-1]= p;
    }
    
    public void liberarTurnos(String nombre){
        for(int i=0; i<cantDias; i++){
            for(int j=0; j<cantsesiones;j++){
                if(pacientes[i][j]!=null && pacientes[i][j].getNombre().equals(nombre)){
                    pacientes[i][j] = null;
                }
            }
        }
    }
    
    public boolean tieneTurno(int dia, String nombre){
        boolean existe = false;
        int i=0;
        while(i<this.cantsesiones&& !existe){
            if(pacientes[dia-1][i]!=null && pacientes[dia-1][i].getNombre().equals(nombre)){
                existe=true;
            }
            i++;
        }
        return existe;
    }
    
}
