package ar.edu.unlp.info.oo2.ejercicio1;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Aca escribiremos los test de unidad para cada clase 
 * 
 */
public class UsuarioTest {
	
	private Usuario user;
	
	@BeforeEach
	void setUp() throws Exception {
		this.user = new Usuario("Nicolas");
	}
	
    @Test
    public void testPostarTweet() {
        assertNull(user.postear(""));
        assertNotNull(user.postear("A"));
        assertNotNull(user.postear("En el desarrollo de software es importante probar los límites del sistema. Un buen test incluye casos mínimos, máximos y situaciones inesperadas. Este texto fue creado específicamente para alcanzar el límite permitido de caracteres en un tweet y verificar la validación funcione."));
		assertNull(user.postear("En el desarrollo de software es importante probar los límites del sistema. Un buen test incluye casos mínimos, máximos y situaciones inesperadas. Este texto fue creado específicamente para alcanzar el límite permitido de caracteres en un tweet y verificar la validación funcione.NO CUMPLO!!!"));
    }
    
    @Test
	public void testRepostearTweet() {
		Tweet tw = new Tweet("Esto es boca");
		assertNotNull(user.repostear(tw));
	}
    
    @Test
	public void testEliminarPublicaciones() {
		user.postear("VAMOS BOCA");
		user.postear("GOOOOL");
		assertEquals(user.getPublicaciones().size(), 2);
		user.eliminarPublicaciones();
		assertEquals(user.getPublicaciones().size(), 0);
	}
    
}
