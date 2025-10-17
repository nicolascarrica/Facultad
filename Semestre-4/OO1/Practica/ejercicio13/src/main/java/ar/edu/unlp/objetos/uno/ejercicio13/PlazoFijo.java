package ar.edu.unlp.objetos.uno.ejercicio13;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

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
		double totalDias = ChronoUnit.DAYS.between(fechaCreacion, LocalDate.now());
		return this.montoInicial + (this.montoInicial*this.tasaInteres*totalDias);
	}
}
