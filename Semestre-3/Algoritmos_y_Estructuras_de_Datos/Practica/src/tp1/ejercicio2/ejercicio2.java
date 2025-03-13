package tp1.ejercicio2;
import java.util.Scanner;
public class ejercicio2 {

    public static int[] generarMultiplos(int n) {
        int[] multiplos = new int[n]; 
        for (int i = 0; i < n; i++) {
            multiplos[i] = n * (i + 1);
        }
        return multiplos;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Ingrese el número para calcular sus múltiplos:");
        int n = scanner.nextInt();

       
        int[] resultado = generarMultiplos(n);

        System.out.println("Los primeros " + n + " múltiplos de " + n + " son:");
        for (int numero : resultado) {
            System.out.print(numero + " ");
        }

        scanner.close();
    }
}
