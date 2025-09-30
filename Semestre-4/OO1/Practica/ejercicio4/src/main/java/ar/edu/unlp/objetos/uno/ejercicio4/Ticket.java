package ar.edu.unlp.objetos.uno.ejercicio4;

import java.time.LocalDate;
import java.util.List;

public class Ticket {
	private LocalDate fecha;
	private int cantidadDeProductos;
	private double pesoTotal;
	private double precioTotal;
	private List<Producto> lista;
	
	
	public Ticket(int cantidadProductos, double pesoTotal, double precioTotal, List<Producto> lista) {
		this.fecha = LocalDate.now();
		this.cantidadDeProductos = cantidadProductos;
		this.pesoTotal = pesoTotal;
		this.precioTotal = precioTotal;
		this.lista = lista;
	}
	
	public double impuesto() {
		return this.precioTotal * 0.21;
	}
	
	public double getPesoTotal() {
		return pesoTotal;
	}

	public double getPrecioTotal() {
		return precioTotal;
	}
	
	public LocalDate getFecha() {
		return this.fecha;
	}
	
	public int getCantidadDeProductos() {
		return cantidadDeProductos;
	}
	
	public List<Producto> getProductos(){
		return this.lista;
	}
}
