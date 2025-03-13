package tp1.ejercicio7;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;


public class TestArrayList {
	static Scanner scanner = new Scanner(System.in);
	// inciso A
	static int [] numeros = {0,6,-5,17,23,28,99};
	static ArrayList<Integer> listaNumeros = new ArrayList<>();
	static List<Estudiante> listaOriginal = new ArrayList<>();
	
	//inciso D

	public static void incisoD() {
		// i crea lista de tres estudiantesNic
		listaOriginal.add(new Estudiante("Juan","Diaz"));
		listaOriginal.add(new Estudiante("Nico","Carri"));
		listaOriginal.add(new Estudiante("Ruslan","Gomulenko"));
		
		// ii copia de la lista
		List<Estudiante> listaCopia = new ArrayList<Estudiante>(listaOriginal);
		
		//iii imprimir las listas
		System.out.println("Lista Original: ");
		for(Estudiante e:listaOriginal) {
			System.out.println(e);
		}
		
		System.out.println("\nLista Copiada: ");
		for(Estudiante e:listaCopia) {
			System.out.println(e);
		}
		
		//iv Modificar datos de estudiante
		listaOriginal.get(0).setNombre("Franco");
		
		// v volver a imprimir
		System.out.println("\nDespués de modificar:");
		System.out.println("Lista Original: ");
		for(Estudiante e:listaOriginal) {
			System.out.println(e);
		}
		
		System.out.println("\nLista Copiada: ");
		for(Estudiante e:listaCopia) {
			System.out.println(e);
		}
		
		
		
		// Conclusión: Al modificar un estudiante en la lista original,
        // también se modifica en la copia porque ambas listas
        // contienen referencias a los mismos objetos (copia superficial)
		
	}
	// inciso E
	public static void incisoE() {
		System.out.println("\n Introduzca datos del estudiante");
		System.out.println("Ingrese nombre:" );
		String nombre = scanner.nextLine();
		System.out.println("Ingrese apellido:" );
		String apellido = scanner.nextLine();
		Estudiante nuevo = new Estudiante (nombre, apellido);
		
		if(!listaOriginal.contains(nuevo)) {
			listaOriginal.add(nuevo);
			System.out.println("Estudiante agregado con éxito");
		} else {
			System.out.println("El estudiante ya existe en la lista");
		}
		// Mostrar la lista actualizada
        System.out.println("\nLista actual de estudiantes:");
        for (Estudiante e : listaOriginal) {
            System.out.println(e);
        }
	}
	// inciso F
	public static boolean incisoF(ArrayList<Integer> lista) {
		int comienzo = 0;
		int fin = lista.size() - 1;
		
		while(comienzo < fin) {
			if(!lista.get(comienzo).equals(lista.get(fin))) {
				return false;
			}
			comienzo++;
			fin--;
		}
		return true;
	}
	
	// inciso G
	public static class IncisoG {
		public List<Integer> calcularSucesion(int n){
			List<Integer> sucesion = new ArrayList<>();
			generarSucesion(n, sucesion);
			return sucesion;
		}
		
		private void generarSucesion(int n, List<Integer> lista) {
			lista.add(n);
			if(n==1) {
				return; //caso base
			}
			if(n % 2==0) {
				generarSucesion(n/2, lista); // si es par
			} else {
				generarSucesion(3*n + 1, lista); // si es impar
			}
		}
	}
	
	//Inciso H
	public static class IncisoH {
		public static void invertirArrayList(ArrayList<Integer> lista) {
			invertirRecursivo(lista,0, lista.size()-1);
		}
		
		public static void invertirRecursivo(ArrayList<Integer> lista, int inicio, int fin) {
			if (inicio >=fin) {
				return; // caso base
			}
			
			int temp= lista.get(inicio);
			lista.set(inicio, lista.get(fin));
			lista.set(fin,  temp);
			
			invertirRecursivo(lista, inicio + 1, fin - 1);
		}
	}
	
	//inciso I
	
	public static class IncisoI{
		public static int sumarLinkedList(LinkedList<Integer> lista) {
			return sumarRecursivo(lista, 0);
		}
		
		private static int sumarRecursivo(LinkedList<Integer> lista, int index) {
			if (index == lista.size()) {
				return 0;
			}
			return lista.get(index) + sumarRecursivo(lista, index + 1);
		}
	}
	
	// inciso J
	public static class IncisoJ{
		public static ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1, ArrayList<Integer> lista2){
			ArrayList<Integer> resultado = new ArrayList<>();
			int i=0; int j=0;
			
			while(i<lista1.size()&& j<lista2.size()) {
				if(lista1.get(i)<= lista2.get(j)) {
					resultado.add(lista1.get(i));
					i++;
				}else {
					resultado.add(lista2.get(j));
					j++;
				}
			}
			
			while (i<lista1.size()) {
				resultado.add(lista1.get(i));
				i++;
			}
			
			while (j < lista2.size()) {
	            resultado.add(lista2.get(j));
	            j++;
	        }
			 return resultado;
		}
 	}
	
	public static void main(String[] args) {
		//Inciso A
		for(int i=0; i<numeros.length;i++) {
			listaNumeros.add(numeros[i]);
		}
		
		for(int num:listaNumeros) {
			System.out.println(num);
		}
		//Inciso D
		incisoD();
		//Inciso E
		incisoE();
		//Inciso F
		ArrayList<Integer> lista1 = new ArrayList<>();
		lista1.add(2);
		lista1.add(5);
		lista1.add(2);
		
		ArrayList<Integer> lista2 = new ArrayList<>();
		lista2.add(4);
		lista2.add(5);
		lista2.add(6);
		lista2.add(3);
		lista2.add(4);
		System.out.println("Lista 1 es capicúa? " + incisoF(lista1));
        System.out.println("Lista 2 es capicúa? " + incisoF(lista2));
        
        // Inciso G
        IncisoG sucesion = new IncisoG();
        int n=6;
        List<Integer> resultado = sucesion.calcularSucesion(n);
        
        System.out.println("Sucesion para " + n +": " + resultado);
        
        // Inciso H
        ArrayList<Integer> listaH = new ArrayList<>();
        listaH.add(1);
        listaH.add(2);
        listaH.add(3);
        listaH.add(4);
        listaH.add(5);
        
        System.out.println("Lista original: " + listaH);
        IncisoH.invertirArrayList(listaH);
        System.out.println("Lista invertida: " + listaH);
        
        //Inciso I
        LinkedList<Integer> listaI = new LinkedList<>();
        listaI.add(1);
        listaI.add(2);
        listaI.add(3);
        listaI.add(4);
        listaI.add(5);
        System.out.println("Lista: " + listaI);
        int suma = IncisoI.sumarLinkedList(listaI);
        System.out.println("Suma de los elementos: " + suma);
        
      //Inciso J
        ArrayList<Integer> listaJ1 = new ArrayList<>();
        listaJ1.add(1);
        listaJ1.add(3);
        listaJ1.add(5);
        listaJ1.add(7);

        ArrayList<Integer> listaJ2 = new ArrayList<>();
        listaJ2.add(2);
        listaJ2.add(4);
        listaJ2.add(6);
        listaJ2.add(8);
        
        ArrayList<Integer> listaCombinada = IncisoJ.combinarOrdenado(listaJ1, listaJ2);
        System.out.println("Lista combinada ordenada: " + listaCombinada);
        
        
	}

}
