package refactoring_ejericio3.ejercicio3;

/**
 * De esta forma crearemos las clases del ejercicio
 *
 */
public class CharRing extends Ring {
	private char [] source;

	public CharRing(String src) {
		super();
		source = src.toCharArray();
	}
	
	@Override
    protected int getLength() {
        return source.length;
    }
	
	public char next() {
		return source[nextIndex()];
	}

}
