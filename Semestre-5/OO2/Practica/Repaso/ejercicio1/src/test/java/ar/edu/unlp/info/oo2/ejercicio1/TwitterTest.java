package ar.edu.unlp.info.oo2.ejercicio1;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TwitterTest {
	private Plataforma twitter;
	private Usuario user;
	
	@BeforeEach
	public void setUp() {
		twitter = new Plataforma();
		user = twitter.crearUsuario("carri");
	}
	
	@Test
	public void testCrearUsuario() {
		assertNotNull(twitter.crearUsuario("Cacho"));
		assertNull(twitter.crearUsuario("Cacho"));
		assertEquals(twitter.getUsuarios().size(), 2);
	}
	
	@Test
	public void testEliminarUsuario() {
		twitter.eliminarUsuario(user);
		assertEquals(twitter.getUsuarios().size(), 0);
	}
}
