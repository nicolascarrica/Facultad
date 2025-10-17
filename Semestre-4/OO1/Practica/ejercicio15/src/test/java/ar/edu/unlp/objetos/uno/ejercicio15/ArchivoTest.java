package ar.edu.unlp.objetos.uno.ejercicio15;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Aca escribiremos los test de unidad para cada clase 
 * 
 */
public class ArchivoTest {
	
	private Archivo archivo;
	
	@BeforeEach
	void setUp() {
		archivo = new Archivo("Archivo");
	}
	
    @Test
    public void tamanioTest() {
        assertEquals(7, archivo.tamanio());
    }
}
