package ar.edu.unlp.objetos.uno.ejercicio8;

import java.time.LocalDate;

public class Mamifero {
	private String especie;
	private LocalDate fechaNacimiento;
	private Mamifero padre;
	private Mamifero madre;
	private String identificador;
	
	public Mamifero() {
		
	}
	
	public Mamifero (String identificador) {
		this.identificador = identificador;
	}
	
	public String getIdentificador() {
		return this.identificador;
	}
	
	public void setIdentificador(String id) {
		this.identificador = id;
	}
	
	public String getEspecie() {
		return this.especie;
	}

	public void setEspecie(String especie) {
		this.especie = especie;
	}
	
	public LocalDate getFechaNacimiento() {
		return this.fechaNacimiento;
	}

	public void setFechaNacimiento(LocalDate fecha) {
		this.fechaNacimiento = fecha;
	}
	
	public Mamifero getPadre() {
		return this.padre;
	}

	public void setPadre(Mamifero padre) {
		this.padre = padre;
	}

	public Mamifero getMadre() {
		return this.madre;
	}

	public void setMadre(Mamifero madre) {
		this.madre = madre;
	}
	
	public Mamifero getAbueloMaterno() {
		return this.madre != null ? this.madre.getPadre() : null;
	}
	
	public Mamifero getAbuelaMaterna() {
		return this.madre != null ? this.madre.getMadre() : null;
	}
	
	public Mamifero getAbueloPaterno() {
		return (this.padre != null) ? this.padre.getPadre() : null;
	}

	public Mamifero getAbuelaPaterna() {
		return (this.padre != null) ? this.padre.getMadre() : null;
	}
	
	public Boolean tieneComoAncestroA(Mamifero unMamifero) {
		if (unMamifero == null) return false;
		if ((this.padre == unMamifero) || (this.madre == unMamifero)) return true;
		
		return ((this.padre != null && this.padre.tieneComoAncestroA(unMamifero)) || 
				(this.madre != null && this.madre.tieneComoAncestroA(unMamifero)));
		
	}
}
