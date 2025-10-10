package main.ast.nodes;

public abstract class BlockItem extends ExtDec {
    private int tabs;

    public int getTabs() {
        return tabs;
    }

    public void setTabs(int tabs) {
        this.tabs = tabs;
    }

}
