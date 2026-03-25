package ar.edu.unlp.info.oo2.ejercicio1;

public class Retweet implements Publicacion{
	private Tweet tweetOrigen;
	
	public Retweet (Tweet tweetOrigen) {
		this.tweetOrigen = tweetOrigen;
	}
	
	public String getTexto() {
		return this.tweetOrigen.getTexto();
	}
	
	public Boolean esRetweet() {
		return true;
	}
	
	public Tweet getTweetOrigen() {
		return this.tweetOrigen;
	}
}
