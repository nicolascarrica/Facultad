package ar.edu.unlp.objetos.uno.ejercicio14;

public class Esfera extends Pieza {
	
	private double radio;
	
	public Esfera (String material, String color, double radio) {
		super(material, color);
		this.radio = radio;
		
	}
	
	public double calcularVolumen() {
		return (4.0 / 3.0) * Math.PI * Math.pow(this.radio, 3);
	}
	
	public double calcularSuperficie() {
		return 4 * Math.PI * Math.pow(this.radio, 2);
	}

}
