package tp1.ejercicio7;

import java.util.Objects;

public class Estudiante {
	private String nombre;
	private String apellido;

	
	public Estudiante(String nombre, String apellido) {
		this.nombre = nombre;
		this.apellido = apellido;

	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}



	@Override
	public String toString() {
		String aux = "Estudiante: " + getNombre() + " " +  getApellido();
		return aux;
	}
	
	@Override
	public boolean equals(Object obj) {
	    if (this == obj) return true;
	    if (obj == null || getClass() != obj.getClass()) return false;
	    Estudiante that = (Estudiante) obj;
        return nombre.equals(that.nombre) && apellido.equals(that.apellido);
	}
	
	@Override
    public int hashCode() {
        return Objects.hash(nombre, apellido);
    }
	
	
	
	
}
