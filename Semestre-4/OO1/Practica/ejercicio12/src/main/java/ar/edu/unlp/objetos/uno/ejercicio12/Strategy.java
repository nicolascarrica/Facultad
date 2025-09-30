package ar.edu.unlp.objetos.uno.ejercicio12;

import java.util.List;

public interface Strategy {
	public JobDescription next(List<JobDescription> jobs);
}
