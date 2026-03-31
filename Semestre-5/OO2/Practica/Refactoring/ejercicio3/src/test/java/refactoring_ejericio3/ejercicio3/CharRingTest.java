package refactoring_ejericio3.ejercicio3;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Aca escribiremos los test de unidad para cada clase 
 * 
 */
public class CharRingTest {
	
	CharRing ring1, ring2, ring3;
	
	
	@BeforeEach
	void setUp() throws Exception {
		ring1 = new CharRing("abc");
		ring2 = new CharRing("x");
	}
	
    @Test
    public void testNextReturnsPrimerosPrimeroElemento() {
        assertEquals('a', ring1.next());
    }
    
    @Test
    public void testNextVuelveAlInicioAlSuperar() {
        ring1.next(); // 'a'
        ring1.next(); // 'b'
        ring1.next(); // 'c'
        assertEquals('a', ring1.next()); 
    }
    
    @Test
    public void testNextConUnSoloElemento() {
        assertEquals('x', ring2.next());
        assertEquals('x', ring2.next());
        assertEquals('x', ring2.next());
    }
    
}
