package ar.edu.unlp.objetos.uno.ejercicio13;

import java.util.ArrayList;
import java.util.List;

public class Inversor {
	private String nombre;
	private List<Inversion> inversiones;
	
	public Inversor(String nombre) {
		this.nombre = nombre;
		this.inversiones = new ArrayList<Inversion>();
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	
	public void agregarInversion(Inversion inversion) {
		this.inversiones.add(inversion);
	}
	
	public void quitarInversion(Inversion inversion) {
		this.inversiones.remove(inversion);
	}
	
	public double valorActual() {
		return this.inversiones.stream()
			.mapToDouble(Inversion::valorActual)
			.sum();
	}
	
	
}
