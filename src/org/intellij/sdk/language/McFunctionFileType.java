package org.intellij.sdk.language;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class McFunctionFileType extends LanguageFileType {
    public static final McFunctionFileType INSTANCE = new McFunctionFileType();

    private McFunctionFileType() {
        super(McFunctionLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public String getName() {
        return "Minecraft Function";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Minecraft Function file";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "mcfunction";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return McFunctionIcons.FILE;
    }

}