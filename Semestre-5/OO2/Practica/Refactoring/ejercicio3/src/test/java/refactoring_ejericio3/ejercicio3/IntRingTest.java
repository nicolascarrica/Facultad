package refactoring_ejericio3.ejercicio3;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class IntRingTest {
	
	IntRing ring1, ring2;
	
	@BeforeEach
	void setUp() throws Exception{
		ring1 = new IntRing(new int[]{1, 2, 3});
		ring2 = new IntRing(new int[]{1});
	}
	
	@Test
    public void testNextReturnsPrimerosPrimeroElemento() {
        assertEquals(1, ring1.next());
    }
	
	@Test
    public void testNextVuelveAlInicioAlSuperar() {
        ring1.next(); // '1'
        ring1.next(); // '2'
        ring1.next(); // '3'
        assertEquals(1, ring1.next()); 
    }
    
    @Test
    public void testNextConUnSoloElemento() {
        assertEquals(1, ring2.next());
        assertEquals(1, ring2.next());
        assertEquals(1, ring2.next());
    }

}
