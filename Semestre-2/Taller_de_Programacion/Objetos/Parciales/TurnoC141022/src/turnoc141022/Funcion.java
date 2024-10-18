/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnoc141022;

/**
 *
 * @author nicol
 */
public class Funcion {
    private String titulo;
    private String fecha;
    private int hora;
    private Butaca [][] sala;
    private int cantFilas;
    private int cantButacas;

    public Funcion(String titulo, String fecha, int hora, int cantFilas, int cantButacas) {
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
        this.cantFilas = cantFilas;
        this.cantButacas = cantButacas;
        this. sala = new Butaca[cantFilas][cantButacas];
        for (int i=0; i<cantFilas;i++){
            for (int j=0; j<cantButacas;j++){
                this.sala[i][j] = new Butaca(i+1, j+1);
            }
        }
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getFecha() {
        return fecha;
    }

    public int getHora() {
        return hora;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public void setHora(int hora) {
        this.hora = hora;
    }
    
    
    public double ocuparButaca(int nButaca, int fila){
        if(!sala[fila-1][nButaca-1].isOcupada()){
            sala[fila-1][nButaca-1].ocupar();
        }
        return sala[fila-1][nButaca-1].getPrecio();
    }
    
    public void desocuparButacas(int fila){
        for (int i=0; i<cantButacas;i++){
            sala[fila-1][i].desocupar();
        }
    }
    
    public String StringButacaB(int nButaca){
        String aux="";
        for(int i=0; i<cantFilas; i++){
            aux+= sala[i][nButaca-1].toString() + "\n";
        }
        return aux;
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<cantFilas;i++){
            for(int j=0;j<cantButacas;j++){
               aux+= sala[i][j].toString();
            }
        }
        return "Titulo: " + this.getTitulo() + ", fecha " + this.getFecha() + ", hora: " + this.getHora() + "\n" + 
                aux;
    }
}
