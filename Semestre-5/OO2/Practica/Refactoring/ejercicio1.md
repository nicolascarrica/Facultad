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