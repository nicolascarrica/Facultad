package ar.edu.unlp.objetos.uno.ejercicio15;

import java.util.ArrayList;
import java.util.List;

public class Email {
	private String titulo;
	private String cuerpo;
	private List<Archivo> adjuntos;
	
	
	public Email(String titulo, String cuerpo) {
		this.titulo = titulo;
		this.cuerpo = cuerpo;
		this.adjuntos = new ArrayList<Archivo>();
	}
	
	public String getTitulo() {
		return this.titulo;
	}
	
	public String getCuerpo() {
		return this.cuerpo;
	}
	
	public List<Archivo> adjuntos(){
		return new ArrayList<Archivo>(adjuntos);
	}
	
	public void agregarAdjunto(Archivo adjunto) {
		this.adjuntos.add(adjunto);
	}
	
	public int tamanioMail() {
		return this.titulo.length() 
				+ this.cuerpo.length()
				+ this.adjuntos.stream()
					.mapToInt(a -> a.tamanio())
					.sum();
	}
	
	public boolean contieneTexto(String texto) {
		return this.titulo.equals(texto) || this.cuerpo.equals(texto);
	}
}
