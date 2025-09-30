package ar.edu.unlp.objetos.uno.ejercicio9;

import java.util.ArrayList;
import java.util.List;

public class Farola {
	private boolean encendida;
	private ArrayList <Farola> vecinos;
	
	public Farola() {
		this.encendida = false;
		this.vecinos = new ArrayList<Farola>();
	}
	
	public void pairWithNeighbor(Farola otraFarola) {
		if (!this.vecinos.contains(otraFarola)) { // Evito farolas repetidas
			this.vecinos.add(otraFarola);
			otraFarola.pairWithNeighbor(this);
		}
	}
	
	public List<Farola> getNeighbors() {
		return new ArrayList<Farola>(this.vecinos); // Le paso la copia de la lista, no la original con las referencias.
	}
	
	public void turnOn() {
		if (!this.encendida) {
			this.encendida = true;
			for (Farola farola : vecinos) {
				farola.turnOn();
			}
		}
	}
	
	public void turnOff() {
		if (this.encendida) {
			this.encendida = false;
			for (Farola farola : vecinos) {
				farola.turnOff();
			}
		}
	}
	
	public boolean isOn() { //lo agrego por el test
		return this.encendida;
	}
	
	public boolean isOff() {
		return !this.encendida;
	}
	
}
