/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema1;
import PaqueteLectura.GeneradorAleatorio;
/**
 *
 * @author nicolas
 */
public class Ej04 {
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int oficinas = 4;
        int pisos = 8;
        int[][] edificio = new int[oficinas][pisos];

        for (int i = 0; i < oficinas; i++) {
            for (int j = 0; j < pisos; j++) {
                edificio[i][j] = 0;
            }
        }

        int piso = GeneradorAleatorio.generarInt(9) + 1;
        while (piso != 9) {
            int oficina = GeneradorAleatorio.generarInt(4) + 1;
            // restar 1 para ajustar a los índices del array (0-3 y 0-7)
            edificio[oficina - 1][piso - 1]++;
            piso = GeneradorAleatorio.generarInt(9) + 1;
        }

        // Impresión de resultados
        for (int i = 0; i < oficinas; i++) {
            for (int j = 0; j < pisos; j++) {
                System.out.println("En la oficina " + (i + 1) + " del piso " + (j + 1) + " hubo " + edificio[i][j] + " personas.");
            }
        }
    }
}
