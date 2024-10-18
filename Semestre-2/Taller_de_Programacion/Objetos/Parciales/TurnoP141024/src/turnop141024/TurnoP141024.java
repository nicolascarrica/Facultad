/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package turnop141024;

/**
 *
 * @author nicol
 */
public class TurnoP141024 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Pan miPan = new Pan("Premium", "Arabe", 300);
        Sandwich miSandwich = new Sandwich("De la casa", miPan, 6);
        
        Ingrediente ing1 = new Ingrediente('A', "Queso", 150);
        Ingrediente ing2 = new Ingrediente('A', "Jamon", 250);
        Ingrediente ing3 = new Ingrediente('B', "Lechuga", 100);
        Ingrediente ing4 = new Ingrediente('B', "Tomate", 100);
        Ingrediente ing5 = new Ingrediente('A', "Milanesa", 350);
        
        
        miSandwich.agregarIngrediente(ing1);
        miSandwich.agregarIngrediente(ing2);
        miSandwich.agregarIngrediente(ing3);
        miSandwich.agregarIngrediente(ing4);
        miSandwich.agregarIngrediente(ing5);
        
        System.out.println(miSandwich.toString());
        

    }
    
}
