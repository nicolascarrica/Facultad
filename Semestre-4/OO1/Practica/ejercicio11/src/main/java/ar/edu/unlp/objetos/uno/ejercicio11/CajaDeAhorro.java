package ar.edu.unlp.objetos.uno.ejercicio11;

public class CajaDeAhorro extends Cuenta {
	public CajaDeAhorro() {
		super();
	}
	
	public void depositar(double monto) { // se implementa debido a que Caja de ahorro tiene un impuesto para depositar y extraer
		super.depositar(monto - (monto*0.02));
	}
	
	protected void extraerSinControlar(double monto) { // igual que el metodo depositar
		super.extraerSinControlar(monto + (monto*0.02));
	}
	
	@Override
	public boolean puedeExtraer(double monto) {
		return this.getSaldo()>= monto + (monto * 0.02) ? true : false;
	}
}
