package main.ast.nodes.Stmt;

import main.ast.nodes.BlockItem;
import main.visitor.IVisitor;

import java.util.ArrayList;

public class Compound extends Statement {
    private  ArrayList<BlockItem> blockItems = new ArrayList<>();

    public void addBlockItem(BlockItem bi)
    {
        this.blockItems.add(bi);
    }
    public ArrayList<BlockItem> getBlockItems()
    {
        return this.blockItems;
    }

    public void setBlockItems(ArrayList<BlockItem> blockItems) {
        this.blockItems = blockItems;
    }

    public void printNumOfStatements()
    {
        System.out.println(blockItems.size());
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
