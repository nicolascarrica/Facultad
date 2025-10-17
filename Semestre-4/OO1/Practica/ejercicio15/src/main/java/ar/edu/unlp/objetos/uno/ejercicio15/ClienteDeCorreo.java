package ar.edu.unlp.objetos.uno.ejercicio15;

import java.util.ArrayList;
import java.util.List;

public class ClienteDeCorreo {
	private List<Carpeta> carpetas;
	private Carpeta inbox;
	
	public ClienteDeCorreo(String nombre) {
		this.inbox = new Carpeta(nombre);
		this.carpetas = new ArrayList<Carpeta>();
		this.carpetas.add(this.inbox);
	}
	
	public void agregarCarpeta(Carpeta carpeta) {
		this.carpetas.add(carpeta);
	}
	
	public void recibir (Email email) {
		this.inbox.agregarMail(email);
	}
	
	public void mover(Email email, Carpeta destino) {
		destino.agregarMail(email);
	}
	
	public Email buscar(String texto) {
		return this.carpetas.stream()
				.map(c -> c.buscarEmail(texto))
				.filter(e -> e.contieneTexto(texto))
				.findFirst()
				.orElse(null);
	}
	
	public int espacioOcupado() {
		return this.carpetas.stream()
				.mapToInt(c -> c.tamanioCarpeta())
				.sum();
	}
}
