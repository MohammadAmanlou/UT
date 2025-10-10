package main.OrderConstructor;

import main.ast.nodes.*;
import main.ast.nodes.Stmt.Compound;
import main.ast.nodes.Stmt.IterationStmt.*;
import main.ast.nodes.Stmt.SelectionStmt.*;
import org.antlr.v4.runtime.misc.Pair;

import java.util.*;

public class OrderConstructor {

    private final Program root;
    private final List<FuncDef> functionList = new ArrayList<>();

    public OrderConstructor(Program root) {
        this.root = root;
    }

    public void compile() {
        extractFunctions();
        for (FuncDef func : functionList) {
            recompose(func.getCompound());
        }
    }

    private void extractFunctions() {
        for (ExtDec ext : root.getTranslationUnit().getExternalDeclarations()) {
            if (ext instanceof FuncDef fd) {
                functionList.add(fd);
            }
        }
    }

    private void recompose(Compound node) {
        if (node == null) return;

        List<BlockItem> original = node.getBlockItems();
        node.setBlockItems(new ArrayList<>());
        node.setTabs(0);
        Deque<Pair<Compound, BlockItem>> stack = new ArrayDeque<>();
        stack.push(new Pair<>(node, node));

        for (BlockItem current : original) {
            parseItem(current, stack);
        }
    }

    private void parseItem(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        if (itm instanceof IF) handleConditional(itm, ctx);
        else if (itm instanceof Elif) attachElif(itm, ctx);
        else if (itm instanceof Else) attachElse(itm, ctx);
        else if (itm instanceof For) loopHandler(itm, ctx);
        else if (itm instanceof While) loopHandler(itm, ctx);
        else if (itm instanceof DoWhile) doLoopHandler(itm, ctx);
        else genericAttach(itm, ctx);
    }

    private void handleConditional(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        if (ctx.isEmpty()) return;
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ref.a.addBlockItem(itm);
            ctx.push(new Pair<>(((IF) itm).getCompoundStatement(), itm));
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }

    private void attachElif(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        if (ctx.isEmpty()) return;
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ctx.push(new Pair<>(((Elif) itm).getCompoundStatement(), itm));
        } else {
            patchElif(itm, ctx);
        }
    }

    private void patchElif(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        var ref = ctx.peek();
        if (itm.getTabs() == ref.b.getTabs()) {
            if (ref.b instanceof IF cond) {
                cond.setElif((Elif) itm);
            } else if (ref.b instanceof Elif elif) {
                elif.setElif((Elif) itm);
            }
            ctx.pop();
            parseItem(itm, ctx);
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }

    private void attachElse(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        if (ctx.isEmpty()) return;
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ctx.push(new Pair<>(((Else) itm).getCompoundStatement(), itm));
        } else {
            patchElse(itm, ctx);
        }
    }

    private void patchElse(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        var ref = ctx.peek();
        if (itm.getTabs() == ref.b.getTabs()) {
            if (ref.b instanceof IF cond) {
                cond.setElse((Else) itm);
            } else if (ref.b instanceof Elif elif) {
                elif.setElse((Else) itm);
            }
            ctx.pop();
            parseItem(itm, ctx);
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }

    private void loopHandler(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ref.a.addBlockItem(itm);
            Compound body = itm instanceof For ? ((For) itm).getCompoundStatement() : ((While) itm).getCompoundStatement();
            ctx.push(new Pair<>(body, itm));
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }

    private void doLoopHandler(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ref.a.addBlockItem(itm);
            recompose(((DoWhile) itm).getStatement());
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }

    private void genericAttach(BlockItem itm, Deque<Pair<Compound, BlockItem>> ctx) {
        var ref = ctx.peek();
        if (itm.getTabs() > ref.b.getTabs()) {
            ref.a.addBlockItem(itm);
        } else {
            ctx.pop();
            parseItem(itm, ctx);
        }
    }
}
