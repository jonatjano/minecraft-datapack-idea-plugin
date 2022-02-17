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
WSPACE=[ ]
COMMENT="#"[^\r\n]*
PLAYER_PSEUDO=[a-zA-Z0-9_]{3,16}
REEL=-?[0-9]+(\.[0-9]+)?

%state COMMAND

%%

<YYINITIAL> {COMMENT}                                       { return McFunctionTypes.COMMENT; }

<YYINITIAL> "tp"|"teleport"                                 { yybegin(COMMAND); return McFunctionTypes.TELEPORT; }
<YYINITIAL> "kill"                                          { yybegin(COMMAND); return McFunctionTypes.KILL; }

<COMMAND> "eyes"|"feet"                                     { return McFunctionTypes.ENTITY_ANCHOR; }
<COMMAND> "entity"                                          { return McFunctionTypes.TOK_ENTITY; }
<COMMAND> "facing"                                          { return McFunctionTypes.TOK_FACING; }

<COMMAND> {REEL}{WSPACE}{REEL}{WSPACE}{REEL}                { return McFunctionTypes.VEC3; }
<COMMAND> \^{REEL}?{WSPACE}\^{REEL}?{WSPACE}\^{REEL}?       { return McFunctionTypes.VEC3; }
<COMMAND> \~{REEL}?{WSPACE}\~{REEL}?{WSPACE}\~{REEL}?       { return McFunctionTypes.VEC3; }
<COMMAND> {REEL}                                            { return McFunctionTypes.ROTATION; }

<COMMAND> "@a"                                              { return McFunctionTypes.MULTI_ENTITY; }
<COMMAND> {PLAYER_PSEUDO}                                   { return McFunctionTypes.ENTITY; }

<YYINITIAL> {CRLF}                                          { return McFunctionTypes.CRLF; }
<COMMAND> {CRLF}                                            { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }

{WSPACE}                                                    { return TokenType.WHITE_SPACE; }
[^]                                                         { return TokenType.BAD_CHARACTER; }