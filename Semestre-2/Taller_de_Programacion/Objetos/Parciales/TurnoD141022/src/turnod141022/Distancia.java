/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod141022;

/**
 *
 * @author nicol
 */
public class Distancia extends Curso{
    private String link;

    public Distancia(String link, int anioCursada, int capacidadMaxima) {
        super(anioCursada, capacidadMaxima);
        this.link = link;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
    
    public boolean puedeRendir(Alumno alumno){
        return alumno.getAsistencias()>=1 && alumno.getAutoevaluaciones()>=3;
    }
    
    
}
