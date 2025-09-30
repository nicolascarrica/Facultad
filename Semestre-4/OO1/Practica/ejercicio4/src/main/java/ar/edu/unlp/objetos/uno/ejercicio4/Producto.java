package ar.edu.unlp.objetos.uno.ejercicio4;

public class Producto {
	private double peso;
	private double precioPorKilo;
	private String descripcion;
	
	
	public double getPrecio() {
		return this.peso*this.precioPorKilo;
	}
	
	public double getPeso() {
		return this.peso;
	}
	
	public void setPeso(double peso) {
		this.peso = peso;
	}
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public void setPrecioPorKilo(double precioPorKilo) {
		this.precioPorKilo = precioPorKilo;
	}
	
	public double getPrecioPorKilo() {
		return precioPorKilo;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
}
