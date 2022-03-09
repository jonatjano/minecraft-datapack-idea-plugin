package org.intellij.sdk.language.psi.impl;

import com.intellij.lang.ASTNode;
import org.intellij.sdk.language.psi.McFunctionResourceLocation;
import org.intellij.sdk.language.psi.McFunctionTypes;

import java.util.Arrays;

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