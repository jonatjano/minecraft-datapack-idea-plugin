package org.jonatjano.mclang;

import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class McFunctionColorSettingsPage implements ColorSettingsPage {

    private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{
        new AttributesDescriptor("Keyword", McFunctionSyntaxHighlighter.KEYWORD),
        new AttributesDescriptor("Enumeration", McFunctionSyntaxHighlighter.ENUM),
        new AttributesDescriptor("String", McFunctionSyntaxHighlighter.STRING),
        new AttributesDescriptor("Comment", McFunctionSyntaxHighlighter.COMMENT),
        new AttributesDescriptor("Number", McFunctionSyntaxHighlighter.NUMBER),
        new AttributesDescriptor("Command", McFunctionSyntaxHighlighter.COMMAND),
        new AttributesDescriptor("Bad character", McFunctionSyntaxHighlighter.BAD_CHARACTER)
    };

    @Nullable
    @Override
    public Icon getIcon() {
        return McFunctionIcons.FILE;
    }

    @NotNull
    @Override
    public SyntaxHighlighter getHighlighter() {
        return new McFunctionSyntaxHighlighter();
    }

    @NotNull
    @Override
    public String getDemoText() {
        return "# comments starts with #.\n" +
            "teleport 1 1 1 facing entity jonatjano feet\n" +
            "error";
    }

    @Nullable
    @Override
    public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
        return null;
    }

    @Override
    public AttributesDescriptor[] getAttributeDescriptors() {
        return DESCRIPTORS;
    }

    @Override
    public ColorDescriptor[] getColorDescriptors() {
        return ColorDescriptor.EMPTY_ARRAY;
    }

    @NotNull
    @Override
    public String getDisplayName() {
        return McFunctionFileType.INSTANCE.getName();
    }

}
