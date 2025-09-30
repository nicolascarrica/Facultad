package ar.edu.unlp.objetos.uno.ejercicio13;

import java.time.LocalDate;

public class PlazoFijo implements Inversion {
	
	private LocalDate fechaCreacion;
	private double montoInicial;
	private double tasaInteres;

	public PlazoFijo(LocalDate fechaCreacion, double montoInicial, double tasaInteres) {
		this.fechaCreacion = fechaCreacion;
		this.montoInicial = montoInicial;
		this.tasaInteres = tasaInteres;
	}
	
	public double valorActual() {
		// monto incial + cantidad dias * monto inicial * tasa;
		return 0.0;
	}
}
