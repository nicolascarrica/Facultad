package ar.edu.unlp.objetos.uno.ejercicio13;

public class InversionEnAcciones implements Inversion{
	private String nombre;
	private double cantidad;
	private double valorUnitario;
	
	public InversionEnAcciones(String nombre, double cantidad, double valorUnitario) {
		this.nombre = nombre;
		this.cantidad = cantidad;
		this.valorUnitario = valorUnitario;
	}
	
	public double valorActual() {
		return this.cantidad * this.valorUnitario;
	}
}
