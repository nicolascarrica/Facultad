/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repaso02;
import PaqueteLectura.*;

/**
 *
 * @author nicol
 */
public class Repaso02 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int pisos =3;
        int plazas=5;
        Estacionamiento miEstacionamiento = new Estacionamiento("Varela", "41 682");
        System.out.println(miEstacionamiento.toString());
        Auto a;
        
        for(int i=0; i<pisos; i++){
            for (int j= 0; j<plazas; j++){
                a = new Auto(GeneradorAleatorio.generarString(6), GeneradorAleatorio.generarString(5));
                miEstacionamiento.registratAuto(a, i+1, j+1);
            }
        }
        
        System.out.println(miEstacionamiento.toString());
        System.out.println("cantidad de autos en esa plaza 2 es " + miEstacionamiento.cantidadAutos(2));
        System.out.println("Ingrese un numero de patente");
        String aux = Lector.leerString();
        System.out.println(miEstacionamiento.buscarAuto(aux));
        }
    
}
