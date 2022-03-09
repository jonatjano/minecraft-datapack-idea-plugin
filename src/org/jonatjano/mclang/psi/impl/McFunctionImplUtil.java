package org.jonatjano.mclang.psi.impl;

import com.intellij.lang.ASTNode;
import org.jonatjano.mclang.psi.McFunctionResourceLocation;
import org.jonatjano.mclang.psi.McFunctionTypes;

import java.util.Arrays;
import java.util.List;

public class McFunctionImplUtil {
    public static String getNamespace(McFunctionResourceLocation element) {
        ASTNode colonNode = element.getNode().findChildByType(McFunctionTypes.SYMBOL_COLON);
        if (colonNode != null) {
            // IMPORTANT: Convert embedded escaped spaces to simple spaces
            return colonNode.getTreePrev().getText().replaceAll("\\\\ ", " ");
        } else {
            return "minecraft";
        }
    }

    public static String getPath(McFunctionResourceLocation element) {
        ASTNode colonNode = element.getNode().findChildByType(McFunctionTypes.SYMBOL_COLON);
        ASTNode[] nodes = element.getNode().getChildren(null);
        if (colonNode != null) {
            nodes = Arrays.stream(nodes).skip(2).toArray(ASTNode[]::new);
        }

        StringBuilder path = new StringBuilder();
        for (ASTNode node : nodes) {
            path.append(node.getText());
        }
        // IMPORTANT: Convert embedded escaped spaces to simple spaces
        return path.toString().replaceAll("\\\\ ", " ");
    }
}