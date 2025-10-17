package ar.edu.unlp.objetos.uno.ejercicio15;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Aca escribiremos los test de unidad para cada clase 
 * 
 */
public class EmailTest {
	
	private Archivo file1, file2;
	private Email email, emptyEmail;
	
	@BeforeEach
	void setUp() {
		file1 = new Archivo("Archivo1");
		file2 = new Archivo("Archivo2");
		email = new Email("OO1","HolaObjetos");
		emptyEmail = new Email("", "");
		email.agregarAdjunto(file1);
		email.agregarAdjunto(file2);
	}
	
    @Test
    public void tamanioMailTest() {
        assertEquals(30, email.tamanioMail());
        assertEquals(0, emptyEmail.tamanioMail());
    }
    
    @Test
    void contieneTextoTest() {
    	assertTrue(email.contieneTexto("OO1"));
    	assertTrue(emptyEmail.contieneTexto(""));
    	assertFalse(email.contieneTexto("nicolas"));
    }
}
