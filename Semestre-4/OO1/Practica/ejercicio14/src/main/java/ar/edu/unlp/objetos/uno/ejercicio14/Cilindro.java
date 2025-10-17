package ar.edu.unlp.objetos.uno.ejercicio14;

public class Cilindro extends Pieza{
	
	private double radio;
	private double altura;
	
	public Cilindro(String material, String color, double radio, double altura) {
		super(material, color);
		this.radio = radio;
		this.altura = altura;
	}
	
	public double calcularVolumen() {
		return Math.PI * (Math.pow(this.radio, 2)) * this.altura;
	}
	
	public double calcularSuperficie() {
		return Math.PI* 2 * this.radio * this.altura + 2*Math.PI * (Math.pow(this.radio, 2));
	}
	
}
