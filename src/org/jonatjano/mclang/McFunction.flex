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

\[ { return McFunctionTypes.TOK_OPEN_SQUARE; }
\] { return McFunctionTypes.TOK_CLOSE_SQUARE; }
\{ { return McFunctionTypes.TOK_OPEN_CURLY; }
\} { return McFunctionTypes.TOK_CLOSE_CURLY; }
\= { return McFunctionTypes.TOK_EQUAL; }
\, { return McFunctionTypes.TOK_COMMA; }
\. { return McFunctionTypes.TOK_DOT; }
\! { return McFunctionTypes.TOK_NEGATE; }
\^ { return McFunctionTypes.TOK_CIRCONFLEX; }
\~ { return McFunctionTypes.TOK_TILDE; }
\: { return McFunctionTypes.TOK_COLON; }
\; { return McFunctionTypes.TOK_SEMI_COLON; }
\/ { return McFunctionTypes.TOK_SLASH; }
\# { return McFunctionTypes.TOK_HASH; }

// strings
<COMMAND> \" { yybegin(STRING); return McFunctionTypes.TOK_DUAL_QUOTE; }
<STRING> \" { yybegin(COMMAND); return McFunctionTypes.TOK_DUAL_QUOTE; }
<COMMAND> ' { yybegin(STRING); return McFunctionTypes.TOK_SINGLE_QUOTE; }
<STRING> ' { yybegin(COMMAND); return McFunctionTypes.TOK_SINGLE_QUOTE; }
<STRING> [^\"'\\]+ { return McFunctionTypes.ANY_NO_QUOTE; }
<STRING> \\\\ { return McFunctionTypes.TOK_CANCELLED_BACKSLASH; }
<STRING> \\\" { return McFunctionTypes.TOK_CANCELLED_DUAL_QUOTE; }
<STRING> \\' { return McFunctionTypes.TOK_CANCELLED_SINGLE_QUOTE; }

<COMMAND> entity  { return McFunctionTypes.KEY_ENTITY; }
<COMMAND> facing  { return McFunctionTypes.KEY_FACING; }
<COMMAND> clear   { return McFunctionTypes.KEY_CLEAR; }
<COMMAND> give    { return McFunctionTypes.KEY_GIVE; }
<COMMAND> modify  { return McFunctionTypes.KEY_MODIFY; }
<COMMAND> replace { return McFunctionTypes.KEY_REPLACE; }
<COMMAND> block   { return McFunctionTypes.KEY_BLOCK; }
<COMMAND> with    { return McFunctionTypes.KEY_WITH; }
<COMMAND> from    { return McFunctionTypes.KEY_FROM; }

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

eyes|feet                             { return McFunctionTypes.ENTITY_ANCHOR; }
spectator|survival|creative|adventure { return McFunctionTypes.GAMEMODE_KEYWORDS; }
nearest|furthest|random|arbitrary     { return McFunctionTypes.SORT_KEYWORDS; }

{UUID}              { return McFunctionTypes.UUID; }
{PLAYER_PSEUDO}     { return McFunctionTypes.PLAYER_PSEUDO; }
\w+                 { return McFunctionTypes.WORD_RULE; }

{CRLF}   { yybegin(YYINITIAL); return McFunctionTypes.CRLF; }
{WSPACE} { return TokenType.WHITE_SPACE; }
[^]      { return TokenType.BAD_CHARACTER; }