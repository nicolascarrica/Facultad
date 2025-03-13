package tp1.ejercicio3;
import java.util.Scanner;
public class Test {
	public static void main (String[] args) {
		Estudiante [] arrayEstudiantes = new Estudiante [2];
		Profesor [] arrayProfesores = new Profesor [3];
		Scanner scanner = new Scanner(System.in);
		
		for (int i=0; i<2; i++) {
			System.out.println("Introduzca datos del estudiante");
			System.out.println("Nombre: ");
			String nombre = scanner.nextLine();
			System.out.println("Apellido: ");
			String apellido = scanner.nextLine();
			System.out.println("Comision: ");
			int comision = scanner.nextInt();
			scanner.nextLine();
			System.out.println("email: ");
			String email = scanner.nextLine();
			System.out.println("Direccion: ");
			String direccion = scanner.nextLine();
			
			arrayEstudiantes[i] = new Estudiante(nombre, apellido, comision, email, direccion);
			
		}
		
		for (int i=0; i<3; i++) {
			System.out.println("Introduzca datos del estudiante");
			System.out.println("Nombre: ");
			String nombre = scanner.nextLine();
			System.out.println("Apellido: ");
			String apellido = scanner.nextLine();
			System.out.println("email: ");
			String email = scanner.nextLine();
			System.out.println("Catedra: ");
			String catedra = scanner.nextLine();
			System.out.println("Facultad: ");
			String facultad = scanner.nextLine();
			
			arrayProfesores[i] = new Profesor(nombre, apellido, email, catedra, facultad);
		}
		
		scanner.close();
		for (int i=0; i<2; i++) {
			System.out.println(arrayEstudiantes[i].tusDatos());
		}
		
		for (int i=0; i<3; i++) {
			System.out.println(arrayProfesores[i].tusDatos());
		}
		
	}
}
