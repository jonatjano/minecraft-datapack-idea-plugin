package org.jonatjano.mclang;

import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.HighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;
import org.jonatjano.mclang.psi.McFunctionTypes;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;

public class McFunctionSyntaxHighlighter extends SyntaxHighlighterBase {

    public static final TextAttributesKey SEPARATOR =
            createTextAttributesKey("SIMPLE_SEPARATOR", DefaultLanguageHighlighterColors.OPERATION_SIGN);
    public static final TextAttributesKey CONSTANT =
            createTextAttributesKey("SIMPLE_KEY", DefaultLanguageHighlighterColors.CONSTANT);
    public static final TextAttributesKey VALUE =
            createTextAttributesKey("SIMPLE_VALUE", DefaultLanguageHighlighterColors.STRING);
    public static final TextAttributesKey COMMENT =
            createTextAttributesKey("SIMPLE_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
    public static final TextAttributesKey NUMBER =
            createTextAttributesKey("SIMPLE_BAD_CHARACTER", DefaultLanguageHighlighterColors.NUMBER);
    public static final TextAttributesKey KEYWORD =
            createTextAttributesKey("SIMPLE_BAD_CHARACTER", DefaultLanguageHighlighterColors.KEYWORD);
    public static final TextAttributesKey BAD_CHARACTER =
            createTextAttributesKey("SIMPLE_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);

    private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[]{BAD_CHARACTER};
    private static final TextAttributesKey[] SEPARATOR_KEYS = new TextAttributesKey[]{SEPARATOR};
    private static final TextAttributesKey[] CONSTANT_KEYS = new TextAttributesKey[]{CONSTANT};
    private static final TextAttributesKey[] VALUE_KEYS = new TextAttributesKey[]{VALUE};
    private static final TextAttributesKey[] NUMBER_KEYS = new TextAttributesKey[]{NUMBER};
    private static final TextAttributesKey[] KEYWORD_KEYS = new TextAttributesKey[]{KEYWORD};
    private static final TextAttributesKey[] COMMENT_KEYS = new TextAttributesKey[]{COMMENT};
    private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];

    @NotNull
    @Override
    public Lexer getHighlightingLexer() {
        return new McFunctionLexerAdapter();
    }

    @NotNull
    @Override
    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
        if (tokenType.equals(McFunctionTypes.COMMENT)) {
            return COMMENT_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.KILL) ||
            tokenType.equals(McFunctionTypes.TELEPORT)) {
            return KEYWORD_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.TOK_FACING) ||
            tokenType.equals(McFunctionTypes.TOK_ENTITY)) {
            return SEPARATOR_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.ENTITY_ANCHOR)) {
            return CONSTANT_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.ENTITY) ||
            tokenType.equals(McFunctionTypes.MULTI_ENTITY)) {
            return VALUE_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.ROTATION) ||
            tokenType.equals(McFunctionTypes.VEC3)) {
            return NUMBER_KEYS;
        }
        if (tokenType.equals(TokenType.BAD_CHARACTER)) {
            return BAD_CHAR_KEYS;
        }
        return EMPTY_KEYS;
    }

}