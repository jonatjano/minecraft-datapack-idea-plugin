package org.jonatjano.mclang;

import com.intellij.lang.Language;

public class McFunctionLanguage extends Language {

    public static final McFunctionLanguage INSTANCE = new McFunctionLanguage();

    private McFunctionLanguage() {
        super("Minecraft function");
    }
}