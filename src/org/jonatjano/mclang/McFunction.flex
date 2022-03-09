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
COMMENT=#[^\r\n]*

INTEGER_ONE=1
INTEGER_NOT_ONE=0|(1\d+)|([2-9]\d*)
U_FLOAT=\d+(\.\d+)?
INTEGER=[+-]?\d+
FLOAT=[+-]?{U_FLOAT}

PLAYER_PSEUDO=[a-zA-Z0-9_]{3,16}
UUID=\d{8}-\d{4}-\d{4}-\d{4}-\d{12}

%state COMMAND
%state STRING

%%

<YYINITIAL> {COMMENT}   { return McFunctionTypes.COMMENT; }
<YYINITIAL> ban         { yybegin(COMMAND); return McFunctionTypes.COMMAND_BAN; }
<YYINITIAL> function    { yybegin(COMMAND); return McFunctionTypes.COMMAND_FUNCTION; }
<YYINITIAL> gamemode    { yybegin(COMMAND); return McFunctionTypes.COMMAND_GAMEMODE; }
<YYINITIAL> item        { yybegin(COMMAND); return McFunctionTypes.COMMAND_ITEM; }
<YYINITIAL> kill        { yybegin(COMMAND); return McFunctionTypes.COMMAND_KILL; }
<YYINITIAL> tp|teleport { yybegin(COMMAND); return McFunctionTypes.COMMAND_TELEPORT; }

true|false|0b|1b  { return McFunctionTypes.BOOLEAN; }
{INTEGER_ONE}     { return McFunctionTypes.INTEGER_ONE; }
{INTEGER_NOT_ONE} { return McFunctionTypes.INTEGER_NOT_ONE; }
{INTEGER}         { return McFunctionTypes.INTEGER_SIGNED; }
{U_FLOAT}         { return McFunctionTypes.U_FLOAT_RULE; }
{FLOAT}           { return McFunctionTypes.FLOAT_SIGNED; }

\[ { return McFunctionTypes.SYMBOL_OPEN_SQUARE; }
\] { return McFunctionTypes.SYMBOL_CLOSE_SQUARE; }
\{ { return McFunctionTypes.SYMBOL_OPEN_CURLY; }
\} { return McFunctionTypes.SYMBOL_CLOSE_CURLY; }
\= { return McFunctionTypes.SYMBOL_EQUAL; }
\, { return McFunctionTypes.SYMBOL_COMMA; }
\. { return McFunctionTypes.SYMBOL_DOT; }
\! { return McFunctionTypes.SYMBOL_NEGATE; }
\^ { return McFunctionTypes.SYMBOL_CIRCONFLEX; }
\~ { return McFunctionTypes.SYMBOL_TILDE; }
\: { return McFunctionTypes.SYMBOL_COLON; }
\; { return McFunctionTypes.SYMBOL_SEMI_COLON; }
\/ { return McFunctionTypes.SYMBOL_SLASH; }
\# { return McFunctionTypes.SYMBOL_HASH; }

// strings
<COMMAND> \" { yybegin(STRING); return McFunctionTypes.SYMBOL_DUAL_QUOTE; }
<STRING> \" { yybegin(COMMAND); return McFunctionTypes.SYMBOL_DUAL_QUOTE; }
<COMMAND> ' { yybegin(STRING); return McFunctionTypes.SYMBOL_SINGLE_QUOTE; }
<STRING> ' { yybegin(COMMAND); return McFunctionTypes.SYMBOL_SINGLE_QUOTE; }
<STRING> [^\"'\\]+ { return McFunctionTypes.ANY_NO_QUOTE; }
<STRING> \\\\ { return McFunctionTypes.SYMBOL_CANCELLED_BACKSLASH; }
<STRING> \\\" { return McFunctionTypes.SYMBOL_CANCELLED_DUAL_QUOTE; }
<STRING> \\' { return McFunctionTypes.SYMBOL_CANCELLED_SINGLE_QUOTE; }

<COMMAND> entity  { return McFunctionTypes.KEYWORD_ENTITY; }
<COMMAND> facing  { return McFunctionTypes.KEYWORD_FACING; }
<COMMAND> clear   { return McFunctionTypes.KEYWORD_CLEAR; }
<COMMAND> give    { return McFunctionTypes.KEYWORD_GIVE; }
<COMMAND> modify  { return McFunctionTypes.KEYWORD_MODIFY; }
<COMMAND> replace { return McFunctionTypes.KEYWORD_REPLACE; }
<COMMAND> block   { return McFunctionTypes.KEYWORD_BLOCK; }
<COMMAND> with    { return McFunctionTypes.KEYWORD_WITH; }
<COMMAND> from    { return McFunctionTypes.KEYWORD_FROM; }

x|y|z          { return McFunctionTypes.SELECTOR_ARGUMENT_XYZ; }
distance       { return McFunctionTypes.SELECTOR_ARGUMENT_DISTANCE; }
d(x|y|z)       { return McFunctionTypes.SELECTOR_ARGUMENT_DXYZ; }
scores         { return McFunctionTypes.SELECTOR_ARGUMENT_SCORES; }
tag            { return McFunctionTypes.SELECTOR_ARGUMENT_TAG; }
team           { return McFunctionTypes.SELECTOR_ARGUMENT_TEAM; }
limit          { return McFunctionTypes.SELECTOR_ARGUMENT_LIMIT; }
sort           { return McFunctionTypes.SELECTOR_ARGUMENT_SORT; }
level          { return McFunctionTypes.SELECTOR_ARGUMENT_LEVEL; }
gamemode       { return McFunctionTypes.SELECTOR_ARGUMENT_GAMEMODE; }
name           { return McFunctionTypes.SELECTOR_ARGUMENT_NAME; }
(x|y)_rotation { return McFunctionTypes.SELECTOR_ARGUMENT_XY_ROTATION; }
type           { return McFunctionTypes.SELECTOR_ARGUMENT_TYPE; }
nbt            { return McFunctionTypes.SELECTOR_ARGUMENT_NBT; }
advancements   { return McFunctionTypes.SELECTOR_ARGUMENT_ADVANCEMENTS; }
predicate      { return McFunctionTypes.SELECTOR_ARGUMENT_PREDICATE; }

@p { return McFunctionTypes.TOK_AT_P; }
@r { return McFunctionTypes.TOK_AT_R; }
@a { return McFunctionTypes.TOK_AT_A; }
@e { return McFunctionTypes.TOK_AT_E; }
@s { return McFunctionTypes.TOK_AT_S; }

eyes|feet                             { return McFunctionTypes.ENUM_ENTITY_ANCHOR; }
spectator|survival|creative|adventure { return McFunctionTypes.ENUM_GAMEMODE; }
nearest|furthest|random|arbitrary     { return McFunctionTypes.ENUM_SORT; }

{UUID}              { return McFunctionTypes.UUID; }
{PLAYER_PSEUDO}     { return McFunctionTypes.PLAYER_PSEUDO; }
\w+                 { return McFunctionTypes.WORD_RULE; }

{CRLF}   { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }
{WSPACE} { return TokenType.WHITE_SPACE; }
[^]      { return TokenType.BAD_CHARACTER; }