package refactoring_ejericio3.ejercicio3;

public abstract class Ring {
    private int idx;

    public Ring(){
        idx=0;
    }

    protected abstract int getLength();


    public int nextIndex(){
        if(idx >= getLength())
            idx=0;
        return idx++;
    }
}
