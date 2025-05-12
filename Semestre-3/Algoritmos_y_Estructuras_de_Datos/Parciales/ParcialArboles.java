public class ParcialArboles {
  private BinaryTree<Integer> arbol;
  public PacialArboles(BinaryTree<Integer> arbol) {
    this.arbol = arbol;
  }

  public boolean isTwoTree(int num){
    if(arbol == null) return false;
    return buscarValor(this.arbol, num);
  }

  private boolean buscarValor(BinaryTree<Integer> arbol, int num){
    if(arbol.getData() == num) {
      int izq = contarHijos(arbol.getLeft());
      int der = contarHijos(arbol.getRight());
      return izq == der;
    } else {
      return buscarValor(arbol.getLeft(), num) || buscarValor(arbol.getRight(), num);
    }
  }

  private int contarHijos(BinaryTree<Integer> arbol) {
    if(arbol == null) return -1;
    int suma = 0;
    if(arbol.hasLeftChild() && arbol.hasRigthChild()){
      suma += 1;
    }
    suma += contarHijos(arbol.getLeft());
    suma += contarHijos(arbol.getRight());
    return suma;

  }
}
