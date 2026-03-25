package ar.edu.unlp.info.oo2.ejercicio1;

import java.util.ArrayList;
import java.util.List;

public class Plataforma {
	private List<Usuario> usuarios;
	
	public Plataforma() {
		this.usuarios = new ArrayList<Usuario>();
	}
	
	public Usuario crearUsuario(String screenName) {
		Usuario u = null;
		if (!existeUsuario(screenName)) {
			u = new Usuario (screenName);
			this.usuarios.add(u);
		}
		return u;
	}
	
	private boolean existeUsuario (String screenName) {
		return this.usuarios.stream().anyMatch(usuario -> usuario.getScreenName().equals(screenName));
	}
	
	public void eliminarUsuario (Usuario user) {
		if (user!= null && existeUsuario(user.getScreenName())) {
			List <Tweet> lisTweets = user.getTweets(); 
			this.usuarios.stream().forEach(u -> u.removerRetweets(lisTweets));
			user.eliminarPublicaciones();
			this.usuarios.remove(user);
		}
	}
	
	public List<Usuario> getUsuarios() {
		return new ArrayList<Usuario>(usuarios);
	}
}
