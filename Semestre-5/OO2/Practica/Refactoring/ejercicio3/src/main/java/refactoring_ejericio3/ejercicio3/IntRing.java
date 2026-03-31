package refactoring_ejericio3.ejercicio3;

public class IntRing extends Ring {
	private int [] source;
	
	public IntRing(int[] src) {
		super();
		source = src;
	}
	
	protected int getLength() {
		return source.length;
	}
	public int next() {	
		return source[nextIndex()];
	}
}


