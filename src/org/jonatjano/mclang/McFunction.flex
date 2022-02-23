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

INTEGER=[+-]?\d+
U_FLOAT=\d+(\.\d+)?
FLOAT=[+-]?{U_FLOAT}

INTEGER_RANGE=({INTEGER}\.\.{INTEGER}|{INTEGER}\.\.|\.\.{INTEGER})
U_FLOAT_RANGE=({U_FLOAT}\.\.{U_FLOAT}|{U_FLOAT}\.\.|\.\.{U_FLOAT})
FLOAT_RANGE=({FLOAT}\.\.{FLOAT}|{FLOAT}\.\.|\.\.{FLOAT})
FRACTIONAL={FLOAT}\/{FLOAT}

PLAYER_PSEUDO=[a-zA-Z0-9_]{3,16}
UUID=\d{8}-\d{4}-\d{4}-\d{4}-\d{12}
RESOURCE_LOCATION=(\w+:)?[\w/]+

%state COMMAND

%%

<YYINITIAL> {COMMENT}                                       { return McFunctionTypes.COMMENT; }

true|false|0b|1b                                            { return McFunctionTypes.BOOLEAN; }

<YYINITIAL> tp|teleport                                     { yybegin(COMMAND); return McFunctionTypes.COMMAND_TELEPORT; }
<YYINITIAL> kill                                            { yybegin(COMMAND); return McFunctionTypes.COMMAND_KILL; }

<COMMAND> entity                                            { return McFunctionTypes.TOK_ENTITY; }
<COMMAND> facing                                            { return McFunctionTypes.TOK_FACING; }

<COMMAND> eyes|feet                                         { return McFunctionTypes.ENTITY_ANCHOR; }

<COMMAND> @p { return McFunctionTypes.TOK_AT_P; }
<COMMAND> @r { return McFunctionTypes.TOK_AT_R; }
<COMMAND> @a { return McFunctionTypes.TOK_AT_A; }
<COMMAND> @e { return McFunctionTypes.TOK_AT_E; }
<COMMAND> @s { return McFunctionTypes.TOK_AT_S; }

{CRLF}                                                      { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }
{WSPACE}                                                    { return TokenType.WHITE_SPACE; }
[^]                                                         { return TokenType.BAD_CHARACTER; }