package org.jonatjano.mclang;

import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.HighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;
import org.jonatjano.mclang.psi.McFunctionTokenType;
import org.jonatjano.mclang.psi.McFunctionTypes;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;

public class McFunctionSyntaxHighlighter extends SyntaxHighlighterBase {

    public static final TextAttributesKey KEYWORD =
            createTextAttributesKey("MC_FUNCTION_KEYWORD", DefaultLanguageHighlighterColors.KEYWORD);
    public static final TextAttributesKey ENUM =
            createTextAttributesKey("MC_FUNCTION_CONSTANT", DefaultLanguageHighlighterColors.CONSTANT);
    public static final TextAttributesKey STRING =
            createTextAttributesKey("MC_FUNCTION_STRING", DefaultLanguageHighlighterColors.STRING);
    public static final TextAttributesKey COMMENT =
            createTextAttributesKey("MC_FUNCTION_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
    public static final TextAttributesKey NUMBER =
            createTextAttributesKey("MC_FUNCTION_NUMBER", DefaultLanguageHighlighterColors.NUMBER);
    public static final TextAttributesKey COMMAND =
            createTextAttributesKey("MC_FUNCTION_COMMAND", DefaultLanguageHighlighterColors.KEYWORD);
    public static final TextAttributesKey SYMBOL =
            createTextAttributesKey("MC_FUNCTION_SYMBOL", DefaultLanguageHighlighterColors.OPERATION_SIGN);
    public static final TextAttributesKey CURLY_BRACKETS =
            createTextAttributesKey("MC_FUNCTION_CURLY_BRACKETS", DefaultLanguageHighlighterColors.BRACES);
    public static final TextAttributesKey SQUARE_BRACKETS =
            createTextAttributesKey("MC_FUNCTION_SQUARE_BRACKETS", DefaultLanguageHighlighterColors.BRACKETS);
    public static final TextAttributesKey SELECTOR_ARGUMENT =
            createTextAttributesKey("MC_FUNCTION_SELECTOR_ARGUMENT", DefaultLanguageHighlighterColors.INSTANCE_METHOD);
    public static final TextAttributesKey BAD_CHARACTER =
            createTextAttributesKey("MC_FUNCTION_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);

    private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[]{BAD_CHARACTER};
    private static final TextAttributesKey[] KEYWORD_KEYS = new TextAttributesKey[]{KEYWORD};
    private static final TextAttributesKey[] ENUM_KEYS = new TextAttributesKey[]{ENUM};
    private static final TextAttributesKey[] STRING_KEYS = new TextAttributesKey[]{STRING};
    private static final TextAttributesKey[] NUMBER_KEYS = new TextAttributesKey[]{NUMBER};
    private static final TextAttributesKey[] COMMAND_KEYS = new TextAttributesKey[]{COMMAND};
    private static final TextAttributesKey[] COMMENT_KEYS = new TextAttributesKey[]{COMMENT};
    private static final TextAttributesKey[] SYMBOL_KEYS = new TextAttributesKey[]{SYMBOL};
    private static final TextAttributesKey[] CURLY_BRACKETS_KEYS = new TextAttributesKey[]{CURLY_BRACKETS};
    private static final TextAttributesKey[] SQUARE_BRACKETS_KEYS = new TextAttributesKey[]{SQUARE_BRACKETS};
    private static final TextAttributesKey[] SELECTOR_ARGUMENT_KEYS = new TextAttributesKey[]{SELECTOR_ARGUMENT};
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
        if (tokenType.equals(McFunctionTypes.STRING)) {
            return STRING_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.SYMBOL_OPEN_CURLY) ||
            tokenType.equals(McFunctionTypes.SYMBOL_CLOSE_CURLY)) {
            return CURLY_BRACKETS_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.SYMBOL_OPEN_SQUARE) ||
            tokenType.equals(McFunctionTypes.SYMBOL_CLOSE_SQUARE)) {
            return SQUARE_BRACKETS_KEYS;
        }
        if (tokenType.equals(McFunctionTypes.INTEGER_ONE) ||
            tokenType.equals(McFunctionTypes.INTEGER_NOT_ONE) ||
            tokenType.equals(McFunctionTypes.INTEGER_SIGNED) ||
            tokenType.equals(McFunctionTypes.U_FLOAT_RULE) ||
            tokenType.equals(McFunctionTypes.FLOAT_SIGNED)
        ) {
            return NUMBER_KEYS;
        }
        if (tokenType.equals(TokenType.BAD_CHARACTER)) {
            return BAD_CHAR_KEYS;
        }
        if (tokenType.toString().startsWith("McFunctionTokenType.COMMAND")) {
            return COMMAND_KEYS;
        }
        if (tokenType.toString().startsWith("McFunctionTokenType.ENUM")) {
            return ENUM_KEYS;
        }
        if (tokenType.toString().startsWith("McFunctionTokenType.KEYWORD")) {
            return KEYWORD_KEYS;
        }
        if (tokenType.toString().startsWith("McFunctionTokenType.SYMBOL")) {
            return SYMBOL_KEYS;
        }
        if (tokenType.toString().startsWith("McFunctionTokenType.SELECTOR_ARGUMENT")) {
            return SELECTOR_ARGUMENT_KEYS;
        }
        return EMPTY_KEYS;
    }

}