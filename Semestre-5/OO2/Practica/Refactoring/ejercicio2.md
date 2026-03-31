# Ejercicio 2

## Tareas
1) Se quiere aplicar el refactoring Rename Variable sobre la variable result que se usa
en la línea 18 con el nuevo nombre currentPosition.
2) ¿Cómo queda el código final y qué inconveniente se podría encontrar? 

### CharRing.java

```java
public class CharRing extends Object {
   char[] source;
   int idx;

   public CharRing(String srcString) {
       char result;
       source = new char[srcString.length()];
       srcString.getChars(0, srcString.length(), source, 0);
       result = 0;
      idx = result;
  }

  public char next() {
        int result;
        if (idx >= source.length)
          idx = 0; 
        result = idx++;          
        return source[result];
    } 
}
```
### Tarea 1: Aplicar Rename Variable

El refactoring Rename Variable sobre `result` en la línea 18 implica renombrar todas las ocurrencias de esa variable dentro de su scope (el método `next()`).
El código del método `next()` quedaría así:

```java
public char next(){
    int currentPosition;
    if (idx >= source.length)
        idx = 0;
    result = idx++;
    return source[result];
}
```
### Tarea 2: Inconveniente que se puede encontrar
El problema esta en el constructor, que tiene una variable `result` pero de tipo char
Si se aplica el renombrado de forma descuidada o automática (por ejemplo, con un simple buscar-y-reemplazar global), se podría renombrar también esta variable, cuando en realidad son variables completamente distintas: tienen diferente scope, diferente tipo y diferente propósito