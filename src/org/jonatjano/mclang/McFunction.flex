package org.jonatjano.mclang;

import com.intellij.psi.tree.IElementType;
import com.intellij.psi.TokenType;
import com.intellij.lexer.FlexLexer;
import org.jonatjano.mclang.psi.McFunctionTypes;

%%

%class McFunctionLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[ ]
COMMENT="#"[^\r\n]*
ENTITY_NAME=[^ \r\n]+

%state WAITING_VALUE

%%

<YYINITIAL> {COMMENT}                                       { yybegin(YYINITIAL); return McFunctionTypes.COMMENT; }

<WAITING_VALUE> {WHITE_SPACE}                               { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> "test"                                          { yybegin(YYINITIAL); return McFunctionTypes.TEST; }
<YYINITIAL> "tp"|"teleport"                                 { yybegin(YYINITIAL); return McFunctionTypes.TELEPORT; }

<YYINITIAL> {ENTITY_NAME}                                   { yybegin(YYINITIAL); return McFunctionTypes.ENTITY; }

<YYINITIAL> {CRLF}                                          { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }

{WHITE_SPACE}                                               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }