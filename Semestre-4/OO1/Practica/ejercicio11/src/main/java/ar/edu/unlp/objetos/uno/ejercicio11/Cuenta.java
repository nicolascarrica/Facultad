package ar.edu.unlp.objetos.uno.ejercicio11;

public abstract class Cuenta {
	private double saldo;
	
	public Cuenta() {
		this.saldo = 0;
	}
	
	public double getSaldo() {
		return this.saldo;
	}
	
	public void depositar(double monto) {
		this.saldo += monto;
	}
	
	protected abstract boolean puedeExtraer(double monto);
	
	protected void extraerSinControlar(double monto) {
		this.saldo -= monto;
	}
	
	public boolean extraer(double monto) {
		if(this.puedeExtraer(monto)) {
			this.extraerSinControlar(monto);
			return true;
		}
		return false;
	}
	
	public boolean transferirACuenta(double monto, Cuenta cuentaDestino) {
		if (this.puedeExtraer(monto)) {
			this.extraerSinControlar(monto);
			cuentaDestino.depositar(monto);
			return true;
		}
		return false;
	}
}

/*🔹 ¿Por qué cree que este ejercicio se llama "Cuenta con ganchos"?

Porque el patrón de diseño que se usa acá se llama Template Method (Método plantilla).

La clase abstracta Cuenta define la estructura general de ciertas operaciones (extraer, transferirACuenta).

Dentro de esa estructura deja “ganchos” (puedeExtraer, extraerSinControlar) para que las subclases definan su propio comportamiento.

👉 Esos métodos abstractos/protegidos son los “ganchos” donde cada tipo de cuenta (Caja de Ahorro, Cuenta Corriente) “engancha” su lógica particular.


🔹 En las implementaciones de los métodos extraer() y transferirACuenta() que se ven en el diagrama, ¿quién es this? ¿De qué clase es this?

this siempre representa al objeto actual sobre el que se está ejecutando el método.

En tiempo de ejecución, this es de la clase concreta que se haya instanciado.

Aunque extraer() está declarado en Cuenta, cuando se llama a puedeExtraer() o extraerSinControlar(), se ejecutan los de CajaDeAhorro (porque this en ese momento es un objeto de CajaDeAhorro).

👉 Esto se llama polimorfismo dinámico. 


¿Por qué decidimos que los métodos puedeExtraer() y extraerSinControlar() tengan visibilidad protegido?

Porque no queremos que los usuarios de la clase los usen directamente.

Si fueran public, alguien podría saltarse las reglas de negocio y manipular el saldo incorrectamente.

Al ser protected, solo las subclases pueden redefinirlos o usarlos, pero no cualquier objeto externo.

👉 Así, el único “camino seguro” que se expone públicamente es llamar a extraer() o transferirACuenta().


¿Se puede transferir de una caja de ahorro a una cuenta corriente y viceversa? ¿Por qué?

Sí, se puede transferir en ambos sentidos.

transferirACuenta(monto, otraCuenta) recibe una referencia a cualquier objeto que sea Cuenta (ya sea CajaDeAhorro o CuentaCorriente).

Internamente, lo único que importa es que la cuenta origen pueda extraer y que la cuenta destino pueda recibir un depósito.

👉 Esto funciona gracias al polimorfismo: no importa si es caja de ahorro o cuenta corriente, todas heredan de Cuenta.


🔹 ¿Cómo se declara en Java un método abstracto? ¿Es obligatorio implementarlo?

Un método abstracto se declara en una clase abstracta, sin cuerpo, por ejemplo:

protected abstract boolean puedeExtraer(double monto);


Sí, es obligatorio implementarlo en las subclases concretas (que no sean abstractas).

Si una subclase no implementa un método abstracto heredado, entonces esa subclase también debe declararse abstract, sino el compilador da error.

Ejemplo:

public class CajaDeAhorro extends Cuenta {
    // Obligatorio implementar puedeExtraer(), si no → error de compilación
}

*/