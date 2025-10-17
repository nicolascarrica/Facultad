package ar.edu.unlp.objetos.uno.ejercicio15;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CarpetaTest {
	private Email email1, email2;
	private Carpeta trabajo;
	
	@BeforeEach
	public void setUp() {
		trabajo = new Carpeta ("Trabajo");
		email1 = new Email("Reunion", "Reunion Hoy");
		email2 = new Email("Informe", "Adjunto el informe");
	}
	
	@Test
	public void testAgregarMail() {
		trabajo.agregarMail(email1);
		assertTrue(trabajo.getEmails().contains(email1));
		assertEquals(1, trabajo.getEmails().size());
	}
	
	@Test
	public void testEmilinarMail() {
		trabajo.agregarMail(email1);
		trabajo.agregarMail(email2);
		trabajo.eliminarMail(email1);
		assertFalse(trabajo.getEmails().contains(email1));
		assertEquals(1, trabajo.getEmails().size());
	}
	
	@Test
	public void testBuscarMail() {
		trabajo.agregarMail(email2);
		Email encontrado = trabajo.buscarEmail("informe");
        assertEquals(email2, encontrado);
	}
	
	public void testBuscarMailInexistente() {
		trabajo.agregarMail(email1);
		assertNull(trabajo.buscarEmail("No Esta"));
	}
	
	@Test
    public void testTamanioCarpeta() {
        trabajo.agregarMail(email1);
        trabajo.agregarMail(email2);
        int esperado = email1.tamanioMail() + email2.tamanioMail();
        assertEquals(esperado, trabajo.tamanioCarpeta());
    }
}
