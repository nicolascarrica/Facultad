# Ejercicio 1: Algo huele mal

## 1.1 Protocolo de Cliente

### Bad Smell: Los nombres de los metodos son poco explicativos
Los siguientes métodos tienen nombres poco descriptivos (*code smell*):
- `public double lmtCrdt()`
- `protected double mtFcE(LocalDate f1, LocalDate f2)`  
- `private double mtCbE(LocalDate f1, LocalDate f2)`

### Soluciomn: Aplicar *Rename Method*
Se renombran los metodos mencionados para que sean mas descriptivos:
```java
public double getLimiteCredito() { ... }

protected double getMontoFacturadoEntreFechas(LocalDate f1, LocalDate f2) { ... }

private double getMontoCobradoEntreFechas(LocalDate f1, LocalDate f2) { ... }
```
### Bad Smell: Los nombres de los metodos son poco explicativos
Los parametros `f1` y `f2`no describen cual es su proposito

### Solución: Renombrar parámetros
Se aplican nombres más descriptivos:  
```java
protected double getFacturacionEntreFechas(LocalDate fechaInicio, LocalDate fechaFin) { ... }

private double getMontoCobradoEntreFechas(LocalDate fechaInicio, LocalDate fechaFin) { ... }
```

---

## 1.2 Participación en proyectos

### Bad Smell: *Feature Envy* y Mala Asignación de Responsabilidad
El método `participaEnProyecto(Persona p)` en la clase `Persona` debería estar en la clase `Proyecto`, ya que es esta última la responsable de evaluar la participación.

### Solución: Aplicar *Move Method*
Mover el método a la clase `Proyecto`.

### Bad Smell: Rompe el encapsulamiento
En la clase `Persona`, la variable de instancia `id` es pública, lo que viola el encapsulamiento.

### Solución: Aplicar *Encapsulate Field*
```java
private int id;
```

---

### 1.3 Calculos

### Código original
```java
public void imprimirValores() {
    int totalEdades = 0;
    double promedioEdades = 0;
    double totalSalarios = 0;
    
    for (Empleado empleado : personal) {
        totalEdades = totalEdades + empleado.getEdad();
        totalSalarios = totalSalarios + empleado.getSalario();
    }
    promedioEdades = totalEdades / personal.size();
        
    String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
    
    System.out.println(message);
}
```

### Bad Smell: Nombre del metodo poco explicativo.
El nombre `imprimirValores()` no refleja claramente lo que hace.

### Solución: Aplicar *Rename Method*
```java
public void imprimirPromedioEdadYSalario() { ... }
```

### Bad Smell: *Reinventando la rueda* en el cálculo de salarios
El bucle para sumar salarios y edades puede optimizarse, ademas la de esta forma se puede eliminar la variable innecesaria `totalEdades`

### Solución: Aplicar *Replace Loop with Pipeline* para eliminar el bucle y Eliminar variables redundantes
```java
  public void imprimirPromedioEdadYSalario(){
    int totalEdades = 0;
    double promedioEdades = this.personal.stream().mapToDouble(e -> e.getEdad().average().orElse(0));
    double totalSalarios = this.personal.stream().maoToDouble(e -> e.getSalario()).sum();

    String message = String.format("El promedio de las edades %s y el total de salarios es %s", promedioEdades, totalSalarios);

    System.out.println(message);
  }
```

## Bad Smell: *Long Method*
El método `imprimirPromedioEdadYSalario()` hace demasiadas cosas, calcula promedios y ademas imprime

### Solución: Aplicar *Extract Method* para el cálculo de salarios
```java
public void imprimirPromedioEdadYSalario() {
    double promedioEdades = this.personal.stream().mapToDouble(e -> e.getEdad()).average().orElse(0);
    double totalSalarios = this.calcularTotalSalarios();
    
    String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
    
    System.out.println(message);
}

public double calcularTotalSalarios() {
    return this.personal.stream().mapToDouble(e -> e.getSalario()).sum();
}
```

### Solución: Aplicar *Extract Method* para el cálculo de edades
```java
public void imprimirPromedioEdadYSalario() {
    double promedioEdades = this.calcularPromedioEdad();
    double totalSalarios = this.calcularTotalSalarios();
    
    String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
    
    System.out.println(message);
}

public double calcularTotalSalarios() {
    return this.personal.stream().mapToDouble(e -> e.getSalario()).sum();
}

public double calcularPromedioEdad() {
    return this.personal.stream().mapToDouble(e -> e.getEdad()).average().orElse(0);
}
```

### Bad Smell: *Long Method* y uso de variables temporales
El método aún puede simplificarse eliminando las variables temporales.

### Solución: Aplicar *Replace Temp with Query*
```java
public void imprimirPromedioEdadYSalario() {
    String message = String.format("El promedio de las edades es %s y el total de salarios es %s", 
        this.calcularPromedioEdad(), this.calcularTotalSalarios());
    
    System.out.println(message);
}

public double calcularTotalSalarios() {
    return this.personal.stream().mapToDouble(e -> e.getSalario()).sum();
}

public double calcularPromedioEdad() {
    return this.personal.stream().mapToDouble(e -> e.getEdad()).average().orElse(0);
}
```