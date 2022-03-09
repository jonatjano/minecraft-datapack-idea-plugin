package org.jonatjano.mclang.psi;

import com.intellij.psi.tree.IElementType;
import org.jonatjano.mclang.McFunctionLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class McFunctionElementType extends IElementType {
    public McFunctionElementType(@NotNull @NonNls String debugName) {
        super(debugName, McFunctionLanguage.INSTANCE);
    }
}
