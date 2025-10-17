package ar.edu.unlp.objetos.uno.ejercicio15;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ClienteDeCorreoTest {
	private ClienteDeCorreo cliente;
	private Carpeta trabajo;
	private Email email1, email2;
	
	@BeforeEach
	void setUp() {
		cliente = new ClienteDeCorreo("Nicolas");
		email1 = new Email("Reunión", "Mañana a las 10");
		email2 = new Email("Oferta", "Descuento del 20%");
        trabajo = new Carpeta("Trabajo");
        cliente.agregarCarpeta(trabajo);
	}
	
	@Test
    public void testRecibirEmail() {
        cliente.recibir(email1);
        assertEquals(email1, cliente.buscar("Reunión"));
    }
	
	@Test
	public void testMoverMail() {
		cliente.recibir(email2);
		cliente.mover(email2, trabajo);
		//el email debe moverse a la carpeta trabajo
		assertEquals(email2, trabajo.buscarEmail("Oferta"));
	}
	
	@Test
    public void testBuscarEmailInexistente() {
		trabajo.agregarMail(email1);
        assertNull(cliente.buscar("Vacaciones"));
    }
	
	@Test
	public void testEspacioOcupado() {
		cliente.recibir(email1);
		cliente.recibir(email2);
		int espacio = email1.tamanioMail() + email2.tamanioMail();
		assertEquals(espacio, cliente.espacioOcupado());
	}
	
}
