package ar.edu.unlp.objetos.uno.ejercicio12;

import java.util.List;

public class FIFO implements Strategy {
	public JobDescription next(List<JobDescription> jobs) {
		JobDescription nextJob = null;
		if (jobs !=null) {
			nextJob = jobs.get(0);
		}
		return nextJob;
	}

}
