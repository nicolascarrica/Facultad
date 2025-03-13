package tp1.ejercicio9;

import java.util.Stack;

public class Ejercicio9 {
	public static boolean estaBalanceado(String cadena) {
		Stack<Character> pila = new Stack<>();
		
		for (char c: cadena.toCharArray()) {
			if(c == '(' || c == '[' || c=='{') {
				pila.push(c);
			} else if(c==')' || c==']' || c=='}') {
				if(pila.isEmpty()) {
					return false;
				}
				
				char ultimo = pila.pop();
				if((c==')' && ultimo!='(') ||
					(c==']' && ultimo!='[') ||
					(c=='}' && ultimo!='{')) {
					return false;
				}
			}
			
		}
		// La pila debe estar vacía al final si está balanceado
		return pila.isEmpty();
		
	}
	
	public static void main (String[] args) {
		String ejemplo1 = "{( ) [ ( ) ] }";
		String ejemplo2= "( [ ) ]";
		
		System.out.println("Ejemplo 1 esta balanceado? " + estaBalanceado(ejemplo1));
		System.out.println("Ejemplo 2 esta balanceado? " + estaBalanceado(ejemplo2));
	}

}
