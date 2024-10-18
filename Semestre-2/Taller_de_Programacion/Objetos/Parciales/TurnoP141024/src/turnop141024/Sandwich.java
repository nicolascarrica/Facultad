/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnop141024;

/**
 *
 * @author nicol
 */
public class Sandwich {
    private String nombre;
    private Pan pan;
    private Ingrediente [] ingredientes;
    private int maxIngredientes;
    private int dimL;
    
    public Sandwich(String nombre, Pan pan, int maxIngredientes){
        this.nombre = nombre;
        this.pan = pan;
        this.maxIngredientes = maxIngredientes;
        this.dimL = 0;
        this.ingredientes = new Ingrediente[maxIngredientes];
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Pan getPan() {
        return pan;
    }

    public void setPan(Pan pan) {
        this.pan = pan;
    }
    
    
    public void agregarIngrediente(Ingrediente i){
        if(this.dimL < this.maxIngredientes){
            ingredientes[dimL]=i;
            dimL++;
        }else{
            System.out.println("no se pueden agregar mas ingredientes");
        }
    }
    
    private double costoPanes(){
        double total =pan.getMonto();
        if(pan.getCalidad().equals("Premium")){
            total+= pan.getMonto()*0.2;
        }
        return total;
    }
    
    private double costoIngredientes(){
        double total = 0;
        for(int i=0; i<dimL; i++){
            if(ingredientes[i].getGrupo()=='B'){
                total+=ingredientes[i].getMonto() + ingredientes[i].getMonto()*0.1;
            } else {
                total+=ingredientes[i].getMonto();
            }
        }
            return total;
    }
    
    public double costoFinal(){
        return this.costoIngredientes() + this.costoPanes();
    }
    
    public String toString(){
        String aux="";
        for(int i=0; i<dimL; i++){
            aux+= ingredientes[i].toString() + " | ";
        }
        return "Nombre: " + this.getNombre() + "\n" + 
                "Pan: " + this.getPan().toString() + "\n" + 
                aux + "\n" + 
                "costo Final: " +this.costoFinal();
    }
            
}
