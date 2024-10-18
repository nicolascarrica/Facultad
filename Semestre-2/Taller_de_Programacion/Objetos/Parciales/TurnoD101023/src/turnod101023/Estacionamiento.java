/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnod101023;

/**
 *
 * @author nicol
 */
public class Estacionamiento {
    private String direccion;
    private double costoHora;
    private Vehiculo [][] lugares;
    private int cantSectores;
    private int cantVehiculos;
    
    public Estacionamiento (String direccion, double costoHora, int cantSectores, int cantVehiculos){
        this.direccion = direccion;
        this.costoHora = costoHora;
        this.cantSectores = cantSectores;
        this.cantVehiculos = cantVehiculos;
        this.lugares = new Vehiculo[cantSectores][cantVehiculos];
        iniciar();
                
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    private void iniciar(){
        for(int i=0;i<cantSectores;i++){
            for(int j=0;j<cantVehiculos;j++){
                this.lugares[i][j] = null;
            }
        }
    }

    public double getCostoHora() {
        return costoHora;
    }

    public void setCostoHora(double costoHora) {
        this.costoHora = costoHora;
    }
    
    
    
    public void agregarAuto(Vehiculo vehiculo, int sector, int lugar){
        this.lugares[sector-1][lugar-1] = vehiculo;
    }
    
    public String liberarMarca (int sector, String marca){
        String aux="";
        for(int j=0;j<this.cantVehiculos;j++){
            Vehiculo actual = this.lugares[sector-1][j];
            if((actual!=null) && actual.getMarca().equals(marca)){
                aux+=actual.toString();
                this.lugares[sector-1][j] = null;
            }
        }
        return aux;
    }
    
    public double montoSector(int sector){
        double monto=0;
        for(int j=0; j<cantVehiculos;j++){
            if(this.lugares[sector-1][j]!=null){
                monto+=this.lugares[sector-1][j].getCantHoras()*this.costoHora;
            }
        }
        return monto;
    }
    
    
    public int sectorMasRecaudo(){
        double maxMonto = 0;
        int maxSector = 0;
        for (int i=1; i<=cantSectores;i++){
            if(this.montoSector(i)>maxMonto){
                maxMonto = this.montoSector(i);
                    maxSector = (i);
            }
        }
        return maxSector;
    }
 
    public String toString(){
        String aux="";
        for(int i=0;i<cantSectores;i++){
            aux+="Sector " + (i+1) + "\n";
            for(int j=0; j<cantVehiculos;j++){
                if(this.lugares[i][j]!=null){
                    aux+="Lugar " + (j+1)+ " " + this.lugares[i][j].toString() + "\n";
                } else {
                    aux+= "Lugar " + (j+1) + " Vacio \n";
                }
            }
        }
        return "Estacionamiento: " + this.getDireccion() + "costo Hora: " +this.getCostoHora() + "\n" + aux;
    }
}
