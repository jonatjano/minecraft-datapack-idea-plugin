package org.jonatjano.mclang;

import com.intellij.lexer.FlexAdapter;

public class McFunctionLexerAdapter extends FlexAdapter {
    public McFunctionLexerAdapter() {
        super(new McFunctionLexer(null));
    }
}
