/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package parcial1;

/**
 *
 * @author nicol
 */
public abstract class Alumno {
    private int dni;
    private String nombre;
    private Materia [] aprobadas;
    private int maxMaterias;
    private int dimL;
    
    public Alumno (int dni, String nombre, int maxMaterias){
        this.dni = dni;
        this.nombre = nombre;
        this.maxMaterias = maxMaterias;
        this.aprobadas = new Materia[maxMaterias];
        this.dimL = 0;
    }

    public int getMaxMaterias() {
        return maxMaterias;
    }

    public void setMaxMaterias(int maxMaterias) {
        this.maxMaterias = maxMaterias;
    }

    
    public int getDni() {
        return dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void agregarMateria(Materia materia){
        if(dimL<maxMaterias){
            aprobadas[dimL] = materia;
            dimL++;
        }
    }
    
    public boolean tieneTesis(){
        boolean existe= false;
        int i =0;
        while((i<dimL)&& (!existe)){
            if(aprobadas[i].getNombre().equals("Tesis")){
                existe = true;
            }
            i++;
        }
        return existe;     
    }
    
    public boolean isGraduado(){
        return (dimL == maxMaterias)&&(this.tieneTesis());
    }
    
    @Override
    public String toString(){
        String graduado = isGraduado() ? "Está graduado" : "No está graduado";
        
        String aux = "";
        for(int i=0;i<dimL;i++){
            aux+=aprobadas[i].toString();
        }
        return "Dni: " + this.getDni() + 
                ", Nombre: " + this.getNombre() + 
                ", Materias aprobadas [" + aux +"]; " + 
                graduado;
                
    }
}
