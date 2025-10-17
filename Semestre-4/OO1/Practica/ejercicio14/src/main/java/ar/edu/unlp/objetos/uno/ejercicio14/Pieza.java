package ar.edu.unlp.objetos.uno.ejercicio14;

public abstract class Pieza {
	private String material;
	private String color;
	
	public Pieza (String material, String color) {
		this.color = color;
		this.material = material;
	}
	
	public String getColor() {
		return this.color;
	}
	
	public String getMaterial() {
		return this.material;
	}
	
	public boolean esMaterial (String material) {
		return this.material.equals(material);
	}
	
	public abstract double calcularVolumen();
	public abstract double calcularSuperficie();
}
