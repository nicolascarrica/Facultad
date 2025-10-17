package ar.edu.unlp.objetos.uno.ejercicio15;

import java.util.ArrayList;
import java.util.List;

public class Carpeta {
	private String nombre;
	private List<Email> emails;
	
	public Carpeta(String nombre) {
		this.nombre = nombre;
		this.emails = new ArrayList<Email>();
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	public void agregarMail(Email email) {
		this.emails.add(email);
	}
	
	public void eliminarMail(Email email) {
		this.emails.remove(email);
	}
	
	public int tamanioCarpeta() {
		return this.emails.stream()
				.mapToInt(e -> e.tamanioMail())
				.sum();
	}
	
	public void mover(Email email, Carpeta destino) {
		this.eliminarMail(email);
		destino.agregarMail(email);
	}
	
	public List<Email> getEmails(){
		return this.emails;
	}
	
	public Email buscarEmail(String texto) {
		return this.emails.stream()
				.filter(e -> e.contieneTexto(texto))
				.findFirst()
				.orElse(null);
	}
}
