package ar.edu.unlp.objetos.uno.ejercicio12;

import java.util.List;

public class LIFO implements Strategy {
	public JobDescription next(List<JobDescription> jobs) {
		JobDescription nextJob = null;
		if(jobs != null) {
			nextJob = jobs.get(jobs.size()-1);
		}
		return nextJob;
	}
}
