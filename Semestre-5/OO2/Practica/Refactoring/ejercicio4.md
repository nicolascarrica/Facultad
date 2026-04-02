<!-- markdownlint-disable -->
# Ejercicio 4

## Tareas
Una nueva red social está desarrollando un sistema para modelar perfiles y publicaciones, y medir su alcance como parte del algoritmo de relevancia. Cada publicación acumula reacciones de los usuarios, y cada perfil consolida el alcance de sus publicaciones amplificándolo según si está verificado o no. El código es el siguiente:

### Publicacion.java 
```java
package redesocial;
public class Publicacion {
    private String texto;
    private int likes;
    
    public Publicacion(String texto) {
        this.texto = texto;
        this.likes = 0;
    }

    public void darLike() { likes++; }
    
    public void darDislike() { likes--; }
    
    private int procesar() {
        return likes * 3;
    }
    
    public int calcular() {
        return procesar() * 10;
    }
}
```
### Perfil.java
```java
package redesocial;
import java.util.ArrayList;
public class Perfil {
   private boolean verificado;
   private ArrayList<Publicacion> publicaciones;

    public Perfil(boolean verificado) {
        this.verificado = verificado;
        this.publicaciones = new ArrayList<>();
    }
   
    public void agregarPublicacion(Publicacion p) {
        publicaciones.add(p); 
    }
   
    private int bonus() {
        return verificado ? 2 : 1; 
    }
    
    private int alcanceDePublicaciones() {
        return publicaciones.stream().mapToInt(p -> p.calcular()).sum();
    }
    
    public int calcular() {
       return alcanceDePublicaciones() * bonus();
   }
}
```

 
Liste cada uno de los cambios necesarios, indicando archivo y línea afectados, para cada uno de los siguientes refactorings:
1. Rename method: procesar (referenciado en línea 11 de Publicacion.java) por impacto
2. Rename method: calcular (referenciado en línea 14 de Publicacion.java) por alcance
3. Rename method: calcular (referenciado en línea 15 de Perfil.java) por alcance
4. Rename parameter: el parámetro “p” del método agregarPublicacion (línea 10 de Perfil.java) por “publicacion”

### Tarea 1: Realizar Rename method `procesar` por `impacto`
`procesar()` solo se encuentra dentro de la clase `Publicacion`. 

private int procesar() → private int impacto()

return procesar() * 10 → return impacto() * 10

### Publicacion.java 
```java
package redesocial;
public class Publicacion {
    private String texto;
    private int likes;
    
    public Publicacion(String texto) {
        this.texto = texto;
        this.likes = 0;
    }

    public void darLike() { likes++; }
    
    public void darDislike() { likes--; }
    
    private int impacto() { //rename method 
        return likes * 3;
    }
    
    public int calcular() {
        return impacto() * 10; //rename method
    }
}
```
### Tarea 2: Realizar Rename method `calcular` por `alcance`
El metodo `calcular()` solo se encuentra dentro de la clase `Publicacion`, pero tambien es llamado en la clase `Perfil`, donde se encuentra el metodo `alcanceDePublicaciones()`. Hay que renombrarlo ahi tambien

public int calcular() → public int alcance()

p -> p.calcular() → p -> p.alcance()

### Publicacion.java 
```java
package redesocial;
public class Publicacion {
    private String texto;
    private int likes;
    
    public Publicacion(String texto) {
        this.texto = texto;
        this.likes = 0;
    }

    public void darLike() { likes++; }
    
    public void darDislike() { likes--; }
    
    private int impacto() {
        return likes * 3;
    }
    
    public int alcance() { //rename method
        return impacto() * 10;
    }
}
```
### Perfil.java
```java
package redesocial;
import java.util.ArrayList;
public class Perfil {
   private boolean verificado;
   private ArrayList<Publicacion> publicaciones;

    public Perfil(boolean verificado) {
        this.verificado = verificado;
        this.publicaciones = new ArrayList<>();
    }
   
    public void agregarPublicacion(Publicacion p) {
        publicaciones.add(p); 
    }
   
    private int bonus() {
        return verificado ? 2 : 1; 
    }
    
    private int alcanceDePublicaciones() {
        return publicaciones.stream().mapToInt(p -> p.alcance()).sum(); //rename method alcance
    }
    
    public int calcular() {
       return alcanceDePublicaciones() * bonus();
   }
}
```

### Tarea 3: Rename Method: calcular → alcance (en Perfil)
Este `calcular` es de `Perfil` y es independiente del anterior — son métodos en clases distintas. En el código dado no hay ninguna clase que llame a perfil.calcular(), así que el único cambio es la definición

### Perfil.java
```java
package redesocial;
import java.util.ArrayList;
public class Perfil {
   private boolean verificado;
   private ArrayList<Publicacion> publicaciones;

    public Perfil(boolean verificado) {
        this.verificado = verificado;
        this.publicaciones = new ArrayList<>();
    }
   
    public void agregarPublicacion(Publicacion p) {
        publicaciones.add(p); 
    }
   
    private int bonus() {
        return verificado ? 2 : 1; 
    }
    
    private int alcanceDePublicaciones() {
        return publicaciones.stream().mapToInt(p -> p.alcance()).sum(); //rename method alcance
    }
    
    public int alcance() { //rename method  
       return alcanceDePublicaciones() * bonus();
   }
}
```

### Tarea 4: Rename Parameter: p → publicacion en agregarPublicacion
El parámetro solo existe dentro del scope de ese método, así que los cambios son únicamente en esas dos líneas:

### Perfil.java
```java
package redesocial;
import java.util.ArrayList;
public class Perfil {
   private boolean verificado;
   private ArrayList<Publicacion> publicaciones;

    public Perfil(boolean verificado) {
        this.verificado = verificado;
        this.publicaciones = new ArrayList<>();
    }
   
    public void agregarPublicacion(Publicacion publicacion) {
        publicaciones.add(publicacion); 
    }
   
    private int bonus() {
        return verificado ? 2 : 1; 
    }
    
    private int alcanceDePublicaciones() {
        return publicaciones.stream().mapToInt(p -> p.alcance()).sum(); //rename method alcance
    }
    
    public int alcance() { //rename method  
       return alcanceDePublicaciones() * bonus();
   }
}
```
