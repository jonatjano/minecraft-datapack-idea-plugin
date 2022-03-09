package org.intellij.sdk.language.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.psi.FileViewProvider;
import com.intellij.openapi.fileTypes.FileType;
import org.jetbrains.annotations.NotNull;
import org.intellij.sdk.language.McFunctionFileType;
import org.intellij.sdk.language.McFunctionLanguage;

public class McFunctionFile extends PsiFileBase {
    public McFunctionFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, McFunctionLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return McFunctionFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return McFunctionFileType.INSTANCE.getName();
    }
}
