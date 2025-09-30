package ar.edu.unlp.objetos.uno.ejercicio4;

import java.util.ArrayList;
import java.util.List;

public class Balanza {
	private List<Producto> listaDeProductos;
	
	public Balanza() {
		this.ponerEnCero();
	}
	
	public void ponerEnCero() {
		this.listaDeProductos = new ArrayList<Producto>(); // buscar metodo clear 
	}
	
	
	public void agregarProducto(Producto producto) {
		this.listaDeProductos.add(producto);
	}
	
	public List<Producto> getProductos(){ 
		return this.listaDeProductos;
	}
	
	public Ticket emitirTicket() {
		Ticket tique= new Ticket(this.getCantidadDeProductos(), this.getPesoTotal(), this.getPrecioTotal(), this.getProductos());
		this.ponerEnCero();
		return tique;
	}
	
	public double getPesoTotal() {
	    double total = 0;
	    for (Producto p : this.listaDeProductos) {
	        total += p.getPeso();
	    }
	    return total;
	}
	
	public double getPrecioTotal() {
	    double total = 0;
	    for (int i = 0; i < this.listaDeProductos.size(); i++) {
	        total += this.listaDeProductos.get(i).getPrecio();
	    }
	    return total;
	}

	public int getCantidadDeProductos() {
		return this.listaDeProductos.size();
	}
	
}

