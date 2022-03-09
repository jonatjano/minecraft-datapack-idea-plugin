package org.intellij.sdk.language;

import com.intellij.lexer.FlexAdapter;

public class McFunctionLexerAdapter extends FlexAdapter {
    public McFunctionLexerAdapter() {
        super(new McFunctionLexer(null));
    }
}
