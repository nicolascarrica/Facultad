package ar.edu.unlp.objetos.uno.ejercicio13;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class InversorTest {

	private Inversor inversor;
	private InversionEnAcciones accion;
	private PlazoFijo plazoFijo;
	
	@BeforeEach
	void setUp() {
		inversor = new Inversor ("Nicolas");
		accion = new InversionEnAcciones("YPF", 10.00, 100.00);
		plazoFijo = new PlazoFijo(LocalDate.of(2025,10, 6), 100, 5);
	}
	
	@Test
	void testPlazoFijo() {
		assertEquals(100, plazoFijo.valorActual());
	}
	
	@Test
	void testInversionEnAcciones() {
		assertEquals(1000, accion.valorActual());
	}
	
	@Test
	void testInversor() {
		assertEquals(0, inversor.valorActual());
		inversor.agregarInversion(accion);
		inversor.agregarInversion(plazoFijo);
		assertEquals(1100, inversor.valorActual());
	}
}
